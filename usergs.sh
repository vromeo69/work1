#!/bin/bash
#dscl -f /Volumes/Macintosh\ HD\ -\ Data/private/var/db/dslocal/nodes/Default localhost -passwd /Local/Default/Users/root
#touch /Volumes/Macintosh\ HD\ -\ Data/private/var/db/.AppleSetupDone
dscl . -create /Users/gs
dscl . -create /Users/gs UserShell /bin/bash
dscl . -create /Users/gs RealName "Green Safe"
dscl . -create /Users/gs UniqueID "1010"  #use something not already in use
dscl . -create /Users/gs PrimaryGroupID 80
dscl . -create /Users/gs NFSHomeDirectory /Users/soemuser
dscl . -passwd /Users/gs 1234
dscl . -append /Groups/admin GroupMembership gs
