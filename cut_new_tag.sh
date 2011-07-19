#!/bin/sh

#The New tag will be the one created and the old will be the last RC cut for use of creating the Final Tag
new_tag=2.6.1-RC1
old_tag=2.6.1-TR2

#The ticket is what the changes will be commited back to
ticket=2786

#The repo is to distigussh teh branch we will be working with blog, presentation, callback
repo=blog

#The static_assests is a boolean to determine whether or not this RC will need static assets. The old and the new are so it knows to change what and what to change it to
static_assets=yes
old_static=00E2
new_static=00E3

#The checkout_code is a bloolean to tell us if we need to checkout trunk or if we need to just update it
checkout_code=no

#final is a boolean to say if this cut is a final or not
final=no

#The release_present boolean is yes if the /tech/release folder is present and can be accessed on the current machine or no if it needs checked out.
release_present=yes

############################################
# All above infomration must be Filled out #
############################################

#If we need to update static assets then we first need to up tick the asset version number

if [ $static_assets = ' yes' ]
then

#If the code is not already checked out you will need to check it out first
	
	if [ $checkout_code = ' yes' ]
	then
		cd /home/devoloper/$repo/application/trunk
		svn checkout https://vault.internal.compendiumblogware.com/svn/$repo/application/trunk/
	else 
		cd /home/developer/$repo/application/trunk
		svn switch https://vault.internal.compendiumblogware.com/svn/$repo/application/trunk/
		svn up
	fi

	if [ $final = ' yes' ]
	then
		#For the final cut all we need to do is copy the last release candidate into the final tag

		svn copy -m "Final Release $new_tag, refs #$ticket" https://vault.internal.compendiumblogware.com/svn/$repo/application/tags/release-$old_tag https://vault.internal.compendiumblogware.com/svn/$repo/application/tags/release-$new_tag

	else
		#Uptick the Static Asset version in /home/developer/blog/application/trunk/app/config/settings.xml
		
		$(perl -pe "s/$old_static/$new_static/g" /home/developer/blog/application/trunk/app/config/settings.xml)


		#Committing settings.xml to trunk

		svn commit -m "Release-$new_tag Upticking static asset revision value to $new_static, refs #$ticket" app/config/settings.xml

		#Cutting the New Release

		svn copy -m "Release $new_tag , refs #$ticket" https://vault.internal.compendiumblogware.com/svn/$repo/application/trunk https://vault.internal.compendiumblogware.com/svn/$repo/application/tags/release-$new_tag
		
		#Switch to New Release Candidate
		
		cd /home/developer/blog/application/trunk
		svn switch https://vault.internal.compendiumblogware.com/svn/$repo/application/tags/release-$new_tag	

		#Build Assets
		
		phing build-assets
		
		#Add Assets to tag

		svn add -N pub/build
		svn add -N pub/build/list.ini
		svn add -N pub/build/rollups
		svn add -N pub/build/rollups/rollups.ini
		svn commit -m "Release-2.6.1-TR2 Build Assets, refs #2786" pub/build
		

		if [ $release_present = ' yes' ]
		then
			#Pushing the Static Assets to cdn
		
			/home/developer/tech/release/SyncSA_Limelight.php -s blog
		else
			cd /home/developer/
			svn co https://vault.internal.compendiumblogware.com/svn/tech/release tech/release
			/home/developer/tech/release/SyncSA_Limelight.php -s blog
		fi
	fi
fi
