#!/sbin/busybox sh

internal_sd="/data/media/0"
bak_dir=${internal_sd}/_appbak
filelist_file=${internal_sd}/_appbak/filelist.txt

rm -rf ${bak_dir}
mkdir ${bak_dir}

## Generate file list to copy
rm -f ${filelist_file}

# Generate app list first
app_list=$(ls /data/app)

echo "User app list is:"
for appname in ${app_list};
	do
		echo "*** "${appname}
		echo "/data/app/"${appname} >> ${filelist_file}
	done


# Generate app data folder list
echo "Generating app data list..."
for appname2 in ${app_list};
	do
		echo "/data/data/"$(echo ${appname2} | sed 's/-[0-9]*//g') >> ${filelist_file}
	done
			

# Start compressing
echo "Compressing your data..."
tar -zcv -f ${bak_dir}/bak.tar.gz -T ${filelist_file} --exclude=lib --exclude=oat




		

