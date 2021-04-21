# _*_ coding: utf-8 _*_
# vim: ft=sls

{% from (tpldir + "/map.jinja") import adobe_settings with context %}

{% set OSFAMILY = salt['grains.get']('os_family') %}
{% if OSFAMILY == "Windows" %}
{%  set isAdobePresent = salt['cmd.run'](''~ adobe_settings.commands.detect ~', shell=powershell') %}
{%  if isAdobePresent == "True" %}
{%   if adobe_settings.config.process is defined %}
{%    for process in adobe_settings.config.processes %}
stop_adobe_{{ process }}:
  cmd.run:
    - name: Stop-Process -Name {{ process }} -Force -ErrorAction Ignore
    - shell: powershell
    - env:
      - ExecutionPolicy: "bypass"
    - onlyif:
      - tasklist /FI "IMAGENAME eq {{ process }}.exe" 2>NUL | find /I /N "{{ process }}.exe">NUL

{%    endfor %}
{%   endif %}

create_download_dir:
  file.directory:
    - name: {{ adobe_settings.download.location }}
    
download_adobe_reader:
  file.managed:
    - name: {{ adobe_settings.download.location }}\{{ adobe_settings.config.filename }}
    {% if adobe_settings.config.source.remote is define and adobe_settings.config.source.remote %}
    - source: {{ adobe_settings.config.source.remote }}
    {% else %}
    - source: salt://{{ tpldir }}/files/{{ adobe_settings.config.source.local }}
    {% endif %}
    - makedirs: True

update_adobe_reader:
  cmd.run:
    - name: {{ adobe_settings.download.location }}\{{ adobe_settings.config.filename }} /sAll /norestart ALLUSERS=1 EULA_ACCEPT=YES
    - require:
      - download_adobe_reader

remove_staging_files:
  file.absent:
    - names:
      - {{ adobe_settings.config.shortcut_path }} 
      - {{ adobe_settings.download.location }}

{%  else %}
adobe_not_found:
  test.show_notification:
    - text: "Adobe not found on the system, skiping update."

{%  endif %}
{% else %}
skip_non_windows:
  test.show_notification:
    - text: "Adobe update state is not supported on {{ OSFAMILY }}."
{% endif %}

