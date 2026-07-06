import torch, base64, io
import runpod
from diffusers import ZImagePipeline

# 模型只在 worker 啟動時載一次（冷啟動），之後常駐
print("Loading Z-Image...")
pipe = ZImagePipeline.from_pretrained(
    "/runpod-volume/ComfyUI/models/Z-Image-Turbo",  # 注意：Serverless 掛載點是 /runpod-volume
    torch_dtype=torch.bfloat16,
    low_cpu_mem_usage=False,
)
pipe.to("cuda")
print("Model ready.")

def handler(event):
    inp = event.get("input", {})
    prompt = inp.get("prompt", "")
    if not prompt.strip():
        return {"error": "prompt is required"}
    width  = int(inp.get("width", 1024))
    height = int(inp.get("height", 1024))
    seed   = int(inp.get("seed", 42))

    image = pipe(
        prompt=prompt,
        height=height, width=width,
        num_inference_steps=9,
        guidance_scale=0.0,
        generator=torch.Generator("cuda").manual_seed(seed),
    ).images[0]

    buf = io.BytesIO()
    image.save(buf, format="PNG")
    img_b64 = base64.b64encode(buf.getvalue()).decode()
    return {"image_base64": img_b64, "seed": seed, "width": width, "height": height}


runpod.serverless.start({"handler": handler})
