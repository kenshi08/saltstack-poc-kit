# Linux Minion Installation and Setup

Salt Bootstrap is a shell script that detects the target platform and selects the best installation method. (Only supported on Unix-like systems)

<br>

1.1 Conigure salt master hostname
```
cat "10.1.1.1 salt-master" >> /etc/hosts
```

<br>

1.2 Validate firewall connectivity between minion and salt-master
```
nc -zv salt-master 4505
nc -zv salt-master 4506
```
Note: If `nc` command is not install then install it by executing `yum install -y nc`.

<br>

1.3 Download and execute bootstrap script with minion id and master flags 
```
curl -L https://bootstrap.saltstack.com -o install_salt.sh

sudo sh install_salt.sh -P -i "$(hostname -s)" -A salt-master -X
```
Note: Replace master and minion option (if required)

<br>

1.4 Start the minion service
```
systemctl restart salt-minion
```

<br>

1.5 Validate connectivity to salt-master
```
salt-call grains.get master
``` 
Note: Above command requires minion key to be accepted at salt master.

