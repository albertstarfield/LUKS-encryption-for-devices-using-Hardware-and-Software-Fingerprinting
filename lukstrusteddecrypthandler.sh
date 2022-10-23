#!/bin/bash
#this is handler for LUKS
while [ ! -f /tmp/keyHash ]; do
echo "Waiting for keyHash to be generated..."
sleep 1
done
diskDecryptSequence(){
cd /encryptStorageTrustTool
#. $(pwd)/diskConfig/disk0.conf
for config in $(ls $(pwd)/diskConfig); do
. $(pwd)/diskConfig/${config}
#mountingpoint=/home
#diskUUID=74b757bf-e49a-4034-963e-75415714db84 #change this
echo Calculating Trusted hardware + Software hash
#echo $(bash /encryptStorageTrustTool/submitkey)| cryptsetup luksOpen /dev/disk/by-uuid/${diskUUID} ${sessionName} -
cryptsetup luksOpen /dev/disk/by-uuid/${diskUUID} ${sessionName} --key-file=/tmp/keyHash
mkdir ${mountingpoint}
echo "mounting..."
mount -o rw,lazytime,async,autodefrag,barrier,compress=zstd,datacow,datasum,flushoncommit,treelog /dev/mapper/${sessionName} ${mountingpoint}
countwait=0
while [ -z "$(mount | grep /dev/mapper/${sessionName} | grep ${mountingpoint})" ]; do
countwait=$(($countwait + 1))
if [ $countwait -gt 30 ];then
diskDecryptSequence
fi
sleep 1
done
echo "${config} configuration done!"
done
}


#=======================main==========================
diskDecryptSequence # dont put it on the background to make sure this is the high priority one
echo "done!"


