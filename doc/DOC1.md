# Documentation

This document records changes made to fit with our current server and environment. Please refer to the original README.md for more details on commands and instructions.

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

# Several package might be missing. In that case, if missing, select and run the corresponding command below: 
pip install tensorboard
pip install six
pip install pybullet
pip install ruamel.yaml
pip install matplotlib
pip install opencv-python
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

---

## GPU memory reduction
In `legged_gym/envs/a1/a1_amp_config.py`: 
- line 43: `self.num_envs = 4096` -> `self.num_envs = 512`
- line 142: `camera_num_envs = 1024` -> `camera_num_envs = 256`

In `legged_gym/envs/a1/a1_config.py`:
- line 39: `self.num_envs = 5480` -> `self.num_envs = 512`

| GPU VRAM | Suggested `num_envs` |
| -------- | -------------------- |
| 6 GB     | 64–128               |
| 8 GB     | 128–256              |
| 12 GB    | 256–512              |
| 16 GB    | 512–1024             |
| 24 GB    | 2048+                |

## `isaacgym` load mismatch
In `legged_gym/envs/base/legged_robot.py`: 
- line 43: `from isaacgym.torch_utils import *` --> `from isaacgym.python.isaacgym.torch_utils import *`
- line 44: `from isaacgym import gymtorch, gymapi, gymutil` --> `from isaacgym.python.isaacgym import gymtorch, gymapi, gymutil`

In `isaacgym/python/isaacgym/__init__.py`: 
- line 5: `from isaacgym import gymapi` --> `from isaacgym.python.isaacgym import gymapi`

In `isaacgym/python/isaacgym/gymapi.py`: 
- line 51: `package_path = "isaacgym._bindings.%s.%s" % (platform, module_name)` --> `package_path = "isaacgym.python.isaacgym._bindings.%s.%s" % (platform, module_name)`

In `legged_gym/envs/base/base_task.py`: 
- line 32: `from isaacgym import gymapi` --> `from isaacgym.python.isaacgym import gymapi`
- line 33: `from isaacgym import gymutil` --> `from isaacgym.python.isaacgym import gymutil`

In `legged_gym/utils/helpers.py`: 
- line 39: `from isaacgym import gymapi` --> `from isaacgym.python.isaacgym import gymapi`
- line 40: `from isaacgym import gymutil` --> `from isaacgym.python.isaacgym import gymutil`

In `legged_gym/utils/math.py`: 
- line 34: `from isaacgym.torch_utils import quat_apply, normalize` --> `from isaacgym.python.isaacgym.torch_utils import quat_apply, normalize`

In `legged_gym/utils/terrain.py`: 
- line 38: `from isaacgym import terrain_utils` --> `from isaacgym.python.isaacgym import terrain_utils`

In `isaacgym/python/isaacgym/terrain_utils.py`: 
- line 13: `from isaacgym import gymutil, gymapi` --> `from isaacgym.python.isaacgym import gymutil, gymapi`

## NumPy compatible issue resolution
In `isaacgym/python/isaacgym/torch_utils.py`: 
- line 135: `...dtype=np.float` --> `...dtype=np.float32`

In `legged_gym/envs/base/legged_robot.py`: 
- line 1239: `...astype(np.int)` --> `...astype(np.int32)`
- line 1240: `...astype(np.int)` --> `...astype(np.int32)`
- line 1241: `...astype(np.int)` --> `...astype(np.int32)`
