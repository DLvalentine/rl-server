clear

echo "Creating user '$1' with password '$2'..."

useradd -m -s /bin/bash $1 && \
echo "$1:$2" | chpasswd && \
cp /etc/motd /home/$1/README.txt
