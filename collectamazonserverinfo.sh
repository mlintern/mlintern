ec2-describe-instances | grep "Name\|INSTANCE" | perl -pe 's/\s+/:/g' | perl -pe 's/INSTA/\nINSTA/g' | awk -F: '{print $25,",",$4,",",$13}' | grep amazon > ~/Documents/FullServerList.csv
