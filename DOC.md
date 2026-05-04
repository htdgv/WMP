# Documentation

This document records changes made to fit with our current server and environment. Please refer to the original README.md for more details on commands and instructions.

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