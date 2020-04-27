#!/bin/bash
#
# Run our first phase of rollup, which will take all train late values and write them to a 
# single event per day in the summary index.
#

# Errors are fatal
set -e

# Disable wildcard globbing.  Took me like an hour to find this.
set -f


#
# Run our query against a set of dates.
#
function query() {

	EARLIEST=$1
	LATEST=$2

	#
	# Substitute in the start and end dates
	#
	local QUERY=$(echo $QUERY | sed -e s=%EARLIEST%=${EARLIEST}= -e s=%LATEST%=${LATEST}= )
	#echo $QUERY

	echo "# "
	echo "# Running Phase 1 rollup on dates from ${EARLIEST} to ${LATEST}"
	echo "# "
	docker exec -it splunk-lab /opt/splunk/bin/splunk search "${QUERY}"

} # End of query()


QUERY="
index=main
earliest=%EARLIEST%:0:0:0 latest=%LATEST%:0:0:0

index=main late!=999 
| timechart span=1d max(late) by trainno limit=2500 
| foreach * 
    [ eval lates=mvappend(lates, '<<FIELD>>')] 
| fields _time lates 
| eval lates=mvjoin(lates, \",\") 
| collect index=summary sourcetype=lates_by_day
"

echo "# "
echo "# Starting our Phase 1 rollup queries."
echo "# These queries will take a few MINUTES per year, FYI."
echo "# "

#
# Pause for 5 seconds so the user sees this, unless I'm using NO_SLEEP in development. :-)
#
if test ! "$NO_SLEEP"
then
	sleep 5
fi

query "1/1/2020" "4/26/2020"
query "1/1/2019" "1/1/2020"
query "1/1/2018" "1/1/2019"
query "1/1/2017" "1/1/2018"
query "1/1/2016" "1/1/2017"

echo "# Done!"


