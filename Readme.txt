# Exercise 2
The following is a description of the steps that I took to complete this exercise and the steps necessary to execute the code contained in my GitHub repository.

An alternative is to run the following shell script after you have selected your AMI
- GitHub: w205_Exercise2_TimDavid/automation.sh (https://github.com/tddavid89/w205_Exercise2_TimDavid/blob/master/automation.sh)
  - If you do run this shell script, please follow the following directions:

      $ cd /data
      $ wget https://raw.githubusercontent.com/tddavid89/w205_Exercise2_TimDavid/master/automation.sh](https://raw.githubusercontent.com/tddavid89/w205_Exercise2_TimDavid/master/automation.sh)
      $ chmod 777 /data/automation.sh
      $ /data/automation.sh


  - Please note that as you are running this script as root, you will get an error from _lein_ and you will have to press ENTER to continue:

    WARNING: You're currently running as root; probably by accident.
    Press control-C to abort or Enter to continue as root.
    Set LEIN_ROOT to disable this warning.


If you choose to run the code manually, here are the appropriate steps for setup:

## INITIAL SETUP
### AMI
Please use one of the following AMI's in order to execute the code:
- ucbw205_complete_plus_postgres_PY2.7
    - https://github.com/tddavid89/w205_Exercise2_TimDavid/blob/master/screenshots/AMI_selection.png?raw=true
- w205_exercise2_timdavid
    - https://github.com/tddavid89/w205_Exercise2_TimDavid/blob/master/screenshots/AMI_selection_2.png?raw=true

### User
All code was run as **_root_**

#### Preamble
If you select ucbw205_complete_plus_postgres_PY2.7 as your AMI, please run the following code in order to set up the correct version of python:

# Python correct version
$ yum install python27-devel -y
$ mv /usr/bin/python /usr/bin/python266
$ ln -s /usr/bin/python2.7 /usr/bin/python

#install ez_setup
$ curl -o ez_setup.py https://bootstrap.pypa.io/ez_setup.py
$ python ez_setup.py
$ /usr/bin/easy_install-2.7 pip
$ pip install virtualenv
$ wget --directory-prefix=/usr/bin https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
$ chmod a+x /usr/bin/lein

##### _The remainder of this document is applicable to all AMI's_ :
### Install Packages
In case they are not included, the following packages need to be installed:

$ pip install streamparse
$ pip install tweepy
$ pip install psycopg2


### Create Folders
Need to create the folder where we will extract and store the files from the [w205 GitHub repository]

$ cd /data
$ mkdir ex2
$ cd ex2


### Clone repository
Clone the repository, but only keep the exercise_2 folder:

$ git clone https://github.com/UC-Berkeley-I-School/w205-labs-exercises
$ cp ./w205-labs-exercises/exercise_2 ./exercise_2
$ rm -r w205-labs-exercises


### Streamparse
Create a streamparse project called **_EX2tweetwordcount_**:

$ sparse quickstart EX2tweetwordcount


### Move/Copy Files
Copy Necessary Files From GitHub Repo to EX2tweetwordcount

$ cp /data/ex2/exercise_2/psycopg-sample.py /data/ex2/exercise_2/EX2tweetwordcount/psycopg-sample.py
$ cp /data/ex2/exercise_2/tweetwordcount/src/spouts/tweets.py /data/ex2/exercise_2/EX2tweetwordcount/src/spouts/tweets.py
$ cp /data/ex2/exercise_2/tweetwordcount/src/bolts/parse.py /data/ex2/exercise_2/EX2tweetwordcount/src/bolts/parse.py
$ cp /data/ex2/exercise_2/tweetwordcount/src/bolts/wordcount.py /data/ex2/exercise_2/EX2tweetwordcount/src/bolts/wordcount.py
$ cp /data/ex2/exercise_2/tweetwordcount/topologies/tweetwordcount.clj /data/ex2/exercise_2/EX2tweetwordcount/topologies/tweetwordcount.clj


Remove the files left from the original topology from streamparse folder

$ rm /data/ex2/exercise_2/EX2tweetwordcount/topologies/wordcount.clj


Clone my github and copy bolts/spouts to main project:

$ cd /data/ex2
$ git clone https://github.com/tddavid89/w205_Exercise2_TimDavid
$ cp /data/ex2/w205_Exercise2_TimDavid/scripts/wordcount.py /data/ex2/exercise_2/EX2tweetwordcount/src/bolts/wordcount.py
$ cp /data/ex2/w205_Exercise2_TimDavid/scripts/tweets.py /data/ex2/exercise_2/EX2tweetwordcount/src/spouts/tweets.py


### File Structure
At this point, the file structure should look similar to this:

FILE STRUCTURE:

```
.
|-exercise_2
   |---EX2tweetwordcount
        |---_build
        |---config.json
        |---fabfile.py
        |---logs
        |---project.clj
        |---README.md
        |---_resources
        |---src
             |---bolts
                  |---__init__.py
                  |---parse.py
                  |---wordcount.py
             |---spouts
                  |---__init__.py
                  |---tweets.py
        |---tasks.py
        |---topologies
             |---tweetwordcount.clj
        |---virtualenvs
             |---wordcount.txt
   |---Exercise-2-Subject-205-Real Time Data Processing Using Apache Storm.pdf
   |---finalresults_limit20.py
   |---finalresults.py
   |---hello-stream-twitter.py
   |---histogram.py
   |---psycopg-sample.py
   |---README.md
   |---tweetwordcount
   |---Twittercredentials.py
   |---Twittercredentials.pyc
   |---wordcount

|-w205_Exercise2_TimDavid
   |---screenshots
        |---01_sparse_quickstart_EX2tweetwordcount.png
        |---02_sparse_run_t_300.png
        |---03_streamparse_mid_run.png
        |---04_finalresults_python_script_input_hello.png
        |---05_finalresults_python_script_part_1.png
        |---06_histogram_python_script.png
        |---AMI_selection_2.png
        |---AMI_selection.png
        |---architecture_diagram.png
   |---scripts
        |---create_table_tcount.py
        |---wordcount.py
        |---tweets.py
   |---twitterApplicationCodes
        |---finalresults.py
        |---histogram.py
   |---architecture.html
   |---architecture.md
   |---architecture.pdf
   |---automation.sh
   |---Plot.png
   |---Readme.html
   |---Readme.md
   |---Readme.pdf
   |---Readme.txt


### Postgres
Make sure that Postgres is running:

$ /data/stop_postgres.sh
$ /data/start_postgres.sh

Log in to Postgres as user postgres and create database and table:

$ psql -U postgres
$ CREATE DATABASE tcount;
$ \c tcount
$ CREATE TABLE Tweetwordcount (word TEXT PRIMARY KEY  NOT NULL, count INT NOT NULL);
$ \q


### Streamparse
Run Streamparse for 5 minutes to populate postgres table:

$ cd /data/ex2/exercise_2/EX2tweetwordcount
$ sparse run -t 300


### Code
Run twitter application codes:

$ python /data/ex2/w205_Exercise2_TimDavid/twitterApplicationCodes/finalresults.py hello

$ python /data/ex2/w205_Exercise2_TimDavid/twitterApplicationCodes/finalresults.py

$ python /data/ex2/w205_Exercise2_TimDavid/twitterApplicationCodes/histogram.py 5,10


### Histogram
Here are the results of the top 20 most frequently tweeted words in  the time that I ran streamparse:
https://github.com/tddavid89/w205_Exercise2_TimDavid/blob/master/Plot.png?raw=true
