#!/sbin/busybox sh

internal_sd="/data/media/0"
bak_dir=${internal_sd}/_appbak

echo "NOTICE: This tool should only be used to restore data after a Wipe."
echo "Your existing app/data will be overwritten!"

# Check for backup file
if [ ! -e ${bak_dir}/bak.tar.gz ]; then
	echo Backup file not found. Exiting.
	exit -1
fi

# Start restoring
echo Start restoring...
tar -zxvf ${bak_dir}/bak.tar.gz -C /


