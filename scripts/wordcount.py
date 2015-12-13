from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt
import psycopg2
import re
import string

#cur.execute('''CREATE TABLE Tweetwordcount
#       (word TEXT PRIMARY KEY     NOT NULL,
#       count INT     NOT NULL);''')
#conn.commit()
#conn.close()


class WordCounter(Bolt):

    def initialize(self, conf, ctx):
        self.counts = Counter()


    def process(self, tup):
        word = tup.values[0]

        # Increment the local count
        self.counts[word] += 1
        self.emit([word, self.counts[word]])


        #add to postgres
        exclude = set(string.punctuation)
        word = ''.join(ch for ch in word if ch not in exclude)
        word = word.lower()

        remove_common_words = ['the','i','you','a','to','of','is','my','for','in','me','from','and','it','on','with','get','this','im','are','your','our','their',\
                                   'when','what','see','more','here','so','have','do','u',' ','be','its','not','by','at','was','no','up','can','that','just','but','its']

        if word not in remove_common_words:
            conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
            cur = conn.cursor()
            cur.execute("SELECT word,count FROM Tweetwordcount WHERE word='%s'" % word)
            records = cur.fetchall()
            if len(records) > 0:
                uWord = str(int(records[0][1]) + 1)
                cur.execute("UPDATE Tweetwordcount SET count = %s WHERE word=%s",(uWord,word))
                conn.commit()
            if len(records) == 0:
                cur.execute("INSERT INTO Tweetwordcount (word,count) VALUES ('%s',1)" % word)
                conn.commit()

            conn.close()

        # Log the count - just to see the topology running
        self.log('%s: %d' % (word, self.counts[word]))
