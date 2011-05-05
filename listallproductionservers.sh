#!/bin/sh

cd ~/Documents

while read line
	do
		echo $line | perl -pe 's/\s+//g' | awk -F","  '{print "tmux neww -n",$1$3,"\"ssh -i ~/.ssh/rightscale_key ec2-user@",$2,"\""}'| perl -pe 's/\@.e/\@e/gi'  | perl -pe 's/us-east//g'
		done < "FullServerList.csv"
