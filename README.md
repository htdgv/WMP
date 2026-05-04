# LD-WMP: Latent Diffusion World Model-based Perception for Visual Legged Locomotion in Robot Parkour Learning

## Environment Setup
```bash
# Create a new python virtual env with python 3.6, 3.7 or 3.8 (3.8 recommended)
conda create -n ld-wmp python=3.8 -y
conda activate ld-wmp
```

## Training
```bash
# If run on GPU
python legged_gym/scripts/train.py --task=a1_amp --headless --sim_device=cuda:0
```
Training takes about 23G GPU memory, and at least 10k iterations recommended.

## Visualization
**Please make sure you have trained the WMP before**
```bash
# If run on GPU
python legged_gym/scripts/play.py --task=a1_amp --sim_device=cuda:0 --terrain=climb
```
