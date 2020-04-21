
# WORK IN PROGRESS

This is currently a work in progress.  Check back for more updates.


# SEPTA vs COVID-19

This is a project I am working on to track service levels and performance of 
SEPTA's Regional Rail train system before and during the COVID-19 shutdown.


## Getting started

- Make sure you have <a href="https://www.docker.com/">Docker</a> installed on your machine.
- Clone this repo and cd to that directory.
- 2020 Train data is already in the `logs/` directory.
   - But if you would like train data from past years, <a href="https://www.dropbox.com/sh/3jnvonaqtmvc3wh/AACvwz3DMTXrW56P8xBUUIcSa?dl=0">it can be downloaded from Dropbox</a>.
- Run `./go.sh` to start up Splunk.

At this point, Splunk will be running on <a href="https://localhost:8000/">https://localhost:8000/</a>, 
and it will start ingesting all of the train data.  On my Mac, this took about 60 seconds.

Once the data is ingested, you can view the dashboards.


## Additional Info

I based this project on my <a href="https://github.com/dmuth/splunk-lab">Splunk Lab project</a>,
which is a Dockerized version of Splunk meant for running ad hoc data analysis.  You should check it out!


## FAQ

Q: Why is the indexed data not exported from Splunk?
A: Turns out that this is _realloy_ slow in Docker on OS/X.  Not exporting that directory increases
ingestion of 2020's data from 30 minutes to about 45 seconds.

Q: Can previous years' train data be used?
A: Yep!  Unless you are running Splunk natively, RAM may be an issue, so my suggestion would be to strip down
the events.  This can be done with a supplied conversion script as follows:

`cat 2019.json | ./convert-json-to-stripped-down-json.sh > logs/2019.json`

Q: What's up with the missing data around October 22nd to 25th, 2019?
A: No idea.  It's not in my core Splunk instance so I can only assume that SEPTA's API had issues during that timeframe.  Wouldn't be the first time.  If you want to fill in some of the missing data so that graphs don't have a false drop in them, use this query to grab data from October 21st and copy it to the 23rd:

```
index=main sourcetype=logs late!=999 earliest="10/21/2019:4:0:0" latest="10/21/2019:24:0:0" 
| eval trainno="001-" + trainno 
| eval _time = _time + (86400 * 2) 
| eval _raw=_time . " trainno=" . trainno . " late=" . late 
| collect index=main sourcetype=smoothing
```

That query needs to be run 3 times, and you **must** increment the string in `trainno` by 1 in each run, e.g. `001`, `002`, and `003`.

If you wish to delete those filled in events, use this query:

`index=main earliest=-5y sourcetype=smoothing | delete`


## Additional Questions?

Want to leave feedback or get in touch.  My email is doug.muth@gmail.com.
I am also on <a href="http://twitter.com/dmuth">Twitter</a> and <a href="http://www.facebook.com/">Facebook</a>.



