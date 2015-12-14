### Readme.txt ###

# ONLY necessary if you use ucbw205_... AMI
#########################################################################################################
# Python correct version
yum install python27-devel -y
mv /usr/bin/python /usr/bin/python266
ln -s /usr/bin/python2.7 /usr/bin/python

#install ez_setup
curl -o ez_setup.py https://bootstrap.pypa.io/ez_setup.py
python ez_setup.py
/usr/bin/easy_install-2.7 pip
pip install virtualenv
wget --directory-prefix=/usr/bin https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
chmod a+x /usr/bin/lein
#/usr/bin/lein

# Install necessary packages
pip install streamparse
pip install tweepy
pip install psycopg2
#########################################################################################################

# Navigate to /data and make 'ex2' folder
cd /data
mkdir ex2
cd ex2

# Clone repository (only keep exercise_2 folder)
git clone https://github.com/UC-Berkeley-I-School/w205-labs-exercises
mv /data/ex2/w205-labs-exercises/exercise_2 /data/ex2/exercise_2
rm -r w205-labs-exercises
cd exercise_2

# Create streamparse project called 'EX2tweetwordcount'
sparse quickstart EX2tweetwordcount

# Copy files from w205 repository to EX2tweetwordcount
cp /data/ex2/exercise_2/psycopg-sample.py /data/ex2/exercise_2/EX2tweetwordcount/psycopg-sample.py
cp /data/ex2/exercise_2/tweetwordcount/src/spouts/tweets.py /data/ex2/exercise_2/EX2tweetwordcount/src/spouts/tweets.py
cp /data/ex2/exercise_2/tweetwordcount/src/bolts/parse.py /data/ex2/exercise_2/EX2tweetwordcount/src/bolts/parse.py
cp /data/ex2/exercise_2/tweetwordcount/src/bolts/wordcount.py /data/ex2/exercise_2/EX2tweetwordcount/src/bolts/wordcount.py
cp /data/ex2/exercise_2/tweetwordcount/topologies/tweetwordcount.clj /data/ex2/exercise_2/EX2tweetwordcount/topologies/tweetwordcount.clj

# Remove files left from original topology from streamparse folder
#rm /data/ex2/EX2tweetwordcount/src/bolts/wordcount.py
#rm /data/ex2/EX2tweetwordcount/src/spouts/words.py
rm /data/ex2/exercise_2/EX2tweetwordcount/topologies/wordcount.clj

# Clone my github and copy bolts/spouts to main project
cd /data/ex2
git clone https://github.com/tddavid89/w205_Exercise2_TimDavid
cp /data/ex2/w205_Exercise2_TimDavid/scripts/wordcount.py /data/ex2/exercise_2/EX2tweetwordcount/src/bolts/wordcount.py
cp /data/ex2/w205_Exercise2_TimDavid/scripts/tweets.py /data/ex2/exercise_2/EX2tweetwordcount/src/spouts/tweets.py

# Make sure postgres is running
#/data/stop_postgres.sh
/data/start_postgres.sh

# Log in to Postgres as user postgres
createdb tcount -U postgres
python /data/ex2/w205_Exercise2_TimDavid/scripts/create_table_tcount.py
#psql -U postgres
#CREATE DATABASE tcount;
#\c tcount
#CREATE TABLE Tweetwordcount (word TEXT PRIMARY KEY  NOT NULL, count INT NOT NULL);
#\q

# Run streamparse to populate postgres table
cd /data/ex2/exercise_2/EX2tweetwordcount
sparse run -t 300

# Run twitter application codes
python /data/ex2/w205_Exercise2_TimDavid/twitterApplicationCodes/finalresults.py hello
python /data/ex2/w205_Exercise2_TimDavid/twitterApplicationCodes/finalresults.py
python /data/ex2/w205_Exercise2_TimDavid/twitterApplicationCodes/histogram.py 5,10
