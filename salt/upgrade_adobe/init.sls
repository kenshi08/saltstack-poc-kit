# _*_ coding: utf-8 _*_
# vim: ft=sls

{% from (tpldir + "/map.jinja") import adobe_settings with context %}

include:
  - {{ slspath }}.upgrade
