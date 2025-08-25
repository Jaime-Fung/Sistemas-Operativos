sudo apt update
sudo apt install -y glusterfs-client

sudo mkdir -p /mnt/assets
sudo mkdir -p /mnt/backend


sudo mount -t glusterfs glus1:/assets /mnt/assets
sudo mount -t glusterfs glus1:/backend /mnt/backend


df -h | grep gluster