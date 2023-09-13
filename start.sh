#!/bin/bash

python launch.py --share --listen=0.0.0.0 --port=7860

# macos
#PYTORCH_ENABLE_MPS_FALLBACK=1 python launch.py --share --listen=0.0.0.0 --port=7860
