# Writing Custom Grains for Salt Minion

Grains are attributed of minions which collects information about operating system, domain name, IP address, kernel, OS type, memory, and many other system properties.

#### Listing Grains
```
salt <MINION_ID> grains.ls
```

```
salt <MINION_ID> grains.items
```

<br>

#### Custom Grain Discovery
Custom grains modules should be placed in a subdirectory named `_grains` located under the file_roots i.e. `/srv/salt`. Custom grains modules will be distributed to the minions when state.highstate is run, or by executing the 
```
salt <MINION_ID> saltutil.sync_grains

``` 
```
salt <MINION_ID> saltutil.sync_all

```

<br>

Note: `envtype_grains.py` is developed to discover custom grains of minion environment type by deteremining env from hostname.
