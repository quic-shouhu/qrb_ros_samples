# Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear


# Copyright 2015 Open Source Robotics Foundation, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#!/bin/bash

# 自动输入 y 或回车
export DEBIAN_FRONTEND=noninteractive

# 更新包列表
echo "Updating package list..."
yes | apt-get update

# 安装必要的包
echo "Installing required packages..."
yes | apt-get install -y locales software-properties-common curl

# 设置语言环境
echo "Setting up locale..."
locale-gen en_US en_US.UTF-8
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# 添加 ROS 2 软件源
echo "Adding ROS 2 repository..."
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# 更新包列表并升级系统
echo "Updating package list and upgrading system..."
yes | apt-get update
yes | apt-get upgrade -y

# 安装 ROS 2
echo "Installing ROS 2..."
yes | apt-get install -y ros-humble-ros-base

# 安装 pip
echo "Installing pip..."
apt-get install -y python3-pip

# 安装 HDF5
echo "Installing HDF5..."
apt-get install -y libhdf5-dev

# 安装 h5py
echo "Installing h5py..."
pip3 install h5py

# 安装 colcon
echo "Installing colcon..."
apt-get install -y python3-colcon-common-extensions

# 安装相关包
echo "Installing related packages..."
pip install sounddevice
pip install samplerate
pip install tensorflow
pip install torch
pip install scipy
pip install openai-whisper
pip install qai_hub_models

echo "All packages installed successfully!"