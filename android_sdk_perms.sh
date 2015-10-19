#!/bin/sh
#
# This script fixes the permissions of the android SDK
# after running an update through Android Studio. It will
# set ownership of all files and directories to root:android
# and the permissions of all executables (including scripts)
# to 775, for other files to 664, and for directories to
# 775.


chmod_file()
{
	if [ "$0" == "./fix_permissions.sh" ]; then
		return
	fi
	chown root:android "$0"
	if [ "$(file "$0" | grep 'ELF\|shell\|Python')" != "" ]; then
		chmod 775 "$0"
		echo "$0: 775"
	else
		chmod 664 "$0"
		echo "$0: 664"
	fi
}

chmod_directory()
{
	chown root:android "$0"
	chmod 775 "$0"
	echo "$0: 775"
}

export -f chmod_file
export -f chmod_directory

find . -type f -exec /bin/sh -c chmod_file '{}' \;
find . -type d -exec /bin/sh -c chmod_directory '{}' \;

