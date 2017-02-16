#!/system/bin/sh

internal_sd="/data/media/0"
bak_dir=${internal_sd}/_appbak

apk_bak_name=apks.tar.gz
data_bak_name=data.tar.bzip2

mark=/data/app/backitup.mark

if [ ! -e ${bak_dir} ]; then
	echo "No backup archive found. Exiting."
	exit -1
fi

if [ ! -e ${bak_dir}/${apk_bak_name} -o ! -e ${bak_dir}/${data_bak_name} ]; then
	echo "Lack of backup archive. Exiting."
	exit -1
fi

echo "Restoring your apps from backup file "${bak_dir}/${apk_bak_name}"..."
echo "NOTICE: The TAR client on Android supports few parameters."
echo "It DOES NOT SUPPORT KEEPING NEW FILES. So packages will be OVERWRITTEN."
tar -zxvf ${bak_dir}/${apk_bak_name} -C / 

echo "Marking to tell data restore util that you can restore data properly..."
echo "BackItUp Utility by AnClark" > ${mark}
echo "App packages restored at "$(date) >> ${mark}
