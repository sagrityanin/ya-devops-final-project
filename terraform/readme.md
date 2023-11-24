yandex container registry login
cat tf_key.json | docker login \
  --username json_key \
  --password-stdin \
  cr.yandex

docker push cr.yandex/crps6iajan0jje7v30hd/catgpt:myapp

docker build . -t cr.yandex/crps6iajan0jje7v30hd/catgpt:myapp

## Tunnel to VM

S_IP=10.5.0.11
D_IP=10.5.0.29
sudo iptables -A FORWARD -p tcp --dport 22 -d 10.5.0.0/24 -j ACCEPT
sudo iptables -t nat -A PREROUTING -p tcp --dport 23 -d $S_IP -j DNAT --to-destination $D_IP:22
sudo iptables -t nat -A POSTROUTING -p tcp --dport 22 -d $D_IP -j SNAT --to-source $S_IP

sudo iptables -A FORWARD -p tcp --dport 9090 -d 10.5.0.0/24 -j ACCEPT
sudo iptables -t nat -A PREROUTING -p tcp --dport 9090 -d $S_IP -j DNAT --to-destination $D_IP
sudo iptables -t nat -A POSTROUTING -p tcp --dport 9090 -d $D_IP -j SNAT --to-source $S_IP
