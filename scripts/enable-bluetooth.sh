#!/bin/bash
sudo systemctl start bluetooth
sudo rmmod btusb
sudo modprobe btusb
blueman-manager

#https://stackoverflow.com/questions/62388571/bluetooth-is-suddenly-switched-off-and-not-active-anymore
