#!/bin/bash
# Ejecutar UNA sola vez en la terminal del Codespace:  bash instalar_xc8.sh
set -e
sudo apt install -y unzip
cd ~
wget -O xc8.run "https://ww1.microchip.com/downloads/aemDocuments/documents/DEV/ProductDocuments/SoftwareTools/xc8-v4.00-full-install-linux-x64-installer.run"
chmod +x xc8.run
sudo ./xc8.run --mode unattended
rm xc8.run
echo 'export PATH=$PATH:/opt/microchip/xc8/v4.00/bin' >> ~/.bashrc
mkdir -p ~/packs && cd ~/packs
wget -O pic16.atpack "https://packs.download.microchip.com/Microchip.PIC16Fxxx_DFP.1.9.176.atpack"
unzip -o pic16.atpack -d PIC16Fxxx_DFP
rm pic16.atpack
ls /opt/microchip/xc8/
/opt/microchip/xc8/v4.00/bin/xc8-cc --version
echo "LISTO: XC8 y DFP instalados."
