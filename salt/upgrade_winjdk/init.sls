# _*_ coding: utf-8 _*_
# vim: ft=sls

{% from (tpldir + "/map.jinja") import winjdk_settings with context %}

configure_choco_repo:
  cmd.run:
    - name: "[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
    - shell: powershell
    - env:
      - ExecutionPolicy: "bypass"
    - unless:
      - where choco

wait_installation:
  cmd.run:
    - name: sleep 5
    - shell: powershell
    - env:
      - ExecutionPolicy: "bypass"
    - watch:
      - configure_choco

install_vim_package:
  chocolatey.installed:
    - name: {{ winjdk_settings.package.name }}
    - version: {{ winjdk_settings.package.version }}
    - force: true
    - require:
      - configure_choco
