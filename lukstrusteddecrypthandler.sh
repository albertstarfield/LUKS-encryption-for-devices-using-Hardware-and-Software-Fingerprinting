#!/bin/bash
#this is handler for LUKS rootfs
disk1decrypt(){
cd /encryptStorageTrustTool
. $(pwd)/diskConfig/disk0.conf
#mountingpoint=/home
#diskUUID=74b757bf-e49a-4034-963e-75415714db84 #change this
echo Calculating Trusted hardware + Software hash
#echo $(bash /encryptStorageTrustTool/submitkey)| cryptsetup luksOpen /dev/disk/by-uuid/${diskUUID} ${sessionName} -
cryptsetup luksOpen /dev/disk/by-uuid/${diskUUID} ${sessionName} --key-file=/tmp/keyHash
mkdir ${mountingpoint}
echo "mounting..."
mount -o rw,lazytime,async,autodefrag,barrier,compress=zstd,datacow,datasum,flushoncommit,treelog /dev/mapper/${sessionName} ${mountingpoint}
countwait=0
while [ ! -f ${mountingpoint}/mounted.flag ]; do
countwait=$(($countwait + 1))
if [ $countwait -gt 30 ];then
disk1decrypt
#loop back if disk 1 failed
fi
sleep 1
done
echo "disk1decryptor handler thread done!"
}


echo 'launching disk1decrypt() to foreground'

disk1decrypt # dont put it on the background to make sure this is the high priority one
echo "done!"


