#!/usr/bin/python

import socket
import logging
log = logging.getLogger(__name__)

def environment():

    hostname = socket.gethostname().upper()
    log.debug("envtypegrain hostname: " + hostname)

    if "-dev" in hostname:
        return {'envtype':'dev'}
    elif "-tst" in hostname or "-test" in hostname:
        return {'envtype':'tst'}
    elif "-qa" in hostname or "-qty" in hostname:
        return {'envtype':'qty'}
    elif "-prod" in hostname or "-prd" in hostname:
        return {'envtype':'prd'}
    else:
        return {'envtype':'n/a'}



if __name__ == "__main__":
    print environment()
