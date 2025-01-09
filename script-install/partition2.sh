mount /dev/nvme0n1p7 /mnt && \
btrfs su cr /mnt/@ && \
btrfs su cr /mnt/@home && \
btrfs su cr /mnt/@pkg && \
btrfs su cr /mnt/@log && \
btrfs su cr /mnt/@snapshots && \
umount /mnt 
