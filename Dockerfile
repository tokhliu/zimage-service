FROM runpod/pytorch:1.0.2-cu1281-torch280-ubuntu2404

WORKDIR /app

# 建一个 constraint 档，锁住 torch 系列不让 pip 重装（避免拉几 GB CUDA 套件爆空间）
RUN echo "torch==2.8.0" > /tmp/constraints.txt && \
    echo "torchvision" >> /tmp/constraints.txt && \
    echo "triton" >> /tmp/constraints.txt

RUN pip install --no-cache-dir -c /tmp/constraints.txt \
    runpod \
    "git+https://github.com/huggingface/diffusers.git" \
    transformers accelerate

COPY rp_handler.py /app/rp_handler.py
CMD ["python", "-u", "rp_handler.py"]
