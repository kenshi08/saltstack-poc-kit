# Windows Minion Installation and Setup

All commands are executed in powershell.

<br>

1.1 Configure hostname of salt master
```
Add-Content C:\Windows\System32\Drivers\Etc\Hosts "10.1.1.1 salt-master"
```
Note: Replace the ip of salt master in above command 

<br>

1.2 Validate firewall connectivity between salt-minion and master
```
Test-NetConnection -ComputerName salt-master -Port 4505
Test-NetConnection -ComputerName salt-master -Port 4506
```

<br>

1.3 Download salt bootstrap script for windows
```
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

wget https://raw.githubusercontent.com/saltstack/salt-bootstrap/develop/bootstrap-salt.ps1 -outfile C:\Windows\Temp\bootstrap-salt.ps1
```

<br>

1.4 Install the minion with id and master options
```
C:\Windows\Temp\bootstrap-salt.ps1 -minion windows-minion -master salt-master
```
Note: Replace the minion id and salt master value

<br>

1.5 Validate and restart the salt-minion 
```
Get-Service salt-minion
Stop-Service salt-minion
Start-Service salt-minion

```
