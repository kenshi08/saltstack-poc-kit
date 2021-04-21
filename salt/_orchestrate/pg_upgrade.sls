# _*_ coding: utf-8 _*_
# vim: ft=sls

{% set minion_id = salt['pillar.get']('id', None) %}

upgrade_pg_servers:
  salt.state:
    - tgt: {{ minion_id }}
    - sls:
      - postgres
