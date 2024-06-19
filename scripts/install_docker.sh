#!/bin/bash

# 更新包索引
sudo apt-get update

# 安装必要的包
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# 添加Docker的官方GPG密钥
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# 设置Docker稳定版的仓库
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# 更新包索引
sudo apt-get update

# 安装Docker CE
sudo apt-get install -y docker-ce

# 启动Docker并设置开机自启
sudo systemctl start docker
sudo systemctl enable docker

# 检查Docker是否安装成功
docker --version

# 下载最新版本的Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# 赋予执行权限
sudo chmod +x /usr/local/bin/docker-compose

# 检查Docker Compose是否安装成功
docker-compose --version

echo "Docker 和 Docker Compose 安装完成"

# 配置nginx和x-ui
mkdir ~/nginx
sudo curl -L https://raw.githubusercontent.com/blyen/blyen.github.io/main/scripts/nginx.conf -o ~/nginx/nginx.conf

# 下载并启动x-ui docker-compose.yml
sudo curl -L https://raw.githubusercontent.com/blyen/blyen.github.io/main/scripts/docker-compose.txt -o ~/docker-compose.yml
sudo chmod +x ~/docker-compose.yml
docker-compose up -d

# 同步亚洲时间
sudo apt install -y ntpdate
ntpdate 0.asia.pool.ntp.org