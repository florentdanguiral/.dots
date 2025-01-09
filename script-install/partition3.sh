mount --mkdir -o noatime,compress=zstd:5,discard=async,space_cache=v2,subvol=@ /dev/nvme0n1p7 /mnt/archinstall && \
mount --mkdir -o noatime,compress=zstd:5,discard=async,space_cache=v2,subvol=@home /dev/nvme0n1p7 /mnt/archinstall/home && \
mount --mkdir -o noatime,compress=zstd:5,discard=async,space_cache=v2,subvol=@pkg /dev/nvme0n1p7 /mnt/archinstall/var/cache/pacman/pkg && \
mount --mkdir -o noatime,compress=zstd:5,discard=async,space_cache=v2,subvol=@log /dev/nvme0n1p7 /mnt/archinstall/var/log && \
mount --mkdir -o noatime,compress=zstd:5,discard=async,space_cache=v2,subvol=@snapshots /dev/nvme0n1p7 /mnt/archinstall/.snapshots && \
mount --mkdir /dev/nvme0n1p5 /mnt/archinstall/boot && \
swapon /dev/nvme0n1p6
