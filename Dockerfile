FROM runpod/pytorch:2.8.0-py3.12-cuda12.8.1-devel-ubuntu24.04

WORKDIR /app
RUN pip install --no-cache-dir \
    runpod \
    git+https://github.com/huggingface/diffusers \
    transformers accelerate

COPY rp_handler.py /app/rp_handler.py
CMD ["python", "-u", "rp_handler.py"]
