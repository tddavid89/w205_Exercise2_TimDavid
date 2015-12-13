### Readme.txt ###

# Install necessary packages
pip install streamparse
pip install tweepy
pip install psycopg2

# Navigate to /data and make 'ex2' folder
cd /data
mkdir ex2
cd ex2

# Clone repository (only keep exercise_2 folder)
git clone https://github.com/UC-Berkeley-I-School/w205-labs-exercises
cp ./w205-labs-exercises/exercise_2 ./exercise_2
rm -r w205-labs-exercises

# Create streamparse project called 'EX2tweetwordcount'
sparse quickstart EX2tweetwordcount

# Copy files from w205 repository to EX2tweetwordcount
cp /data/ex2/exercise_2/psycopg-sample.py /data/ex2/EX2tweetwordcount/psycopg-sample.py
cp /data/ex2/exercise_2/tweetwordcount/src/spouts/Tweets.py /data/ex2/exercise_2/EX2tweetwordcount/src/spouts/Tweets.py
cp /data/ex2/exercise_2/tweetwordcount/src/bolts/Parse.py /data/ex2/exercise_2/EX2tweetwordcount/src/bolts/Parse.py
cp /data/ex2/exercise_2/tweetwordcount/src/bolts/Wordcount.py /data/ex2/exercise_2/EX2tweetwordcount/src/bolts/Wordcount.py
cp /data/ex2/exercise_2/tweetwordcount/topologies/tweetwordcount.clj /data/ex2/exercise_2/EX2tweetwordcount/topologies/tweetwordcount.clj

# Remove files left from original topology from streamparse folder
#rm /data/ex2/EX2tweetwordcount/src/bolts/wordcount.py
#rm /data/ex2/EX2tweetwordcount/src/spouts/words.py
rm /data/ex2/EX2tweetwordcount/src/topologies/wordcount.clj
