#!/bin/bash

# Detect the operating system
distro=$(grep ^ID= /etc/os-release | cut -d= -f2 | tr -d '"')

if [[ "$distro" == "ubuntu" ]]; then
    echo "Operating System is Ubuntu..."
    #https://stackoverflow.com/questions/62388571/bluetooth-is-suddenly-switched-off-and-not-active-anymore
    sudo systemctl start bluetooth
	sudo rmmod btusb
	sudo modprobe btusb
	blueman-manager

elif [[ "$distro" == "debian" ]]; then
    echo "Operating System is Debian..."
    # Check if bluetooth is installed and running
    bluetoothctl -v
    # Check if bluetooth service is running
    systemctl status bluetooth
    # Verify that the necessary Bluetooth packages are installed
    sudo apt list --installed | grep blue
    # Try resetting the Bluetooth adapter
    sudo hciconfig hci0 reset

else
    echo "Operating System is not Ubuntu or Debian."
    echo "Exiting script."
    exit 1
fi



# Packages we need to install by Synaptic:
# bluez
# bluetooth
# blueman