#!/bin/sh

sudo sh -c '
cp -f /etc/pam.d/sudo /etc/pam.d/sudo.old
chmod 666 /etc/pam.d/sudo
#awk 'NR==2{print "auth       sufficient     pam_tid.so"}1' /etc/pam.d/sudo.old > /etc/pam.d/sudo
awk '"'"'NR==2{print "auth       sufficient     pam_tid.so"}1'"'"' /etc/pam.d/sudo.old > /etc/pam.d/sudo
chmod 444 /etc/pam.d/sudo
'
