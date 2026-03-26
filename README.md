Enable Swap Script for the BC-250 (or really anything) on CachyOS

Installation:
Download script
chmod +x bc250-cachy_16gb_swap.sh
./bc250-cachy_16gb_swap.sh

Can verify it is working via:
swapon --show

Should sees:
NAME               TYPE       SIZE USED PRIO
/var/swap/swapfile file        16G   0B   -1

This script was largely taken from here:
https://github.com/NexGen-3D-Printing/SteamMachine
