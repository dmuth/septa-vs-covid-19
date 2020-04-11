#!/bin/bash
#
# This script is used to start up Splunk Lab.
#

# Errors are fatal
set -e


#
# Don't retain Splunk data on the host machine since we're Indexing like a GB
# of data, and that will be very very slow on Docker for OS/X.
# By not retaining that data, a 30 minute operation becomes 
# more like a 60 second operation. :-)
#
SPLUNK_DATA=no bash <(curl -s https://raw.githubusercontent.com/dmuth/splunk-lab/master/go.sh)



