# _*_ coding: utf-8 _*_
# vim: ft=sls

{# Any minion starts with test will be accepted by the salt master #}
{% if 'act' in data and data['act'] == 'pend' and data['id'].startswith('test-') %}
minion_add:
  wheel.key.accept:
    - match: {{ data['id'] }}
{% endif %}
