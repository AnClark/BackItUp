#!/sbin/busybox sh

internal_sd="/data/media/0"
bak_dir=${internal_sd}/_appbak

# Check for backup file
if [ ! -e ${bak_dir}/bak.tar.gz ]; then
	echo Backup file not found. Exiting.
	exit -1
fi

# Start restoring
tar -zxvf ${bak_dir}/bak.tar.gz -C /
