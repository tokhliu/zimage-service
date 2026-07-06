FROM runpod/pytorch:1.0.2-cu1281-torch280-ubuntu2404
WORKDIR /app
RUN pip install --no-cache-dir runpod transformers accelerate
RUN pip install --no-cache-dir --no-deps "git+https://github.com/huggingface/diffusers.git"
RUN pip install --no-cache-dir safetensors huggingface_hub regex requests pillow numpy filelock

COPY rp_handler.py /app/rp_handler.py
CMD ["python", "-u", "rp_handler.py"]
