#!/bin/bash


#export http_proxy="http://127.0.0.1:8080"
#export https_proxy="http://127.0.0.1:8080"

# define
download_if_not_exists() {
    local FILEPATH="$1"
    local URL="$2"
    local FILENAME=$(basename "$FILEPATH")

    if [ ! -f "$FILEPATH" ]; then
        echo "Downloading $FILENAME from $URL..."
        #wget -O- -e use_proxy=yes "$URL" -O "$FILEPATH"
        wget -O- -e use_proxy=no "$URL" -O "$FILEPATH"
    else
        echo "File $FILENAME already exists at $FILEPATH!"
    fi
}

# download
sleep 5

download_if_not_exists "/app/Fooocus/models/checkpoints/sd_xl_base_1.0_0.9vae.safetensors" "https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0_0.9vae.safetensors"
download_if_not_exists "/app/Fooocus/models/checkpoints/sd_xl_refiner_1.0_0.9vae.safetensors" "https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0_0.9vae.safetensors"

mkdir -p /app/Fooocus/models/loras
download_if_not_exists "/app/Fooocus/models/loras/sd_xl_offset_example-lora_1.0.safetensors" "https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_offset_example-lora_1.0.safetensors"
mkdir -p /app/Fooocus/models/prompt_expansion/fooocus_expansion
download_if_not_exists "/app/Fooocus/models/prompt_expansion/fooocus_expansion/pytorch_model.bin" "https://huggingface.co/lllyasviel/misc/resolve/main/fooocus_expansion.bin"
