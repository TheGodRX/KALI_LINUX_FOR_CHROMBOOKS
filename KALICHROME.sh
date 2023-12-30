#!/bin/bash

echo "Welcome to DAN's Kali Linux Installation Script for Samsung Chromebook 3!"

# Check if the wp screw is still in place
wp_screw_status=$(sudo flashrom --wp-status | grep "Hardware write protect is enabled")

if [ -n "$wp_screw_status" ]; then
  echo "Hardware write protection is still enabled. Attempting to disable it."

  # Disable hardware write protection
  sudo flashrom --wp-disable

  # Verify if write protection is successfully disabled
  wp_screw_status=$(sudo flashrom --wp-status | grep "Hardware write protect is enabled")

  if [ -n "$wp_screw_status" ]; then
    echo "Failed to disable hardware write protection. Exiting."
    exit 1
  else
    echo "Hardware write protection successfully disabled."
  fi
else
  echo "Hardware write protection is already disabled."
fi

# Install crouton
echo "Installing crouton..."
sudo install -Dt /usr/local/bin -m 755 ~/Downloads/crouton

# Launch crouton to show help text
echo "Launching crouton..."
sudo crouton

# Install Kali Linux using crouton
echo "Installing Kali Linux..."
sudo crouton -n kali -r kali-rolling -t core,xiwi,xfce,extension

# Optionally, update Kali Linux if the download didn't complete successfully
# Uncomment the following line if needed
# sudo crouton -n kali -r kali-rolling -t core,xiwi,xfce,extension -u

echo "Kali Linux installation completed. Set up a new Unix username and password when prompted."
