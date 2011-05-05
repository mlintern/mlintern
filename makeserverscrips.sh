#!/bin/sh

# This script will pull the production server list and create a csv in the Documents folder

./collectamazonserverinfo.sh

# This script will create the blog servers list for TMUX
./listallproductionblogservers.sh > ~/.tmux.prod-blog.sh && chmod +x ~/.tmux.prod-blog.sh

# This script will create the pres servers list for TMUX
./listallproductionpresentationservers.sh > ~/.tmux.prod-pres.sh && chmod +x ~/.tmux.prod-pres.sh

# This script will create the callback servers list for TMUX
./listallproductioncallbackservers.sh > ~/.tmux.prod-call.sh && chmod +x ~/.tmux.prod-call.sh

# This script will create the all other servers list for TMUX
./listallotherproductionservers.sh > ~/.tmux.prod-other.sh && chmod +x ~/.tmux.prod-other.sh

# This script will create the all  servers list for TMUX
./listallproductionservers.sh > ~/.tmux.prod-all.sh && chmod +x ~/.tmux.prod-all.sh

