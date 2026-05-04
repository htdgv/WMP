# LD-WMP: Latent Diffusion World Model-based Perception for Visual Legged Locomotion in Robot Parkour Learning

## Environment Setup
```bash
# Create a new python virtual env with python 3.6, 3.7 or 3.8 (3.8 recommended)
conda create -n ld-wmp python=3.8 -y
conda activate ld-wmp

# if torch can be run on your machine, then install pytorch:
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu117
# or
pip install torch==1.13.1+cu117 torchvision==0.14.1+cu117 \
--extra-index-url https://download.pytorch.org/whl/cu117
# otherwise: torchnightly
conda install pytorch torchvision torchaudio pytorch-cuda=11.7 -c pytorch-nightly -c nvidia
# However, if all are not working, run on CPU on existing env 
# to check for Pytorch runtime version
python -c "import torch; print(torch.__version__); print(torch.version.cuda)"

# Suppose that isaac gym is installed in the current directory, then run
cd isaacgym/python && pip install -e .

# Install other packages:
sudo apt-get install build-essential --fix-missing && \
sudo apt-get install ninja-build && \
pip install setuptools==59.5.0 && \
pip install ruamel_yaml==0.17.4 && \
sudo apt install libgl1-mesa-glx -y && \
pip install opencv-contrib-python && \
pip install -r requirements.txt
```


## Training
```bash
# If run on GPU
python legged_gym/scripts/train.py --task=a1_amp --headless --sim_device=cuda:0
# If run on CPU
python legged_gym/scripts/train.py --task=a1_amp --headless --sim_device=cpu
```
Training takes about 23G GPU memory, and at least 10k iterations recommended.

## Visualization
**Please make sure you have trained the WMP before**
```bash
# If run on GPU
python legged_gym/scripts/play.py --task=a1_amp --sim_device=cuda:0 --terrain=climb
# If run on CPU
python legged_gym/scripts/play.py --task=a1_amp --sim_device=cpu --terrain=climb
```
