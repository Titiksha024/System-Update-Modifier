#!/bin/bash
if [ "$EUID" -ne 0 ]; then
  echo " Please run as root (use sudo)"
  exit 1
fi
echo "Checking for system updates..."

apt update -qq

updates=$(apt list --upgradable 2>/dev/null | grep -c upgradable)

if [ "$updates" -gt 0 ]; then
  echo " System Updates Available: $updates"
  echo "----------------------------------"
  apt list --upgradable 2>/dev/null | grep upgradable | head -10
  echo "----------------------------------"
  echo " Run 'sudo apt upgrade' to install updates."
else
  echo " Your system is fully updated!"
fi
