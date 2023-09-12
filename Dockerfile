# ################################################################
# FROM bitnami/git:2.42.0-debian-11-r20 as coder

# RUN git clone --no-checkout https://github.com/lllyasviel/Fooocus.git /app/Fooocus
# RUN cd /app/Fooocus && git checkout tags/1.0.35


# ################################################################
# FROM alpine/httpie:3.2.2 as downloader

# RUN mkdir -p /models/checkpoints
# #RUN http -d https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0_0.9vae.safetensors -o /app/Fooocus/models/checkpoints/sd_xl_base_1.0_0.9vae.safetensors
# #RUN http -d https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0_0.9vae.safetensors -o /app/Fooocus/models/checkpoints/sd_xl_refiner_1.0_0.9vae.safetensors
# COPY models/checkpoints/sd_xl_base_1.0_0.9vae.safetensors /models/checkpoints/sd_xl_base_1.0_0.9vae.safetensors
# COPY models/checkpoints/sd_xl_refiner_1.0_0.9vae.safetensors /models/checkpoints/sd_xl_refiner_1.0_0.9vae.safetensors


################################################################
FROM python:3.9.18-bullseye

#RUN cd /app/Fooocus && git checkout tags/1.0.35

# RUN wget https://github.com/lllyasviel/Fooocus/archive/refs/tags/1.0.35.tar.gz -O /fooocus.tar.gz
# RUN rm /fooocus.tar.gz

#RUN wget https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0_0.9vae.safetensors -O /app/Fooocus/models/checkpoints/sd_xl_base_1.0_0.9vae.safetensors
#RUN wget https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0_0.9vae.safetensors -O /app/Fooocus/models/checkpoints/sd_xl_refiner_1.0_0.9vae.safetensors




RUN git clone --depth=1 https://github.com/lllyasviel/Fooocus.git /app/Fooocus

#RUN echo "torchvision==0.15.2" >> /app/Fooocus/requirements_versions.txt

WORKDIR /app/Fooocus

RUN pip install -r requirements_versions.txt

RUN mkdir -p /app/Fooocus/models/loras && wget https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_offset_example-lora_1.0.safetensors -O /app/Fooocus/models/loras/sd_xl_offset_example-lora_1.0.safetensors
RUN mkdir -p /app/Fooocus/models/prompt_expansion/fooocus_expansion && wget https://huggingface.co/lllyasviel/misc/resolve/main/fooocus_expansion.bin -O /app/Fooocus/models/prompt_expansion/fooocus_expansion/pytorch_model.bin

RUN wget https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0_0.9vae.safetensors -O /app/Fooocus/models/checkpoints/sd_xl_base_1.0_0.9vae.safetensors
RUN wget https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0_0.9vae.safetensors -O /app/Fooocus/models/checkpoints/sd_xl_refiner_1.0_0.9vae.safetensors
# COPY models/checkpoints/sd_xl_base_1.0_0.9vae.safetensors /app/Fooocus/models/checkpoints/sd_xl_base_1.0_0.9vae.safetensors
# COPY models/checkpoints/sd_xl_refiner_1.0_0.9vae.safetensors /tmpdir/models/checkpoints/sd_xl_refiner_1.0_0.9vae.safetensors

EXPOSE 7860

#RUN python launch.py --listen 8888

# docker run --rm -it -p 80:7860 fooocus:v1.0.35 python launch.py
