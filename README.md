
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


## Additional Questions?

Want to leave feedback or get in touch.  My email is doug.muth@gmail.com.
I am also on <a href="http://twitter.com/dmuth">Twitter</a> and <a href="http://www.facebook.com/">Facebook</a>.



