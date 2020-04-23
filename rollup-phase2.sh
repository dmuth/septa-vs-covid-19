#!/bin/bash
#
# Run our second phase of rollup, which consists of computing train stats on a daily basis.
#

# Errors are fatal
set -e


QUERY_BODY="
| eval lates=split(lates, \",\") 
| mvexpand lates 
| eval lateness=case(
    lates > 15, \"> 15 min\", 
    lates > 5, \"> 5 min\", 
    true(), \"<= 5 min\") 
| timechart span=1d count by lateness 
| eval total='<= 5 min' + '> 5 min' + '> 15 min' 
| eval pct_late = (('> 5 min' + '> 15 min') / total) * 100 
| timechart span=1d 
    sum(total) as total
    sum(\"<= 5 min\") as under_5_min
    sum(\"> 5 min\") as over_5
    sum(\"> 15 min\") as over_15
    avg(pct_late) as pct_late 
| eval pct_late=pct_late 
| eval under_5_min=under_5_min 
| eval over_5=over_5 
| eval over_15=over_15 
| collect index=summary sourcetype=lates_by_day2
"


QUERY="index=summary ${QUERY_BODY}"

echo "# "
echo "# About to rollup train stats on a daily basis."
echo "# "
docker exec -it splunk-lab /opt/splunk/bin/splunk search "${QUERY}"

echo "# Done!"

