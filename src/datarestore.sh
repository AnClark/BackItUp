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


if [ ! -e ${mark} ]; then
	echo "You must recover your app packages with apprestore.sh FIRST."
	echo "This will let us know about how your new ROM configs permissions for each apps."
	echo "Otherwise, your apps will CRASH due to wrong permission allocations!"
	echo "Exiting."
	exit -1
fi


echo "----------------- Gathering app package list -----------------"
apk_list=$(ls /data/app/ | sed 's/-[0-9]*//g' | sed 's/.apk//g')
sleep 1


echo "----------------- Gathering permission informations -----------------"
sleep 2

data_perm_list_file=${bak_dir}/data_perm_list.txt
rm -f ${data_perm_list_file}

for entry in ${apk_list}; do
	ls_info=$(ls -ld /data/data/${entry})
	echo ${ls_info} >> ${data_perm_list_file}
done


echo ""
sleep 1
echo "----------------- Restoring data -----------------"
sleep 4

tar -jxvf ${bak_dir}/${data_bak_name} -C / --overwrite

echo ""
sleep 1
echo "----------------- Fixing permissions -----------------"
sleep 5

for line_id in $(awk '{print NR}' ${data_perm_list_file}); do
	line=$(sed -n ${line_id}p ${data_perm_list_file})
	data_path=$(echo ${line} | awk -F " " '{print $NF}')
	owner=$(echo ${line} | awk -F " " '
		{for(i=1; i<=NF; i++)
			{
				if( $i ~ /^u0_/)
				{
					print $i;
					break;
				}
			}
		}
	')
	group=$owner
	
	echo "-------------------------------------"
	echo "Current App: "$data_path
	echo "chown -Rv" $owner $data_path
	echo "chgrp -Rv" $group $data_path
	echo "-------------------------------------"
	
	chown -Rv $owner $data_path
	chgrp -Rv $group $data_path
done

echo
echo "----------------- Cleaning up -----------------"
rm -r ${mark}