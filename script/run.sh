# To test environment
python -m legged_gym.tests.test_env2

# train
python legged_gym/scripts/train.py --task=a1_amp --headless --sim_device=cpu

# play
python legged_gym/scripts/play_v2.py --task=a1_amp --sim_device=cpu --terrain=climb