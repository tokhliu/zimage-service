FROM runpod/pytorch:1.0.7-cu1290-torch280-ubuntu2404

WORKDIR /app
RUN pip install --no-cache-dir \
    runpod \
    git+https://github.com/huggingface/diffusers \
    transformers accelerate

COPY rp_handler.py /app/rp_handler.py
CMD ["python", "-u", "rp_handler.py"]
