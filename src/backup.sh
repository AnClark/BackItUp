#!/system/bin/sh

internal_sd="/data/media/0"
bak_dir=${internal_sd}/_appbak

apk_list=${internal_sd}/_appbak/apklist.txt
data_list=${internal_sd}/_appbak/datalist.txt

apk_bak_name=apks.tar.gz
data_bak_name=data.tar.bzip2

rm -rf ${bak_dir}
mkdir ${bak_dir}

## Generate file list to copy
rm -f ${apk_list}
rm -f ${data_list}

# Generate APK folder list first

echo "Parsing and generating APK folder list..."
echo "=========== USER APP LIST ==========="
for appname in $(ls /data/app);
	do
		echo "*** "${appname}
		echo "/data/app/"${appname} >> ${apk_list}
	done
echo "====================================="

# Generate app data folder list
echo "Parsing and generating app data list..."
app_list=$(pm list packages -3 | awk -F ':' '{print $NF}')

for appname2 in ${app_list};
	do
		# Android Official API
		echo "/data/data/"${appname2} >> ${data_list}
	done
			

# Start compressing
echo "----------------- Compressing your app packages -----------------"
sleep 1
tar -zcv -f ${bak_dir}/${apk_bak_name} -T ${apk_list} --exclude=lib --exclude=oat

echo ""
sleep 2

echo "----------------- Compressing your app data -----------------"
sleep 5
tar -jcv -f ${bak_dir}/${data_bak_name} -T ${data_list}





		

