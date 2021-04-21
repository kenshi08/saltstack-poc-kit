# Configure Windows Repository on Salt Master.

<br>

### 1. REPO INSTALLAITON
1.1 Installation of gitpython package to clone windows repository
```
yum install -y GitPython
```


1.2 Update file_root for windows repostiroty
```
cat <<EOF >> /etc/salt/master.d/file_roots.conf
file_roots:
  base:
    - /srv/salt
    # configue winrepo for salt master
    - /srv/salt/win/repo-ng
EOF
```

<br>


1.3 Restart salt master

```
systemctl restart salt-master
```

<br>

1.4 Generate repo cache file, this will update the winrepo git details
```
salt-run winrepo.update_git_repos
```

<br>

1.5 List available package for windows
```
salt-run winrepo.genrepo
```

<br>

1.6 Update the repository cache file on minions, exactly how it's done for the Linux package managers:
```
salt '*' pkg.refresh_db
```
Note: Replace minion_id with  
