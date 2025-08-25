sudo apt update && sudo apt upgrade -y
sudo apt install -y glusterfs-server
sudo systemctl enable --now glusterd
sudo systemctl status glusterd --no-pager

# Desde glus1 (23.22.172.33)
sudo gluster peer probe glus2
sudo gluster peer status


# Volumen 1
sudo gluster volume create assets replica 2 transport tcp \
  glus1:/data/assets \
  glus2:/data/assets force

sudo gluster volume start assets

# Volumen 2
sudo gluster volume create backend replica 2 transport tcp \
  glus1:/data/backend \
  glus2:/data/backend force

sudo gluster volume start backend

sudo gluster volume info
sudo gluster volume status