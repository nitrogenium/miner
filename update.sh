#!/bin/bash

version=20211119-4

mkdir -p miners/cuda
mkdir -p miners/opencl


wget https://github.com/tontechio/pow-miner-gpu/releases/download/$version/minertools-cuda-ubuntu-18.04-x86-64.tar.gz -P miners
wget https://github.com/tontechio/pow-miner-gpu/releases/download/$version/minertools-opencl-ubuntu-18.04-x86-64.tar.gz -P miners


# curl -L -O https://newton-blockchain.github.io/global.config.json

tar -xf miners/minertools-cuda-ubuntu-18.04-x86-64.tar.gz -C miners/cuda
# tar -xf miners/minertools-cuda-ubuntu-20.04-x86-64.tar.gz -C miners/20/nv

tar -xf miners/minertools-opencl-ubuntu-18.04-x86-64.tar.gz -C miners/opencl
# tar -xf miners/minertools-opencl-ubuntu-20.04-x86-64.tar.gz -C miners/20/amd	



rm miners/minertools-cuda-ubuntu-18.04-x86-64.tar.gz
rm miners/minertools-opencl-ubuntu-18.04-x86-64.tar.gz