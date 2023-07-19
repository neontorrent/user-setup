#!/bin/sh

/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -f -r -domain local -domain system -domain user
sudo /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -seed -lint -r -f -v -dump -domain local -domain system -domain user -domain network
killall Dock
