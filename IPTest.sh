#!/bin/sh

ipa=$(cat ~/outsideIP.txt)
ipb=$(curl icanhazip.com)
TO='mlintern@compendium.com aparker@compendium.com'

if [ $ipa != $ipb ]
  then
	  echo "The Outside IP address has changed from $ipa to $ipb" | mail -s "IP Address Change $TO"
	  echo $ipb > ~/outsideIP.txt
fi
