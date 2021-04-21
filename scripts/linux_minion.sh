#!/bin/bash
#
#

# -------------------------------------------------------------------------
# NAME: __validate_conn
# DESCRIPTION: validate connectivity with salt master on default salt port
# -------------------------------------------------------------------------
__validate_conn(){

  local salt_master="${1}"
   
  for port in 4505 4506
  do
    timeout 1 bash -c "cat < /dev/null > /dev/tcp/${salt_master{/${port}"
    if [[ $? -ne 0 ]]; then
      echo "ERROR: Salt connection test failed for ${salt_master} Port ${port}"
      exit 1
    fi
  done
}


# -------------------------------------------------------------------------
# NAME: __install_minion
# DESCRIPTION: function to install salt minion
# -------------------------------------------------------------------------
__install_minion(){
  
  local salt_master=${1}
  # download bootstrap script
  curl -skL https://bootstrap.saltstack.com -o /tmp/install_salt.sh
  return_code=${?}

  if [[ ${return_code} -ne 0 ]]; then
    echo "ERROR: Bootstrap download command failed. Please fix the issue and re-run the script."
    exit 1
  fi

  bash /tmp/install_salt.sh -P -i "$(hostname -s)" -A ${salt_master} -x python3 -X > /dev/null 2>&1

  # start the salt-minio service
  if [[ -a /etc/systemd/system/salt-minion.service ]] || [[ -a /usr/lib/systemd/system/salt-minion.service ]] ; then
    systemctl start salt-minion > /dev/null 2>&1
  else
    echo "ERROR: Unable to local unit file for salt-minion."
    exit 1
  fi
}

# -------------------------------------------------------------------------
# NAME: __main
# DESCRIPTION: main function to setup and configure salt minion 
# -------------------------------------------------------------------------
__main(){
  
  local salt_master=${1}

  # validate firewall connectivity
  __validate_conn ${salt_master}
  
  # update dns entry for salt master
  ech "${salt_master} salt-master" >> /etc/hosts

  # execute salt-minion installation function
  __install_minion ${salt_master}

}

# =============================================================================
# ====================== MAIN FUNCTION ========================================
# =============================================================================
__main
