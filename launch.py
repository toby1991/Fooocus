import os
import sys

from modules.model_loader import load_file_from_url
from modules.path import modelfile_path, lorafile_path, vae_approx_path, fooocus_expansion_path
from prepare_environments import prepare_environment

REINSTALL_ALL = False



model_filenames = [
    ('sd_xl_base_1.0_0.9vae.safetensors',
     'https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_base_1.0_0.9vae.safetensors'),
    ('sd_xl_refiner_1.0_0.9vae.safetensors',
     'https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0/resolve/main/sd_xl_refiner_1.0_0.9vae.safetensors')
]

lora_filenames = [
    ('sd_xl_offset_example-lora_1.0.safetensors',
     'https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/sd_xl_offset_example-lora_1.0.safetensors')
]

vae_approx_filenames = [
    ('taesdxl_decoder.pth',
     'https://huggingface.co/lllyasviel/misc/resolve/main/taesdxl_decoder.pth')
]


def download_models():
    for file_name, url in model_filenames:
        load_file_from_url(url=url, model_dir=modelfile_path, file_name=file_name)
    for file_name, url in lora_filenames:
        load_file_from_url(url=url, model_dir=lorafile_path, file_name=file_name)
    for file_name, url in vae_approx_filenames:
        load_file_from_url(url=url, model_dir=vae_approx_path, file_name=file_name)

    load_file_from_url(
        url='https://huggingface.co/lllyasviel/misc/resolve/main/fooocus_expansion.bin',
        model_dir=fooocus_expansion_path,
        file_name='pytorch_model.bin'
    )

    return


def clear_comfy_args():
    argv = sys.argv
    sys.argv = [sys.argv[0]]
    import comfy.cli_args
    sys.argv = argv


def cuda_malloc():
    import cuda_malloc


#no need prepare for docker env
#prepare_environment()

clear_comfy_args()
# cuda_malloc()

download_models()

from webui import *
