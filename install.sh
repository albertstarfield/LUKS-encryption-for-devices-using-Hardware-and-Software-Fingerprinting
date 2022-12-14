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
set +x
echo "[1/12]creating /encryptStorageTrustTool"
if [ ! -d /encryptStorageTrustTool ]; then
mkdir /encryptStorageTrustTool
else
echo "Updating preexisting Installation..."
echo "ALERT, This will alter the Trust key"
sleep 1
echo "Disabling daemons from previous installation..."
systemctl disable --now hwswhashd.service luksAuth.service
fi
echo "[2/12] skipping component bypasstool"
#cp -a $(pwd)/bypasstool /encryptStorageTrustTool
echo "[3/12] Installing component createLUKSVolume"
cp -a $(pwd)/createLUKSVolume /encryptStorageTrustTool
echo "[4/12] Installing component hwswhashd"
cp -a $(pwd)/hwswhashd /encryptStorageTrustTool
echo "[5/12] Installing hwswhashd systemd component"
cp -a $(pwd)/hwswhashd.service /encryptStorageTrustTool
echo "[6/12] Skipping  component improvementNotes.txt developer notes"
#cp -a $(pwd)/improvementNotes.txt /encryptStorageTrustTool
echo "[7/12] Installing component Install.sh for Portability"
cp -a $(pwd)/install.sh /encryptStorageTrustTool
echo "[8/12] Installing luksAuth systemd component"
cp -a $(pwd)/luksAuth.service /encryptStorageTrustTool
echo "[9/12] Installing component lukstrusteddecrypthandler"
cp -a $(pwd)/lukstrusteddecrypthandler /encryptStorageTrustTool
echo "[10/12] Installing component renewTrustHashKey"
cp -a $(pwd)/renewTrustHashKey /encryptStorageTrustTool
echo "[11/12] skipping legacy component submitkey"
#cp -a $(pwd)/submitkey /encryptStorageTrustTool
echo "[12/12] Registering and starting systemd daemons"
cp -rv /encryptStorageTrustTool/*.service /etc/systemd/system
systemctl daemon-reload
systemctl enable --now hwswhashd.service luksAuth.service
echo "Done!"
echo "If you have preexisting configuration, you need to renew the TrustHashKey for the disks"
