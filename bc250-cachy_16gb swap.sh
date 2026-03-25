#!/bin/bash

set -e

echo "==> Disabling and removing existing swapfile..."
sudo swapoff /var/swap/swapfile 2>/dev/null || true
sudo rm -f /var/swap/swapfile 2>/dev/null || true

echo "==> Recreating Btrfs subvolume..."
sudo btrfs subvolume delete /var/swap 2>/dev/null || true
sudo btrfs subvolume create /var/swap

echo "==> Creating 16G swapfile..."
sudo btrfs filesystem mkswapfile --size 16G /var/swap/swapfile

echo "==> Updating fstab..."
sudo sed -i '/\/var\/swap\/swapfile/d' /etc/fstab
echo '/var/swap/swapfile none swap defaults,nofail 0 0' | sudo tee -a /etc/fstab

echo "==> Setting swappiness to 180..."
echo 'vm.swappiness = 180' | sudo tee /etc/sysctl.d/99-swappiness.conf
sudo sysctl vm.swappiness=180

echo "==> Enabling swapfile..."
sudo swapon /var/swap/swapfile

echo ""
echo "Done! Current swap:"
swapon --show
