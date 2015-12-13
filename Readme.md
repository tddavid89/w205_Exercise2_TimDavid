# Exercise 2
The following is a description of the steps that I took to complete this exercise and the steps necessary to execute the code contained in my GitHub repository.

## INITIAL SETUP
### AMI
Please use one of the following AMI's in order to execute the code:
- **[ucbw205_complete_plus_postgres_PY2.7]**
- **w205_exercise2_timdavid**

### User
All code was run as **_root_**

### Install Packages
In case they are not included, the following packages need to be installed:

```sh
$ pip install streamparse
$ pip install tweepy
$ pip install psycopg2
```

### Create Folders
Need to create the folder where we will extract and store the files from the [w205 GitHub repository]

```sh
$ cd /data
$ mkdir ex2
$ cd ex2
```

### Clone repository
Clone the repository, but only keep the exercise_2 folder:

```sh
$ git clone https://github.com/UC-Berkeley-I-School/w205-labs-exercises
$ cp ./w205-labs-exercises/exercise_2 ./exercise_2
$ rm -r w205-labs-exercises
```

### Streamparse
Create a streamparse project called **_EX2tweetwordcount_**:

```sh
$ sparse quickstart EX2tweetwordcount
```

### Move/Copy Files
Copy Necessary Files From GitHub Repo to EX2tweetworcount

```sh
$ cp /data/ex2/exercise_2/psycopg-sample.py /data/ex2/exercise_2/EX2tweetwordcount/psycopg-sample.py
$ cp /data/ex2/exercise_2/tweetwordcount/src/spouts/tweets.py /data/ex2/exercise_2/EX2tweetwordcount/src/spouts/tweets.py
$ cp /data/ex2/exercise_2/tweetwordcount/src/bolts/parse.py /data/ex2/exercise_2/EX2tweetwordcount/src/bolts/parse.py
$ cp /data/ex2/exercise_2/tweetwordcount/src/bolts/wordcount.py /data/ex2/exercise_2/EX2tweetwordcount/src/bolts/wordcount.py
$ cp /data/ex2/exercise_2/tweetwordcount/topologies/tweetwordcount.clj /data/ex2/exercise_2/EX2tweetwordcount/topologies/tweetwordcount.clj
```

Remove the files left from the original topology from streamparse folder

```sh
$ rm /data/ex2/exercise_2/EX2tweetwordcount/topologies/wordcount.clj
```

Clone my github and copy bolts/spouts to main project:

```sh
$ cd /data/ex2
$ git clone https://github.com/tddavid89/w205_Exercise2_TimDavid
$ cp /data/ex2/w205_Exercise2_TimDavid/scripts/wordcount.py /data/ex2/exercise_2/EX2tweetwordcount/src/bolts/wordcount.py
$ cp /data/ex2/w205_Exercise2_TimDavid/scripts/wordcount.py /data/ex2/exercise_2/EX2tweetwordcount/src/spouts/tweets.py
```

### Postgres
Make sure that Postgres is running:

```sh
$ /data/stop_postgres.sh
$ /data/start_postgres.sh
```

Log in to Postgres as user postgres and create database and table:

```sh
$ psql -U postgres
$ CREATE DATABASE tcount;
$ \c tcount
$ CREATE TABLE Tweetwordcount (word TEXT PRIMARY KEY  NOT NULL, count INT NOT NULL);
$ \q
```

### Streamparse
Run Streamparse for 5 minutes to populate postgres table:

```sh
$ cd /data/ex2/exercise_2/EX2tweetwordcount
$ sparse run -t 300
```

### Code
Run twitter application codes:

```sh
$ python /data/ex2/w205_Exercise2_TimDavid/twitterApplicationCodes/finalresults.py hello
```

![Test](/Users/tdavid/Documents/GitHub/w205_Exercise2_TimDavid/screenshots/04_finalresults_python_script_input_hello.png)

```sh
$ python /data/ex2/w205_Exercise2_TimDavid/twitterApplicationCodes/finalresults.py
```

![Test](/Users/tdavid/Documents/GitHub/w205_Exercise2_TimDavid/screenshots/05_finalresults_python_script_part_1.png)

![Test](/Users/tdavid/Documents/GitHub/w205_Exercise2_TimDavid/screenshots/05_finalresults_python_script_part_2.png)

```sh
$ python /data/ex2/w205_Exercise2_TimDavid/twitterApplicationCodes/histogram.py 5,10
```

![Test](/Users/tdavid/Documents/GitHub/w205_Exercise2_TimDavid/screenshots/06_histogram_python_script.png)

Readmes, how to use them in your own application can be found here:
- [**_w205_Exercise2_TimDavid/automation.sh_**] [automation script]

[//]: # "These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax"
[dill]: https://github.com/joemccann/dillinger
[git-repo-url]: https://github.com/joemccann/dillinger.git
[john gruber]: http://daringfireball.net
[@thomasfuchs]: http://twitter.com/thomasfuchs
[df1]: http://daringfireball.net/projects/markdown/
[marked]: https://github.com/chjj/marked
[ace editor]: http://ace.ajax.org
[node.js]: http://nodejs.org
[twitter bootstrap]: http://twitter.github.com/bootstrap/
[keymaster.js]: https://github.com/madrobby/keymaster
[jquery]: http://jquery.com
[@tjholowaychuk]: http://twitter.com/tjholowaychuk
[express]: http://expressjs.com
[angularjs]: http://angularjs.org
[gulp]: http://gulpjs.com
[ucbw205_complete_plus_postgres_py2.7]: http://thecloudmarket.com/owner/202821560654
[w205 github repository]: https://github.com/UC-Berkeley-I-School/w205-labs-exercises
[automation script]: https://github.com/tddavid89/w205_Exercise2_TimDavid/blob/master/automation.sh
[plgh]: https://github.com/joemccann/dillinger/tree/master/plugins/github/README.md
[plgd]: https://github.com/joemccann/dillinger/tree/master/plugins/googledrive/README.md
[plod]: https://github.com/joemccann/dillinger/tree/master/plugins/onedrive/README.md
