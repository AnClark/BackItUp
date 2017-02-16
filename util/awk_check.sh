
echo "AWK is an important dependency of BackItUp."
echo "BackItUp cannot work without it."
echo "Checking if you have AWK installed..."
awk_check=$(awk 2>&1 | grep -i "Usage" 2>&1)
gawk_check=$(gawk 2>&1 | grep -i "Usage" 2>&1)
if [ -z "$awk_check" ];
	then
		if [ ! -z "$gawk_check" ];
			then
				echo "WARNING: Your device has provided GAWK -- the main executable of awk."
				echo "However, awk is the usual name instead of gawk."
				echo "But no need to worry. Just make a link."
			else
				echo "FATAL: You have not installed awk. Exiting."
				exit
			fi
	else
		echo "PASSED: You have installed awk."
	fi
