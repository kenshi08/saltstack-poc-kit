# _*_ coding: utf-8 _*_
# vim: ft=sls

{% from (tpldir + "/map.jinja") import patch_settings with context %}


windows_system_update:
  wua.uptodate:
    - name: Windows System Update
    - software: {{ patch_settings.windows.software }}
    - drivers:  {{ patch_settings.windows.drivers }}
    - categories: 
    {{ for category in patch_settings.windows.categories }}
      - {{ category }}
    {{ endfor }}
    - skip_reboot: {{ patch_settings.windows.system_reboot }}
