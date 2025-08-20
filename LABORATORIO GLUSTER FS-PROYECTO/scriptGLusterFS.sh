# Actualiza paquetes
sudo apt update && sudo apt upgrade -y

# Instala GlusterFS
sudo apt install glusterfs-server -y

# Habilita y arranca el servicio
sudo systemctl enable glusterd
sudo systemctl start glusterd

# Agrega los otros nodos
sudo gluster peer probe gluster2
sudo gluster peer probe gluster3

# Verifica estado del clúster
sudo gluster peer status

# En cada nodo
sudo mkdir -p /data/assets
sudo mkdir -p /data/backend

# Volumen 1: web-assets
sudo gluster volume create web-assets replica 3 transport tcp \
  gluster1:/data/assets \
  gluster2:/data/assets \
  gluster3:/data/assets

sudo gluster volume start web-assets

# Volumen 2: backend-data
sudo gluster volume create backend-data replica 3 transport tcp \
  gluster1:/data/backend \
  gluster2:/data/backend \
  gluster3:/data/backend

sudo gluster volume start backend-data

# Crear puntos de montaje
sudo mkdir -p /mnt/web-assets
sudo mkdir -p /mnt/backend-data

# Montar volúmenes
sudo mount -t glusterfs gluster1:/web-assets /mnt/web-assets
sudo mount -t glusterfs gluster1:/backend-data /mnt/backend-data

# /etc/fstab para persistencia
echo "gluster1:/web-assets /mnt/web-assets glusterfs defaults,_netdev 0 0" | sudo tee -a /etc/fstab
echo "gluster1:/backend-data /mnt/backend-data glusterfs defaults,_netdev 0 0" | sudo tee -a /etc/fstab




