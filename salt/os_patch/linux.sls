# _*_ coding: utf-8 _*_
# vim: ft=sls

{% from (tpldir + "/map.jinja") import patch_settings with context %}

{% if patch_settings.linux.kernel_patch %}
pkg.upgrade:
  module.run:
    - refresh: True

{% else %}
update cluster nodes:
  cmd.run:
    - name: yum upgrade --exclude="kernel* openafs* *-kmdl-* kmod-* *firmware*" -y

{%  if patch_settings.linux.system_reboot %}
system.reboot updates:
  module:
    - name: system.reboot
    - run
    - require:
      - module: pkg.upgrade

stops after updates reboot:
  test.fail_without_changes:
    - name: MESSAGE - system rebooting
    - failhard: True
    - require:
      - module: system.reboot updates

{%  endif %}
{% endif %}
