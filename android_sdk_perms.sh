#!/bin/sh
#
# This script fixes the permissions of the android SDK
# after running an update through Android Studio. It will
# set ownership of all files and directories to root:android
# and the permissions of all executables (including scripts)
# to 775, for other files to 664, and for directories to
# 6775.


chmod_file()
{
	chown root:android "$0"
	if [ "$(file "$0" | grep 'ELF\|shell\|Python')" != "" ]; then
		chmod -v 775 "$0"
	else
		chmod -v 664 "$0"
	fi
}

chmod_directory()
{
	chown root:android "$0"
	chmod -v 6775 "$0"
}

fix_perms()
{
	find "$0" -type f -exec /bin/sh -c chmod_file '{}' \;
	find "$0" -type d -exec /bin/sh -c chmod_directory '{}' \;
}

export -f chmod_file
export -f chmod_directory
export -f fix_perms

if [ "$0" == "--full" ]; then
	fix_perms .
else
	find . \! -uid 0 -exec /bin/sh -c fix_perms '{}' \;
fi

