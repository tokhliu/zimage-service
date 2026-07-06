# rebuild
FROM runpod/pytorch:1.0.2-cu1281-torch280-ubuntu2404
# rebuild
WORKDIR /app
# rebuild
RUN pip install --no-cache-dir runpod
RUN pip install --no-cache-dir transformers accelerate
RUN pip install --no-cache-dir "git+https://github.com/huggingface/diffusers.git"

COPY rp_handler.py /app/rp_handler.py
CMD ["python", "-u", "rp_handler.py"]
