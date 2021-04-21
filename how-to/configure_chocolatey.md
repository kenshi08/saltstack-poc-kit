# Configure Chocolatey Windwos Package Manager on Salt Minion

Chocolatey is a software management solution that allows you to manage 100% of your software, anywhere you have Windows, with any endpoint configuration management tools such as SaltStack. 

<br>

1.1 Validate if chocolatey is already installed (Please replace your windows MINION_ID)
```
salt <MINION_ID> cmd.run "where choco"
```

<br>

1.2 Install chocolatey with powershell
```
salt <MINION_ID> cmd.run "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" shell=powershell
```

<br>

1.3 Install package with chocolatey
```
salt <MINION_ID> cmd.run "choco install vim  -y"
```
