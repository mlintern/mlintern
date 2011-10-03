#!/bin/sh

ipa=$(cat ~/outsideIP.txt)
ipb=$(curl icanhazip.com)

if [ $ipa != $ipb ]
  then
	  echo "The Outside IP address has changed from $ipa to $ipb" | mail -s "IP Address Change" mlintern@compendium.com
	  echo $ipb > ~/outsideIP.txt
fi
