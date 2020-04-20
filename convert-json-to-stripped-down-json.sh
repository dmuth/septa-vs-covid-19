#!/bin/bash
#
# This script reads train data from stdin, and writes out key=value data containing
# only the timestamp, train number, and minutes late.
#
# This is because I'm doing crazy amounts of data processing on my 8-year old iMac
# and I only have so much CPU and RAM.  If I can do this to avoid paying for some 
# cloud instances, so much the better.
#


# Errors are fatal
set -e

>&2 echo "# "
>&2 echo "# Now reading JSON train data from input and ouputting key=value data..."
>&2 echo "# "


grep -iv error | jq -r '._timestamp + " trainno=" + .trainno + " late=" + (.late|tostring) '





