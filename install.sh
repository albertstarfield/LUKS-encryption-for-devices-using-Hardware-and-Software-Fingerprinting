#!/bin/bash
if [ "$(pwd)" == "/encryptStorageTrustTool" ]; then
echo "Successfully Installed!"
exit
fi
if [ "$(whoami)" != "root" ]; then
echo "Please launch this Install shell using root privilege"
exit
fi
set -e
set -x
echo "[1/12]creating /encryptStorageTrustTool"
mkdir /encryptStorageTrustTool
echo "[2/12] Installing component bypasstool"
cp -a $(pwd)/bypasstool /encryptStorageTrustTool
echo "[3/12] Installing component createLUKSVolume"
cp -a $(pwd)/createLUKSVolume /encryptStorageTrustTool
echo "[4/12] Installing component hwswhashd"
cp -a $(pwd)/hwswhashd /encryptStorageTrustTool
echo "[5/12] Installing hwswhashd systemd component"
cp -a $(pwd)/hwswhashd.service /encryptStorageTrustTool
echo "[6/12] Installing component improvementNotes.txt developer notes"
cp -a $(pwd)/improvementNotes.txt /encryptStorageTrustTool
echo "[7/12] Installing component Install.sh for Portability"
cp -a $(pwd)/install.sh /encryptStorageTrustTool
echo "[8/12] Installing luksAuth systemd component"
cp -a $(pwd)/luksAuth.service /encryptStorageTrustTool
echo "[9/12] Installing component lukstrusteddecrypthandler"
cp -a $(pwd)/lukstrusteddecrypthandler /encryptStorageTrustTool
echo "[10/12] Installing component bypasstool"
cp -a $(pwd)/bypasstool /encryptStorageTrustTool
echo "[11/12] Installing component bypasstool"
cp -a $(pwd)/bypasstool /encryptStorageTrustTool
echo "[12/12] Registering and starting systemd daemons"
systemctl enable --now /encryptStorageTrustTool/hwswhashd.service /encryptStorageTrustTool/luksAuth.service
echo "Done!"
echo "If you have preexisting configuration, you need to renew the TrustHashKey for the disks"