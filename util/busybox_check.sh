#!/bin/bash

echo "Checking if you have a busybox..."
path_list=$(echo $PATH | sed 's/:/\n/g')
found=0
for dir in $path_list;
	do
		if [ -e $dir/busybox ]; 
			then
				busybox_version=$($dir/busybox | awk '{if($2 ~ /^v/) print $2}')
				echo "Found a busybox at $dir, version $busybox_version"
				found=1
			fi
	done
	
if [ ! $found -eq 1 ];
	then
		echo "No busybox was found. Exiting."
		exit
	fi
	
echo "Checking if your busybox have necessary feature..."
echo "--- chown/chgrp: should support -R ---"
chown_check=$(busybox chown 2>&1 | awk '/Recurse|recurse|recursive/{print}')
chgrp_check=$(busybox chgrp 2>&1 | awk '/Recurse|recurse|recursive/{print}')

if [ -z '$chown_check' ];
	then
		echo "Chown does NOT support RECURSE. Exiting."
		exit
	else
		echo "PASSED: Chmod supports RECURSE."
	fi
	
if [ -z '$chgrp_check' ];
	then
		echo "Chgrp does NOT support RECURSE. Exiting."
		exit
	else
		echo "PASSED: Chgrp supports RECURSE."
	fi
	
echo "--- chown: better to support changing group ---"
chown_check=$(busybox chown 2>&1 | awk '/OWNER.+GROUP/{print}')

if [ -z '$chown_check' ];
	then
		echo "WARNING: Chown can only change owners. Must use chgrp by the side."
	else
		echo "Chown can also change groups."
	fi
	