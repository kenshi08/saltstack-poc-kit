# _*_ coding: utf-8 _*_
# vim: ft=sls

include:
{% if grains['kernel']|lower == 'linux' %}
  - linux
{% elif grains['kernel']|lower == 'windows' %}
  - windows
{% endif %}
