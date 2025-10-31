#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (use sudo)"
  exit 1
fi

check_updates() {
  echo "Checking for system updates..."
  apt update -qq
  updates=$(apt list --upgradable 2>/dev/null | grep -c upgradable)
  if [ "$updates" -gt 0 ]; then
    echo "System Updates Available: $updates"
  else
    echo "Your system is fully updated!"
  fi
}

list_updates() {
  echo "Listing upgradable packages..."
  apt list --upgradable 2>/dev/null | grep upgradable | head -20
}

install_updates() {
  echo "Installing updates..."
  apt upgrade -y
  echo "All updates installed successfully!"
}

show_menu() {
  echo "----------------------------------"
  echo "      System Update Modifier"
  echo "----------------------------------"
  echo "1. Check for system updates"
  echo "2. List upgradable packages"
  echo "3. Install all updates"
  echo "4. Exit"
  echo "----------------------------------"
}

while true; do
  show_menu
  read -p "Enter your choice [1-4]: " choice

  case $choice in
    1)
      check_updates
      ;;
    2)
      list_updates
      ;;
    3)
      install_updates
      ;;
    4)
      echo "Exiting... Have a great day!"
      exit 0
      ;;
    *)
      echo "Invalid choice! Please select between 1 and 4."
      ;;
  esac

  echo
  read -p "Press Enter to continue..."
done
