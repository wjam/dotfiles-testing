# dotfiles-testing
This is a repository created to aid the testing of my dotfiles without potentially trashing my own system. This
repository consists of notes and Packer configuration to be able to have a VM ready to run `./install.sh` on.

This repository uses VirtualBox and isn't designed for continuous integration, as dotfiles will generally both require
passwords to be entered in and need visual verifying that graphical changes are correct.

## Notes
```shell script
packer build mac/
```

## Making an Ubuntu VM
### Create the VM
1. Download the ISO
2. Make a VM
3. Start the VM with the ISO
### Post-install changes
* `sudo apt install -y openssh-server virtualbox-guest-dkms virtualbox-guest-x11`
## Making a macOS (Catalina) VM
### Build the ISO
1. Download Install Catalina from app store - once it has downloaded and started, it will be saved at `/Applications/Install macOS Catalina.app`
2. Run the following commands:

```shell script
hdiutil create -o /tmp/Catalina -size 8500m -volname Catalina -layout SPUD -fs HFS+J
hdiutil attach /tmp/Catalina.dmg -noverify -mountpoint /Volumes/Catalina
sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/Catalina --nointeraction
hdiutil detach /volumes/Install\ macOS\ Catalina
hdiutil convert /tmp/Catalina.dmg -format UDTO -o ~/Desktop/Catalina.cdr
mv ~/Desktop/Catalina.cdr ~/Desktop/Catalina.iso
```
### Create the VM
Create a new VirtualBox vm with the following configuration:
* At least 25 GB of disk space
* Decent slug of RAM
* multiple processors
* No floppy (system tab)
* PIIX3 chipset (system tab)
* 12 8MB of video memory

Run the following commands:
```shell script
VBoxManage modifyvm "Your VM Name" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
VBoxManage setextradata "Your VM Name" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac11,3"
VBoxManage setextradata "Your VM Name" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
VBoxManage setextradata "Your VM Name" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple"
VBoxManage setextradata "Your VM Name" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
VBoxManage setextradata "Your VM Name" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1
VBoxManage setextradata "Your VM Name" VBoxInternal2/EfiGraphicsResolution 1920x1080
```
### Install the VM
1. Start the VM with the ISO
2. Use the `Disk Utility` app in the VM to erase the `VBOX HARDDISK Media` - call it `macOS Catalina`
3. Close `Disk Utility`
4. Run installer
### Post-install changes
* Enable ssh server
