#!/usr/bin/env bash
set +x 
set +e
sudo apt update -y
set -e
sudo apt install -y  libopencv-dev libopencv-highgui-dev \
    libopencv-video-dev \
    libopencv-photo-dev
sudo apt install -y  libboost-all-dev 
sudo apt install -y  cmake
sudo apt install -y  arduino
sudo apt install -y  gnuplot-x11
sudo apt install -y  libtiff-dev libserial-dev
sudo apt install -y  libboost-all-dev
sudo apt install -y  libhdf5-serial-dev
sudo apt install -y  python3-matplotlib python3-scipy python3-pip \
    python3-setuptools python3-dev
sudo -E python3 -m pip install -r ../requirements.txt

sudo dpkg -i ./spinnaker-2.0.0.147-amd64/lib*.deb

echo "Now adding user to all the cool groups"
sudo gpasswd -a $USER dialout
if [ ! -f /etc/udev/rules.d/40-pgr.rules ]; then
    echo "Configuring for camera"
fi

sudo mkdir -p /mnt/ramdisk
sudo chmod a+w /mnt/ramdisk

#echo "You may like mount a slice of ram to /mnt/ramdisk"
#echo "Something like the following needs to be added to /etc/fstab"
#printf "\ttmpfs /mnt/ramdisk tmpfs nosuid,size=1024M 0 0\n"
#printf "To make it permanent\n"

LINE="tmpfs /mnt/randisk tmpfs nosuid,size=1024M 0 0"
if grep -Fxq "$LINE" /etc/fstab; then
    echo "RAMDISK already configured in /etc/fstab"
else
    echo "$LINE" | sudo tee --append /etc/fstab 
fi
echo "All done. You may like to reboot/logout"
