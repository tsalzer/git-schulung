#!/bin/bash
# Run bin/present on the non-local interface.

ADDRESS=$(head -1 /etc/hosts | cut -f 1)

/home/user/bin/present -http=${ADDRESS}:3999 -play=false
