#!/usr/bin/python

import psycopg2
import sys


if len(list(sys.argv)) > 1:
    if len((list(sys.argv)[1]).split(',')) == 2:
        word = str(sys.argv[1])
        num_1 = int(word.split(',')[0])
        num_2 = int(word.split(',')[1])
        if num_2 < num_1:
            print "The second number must be greater than the first number"
        else:
            conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
            cur = conn.cursor()
            cur.execute("select word::bigint,sum(count) from Tweetwordcount where word ~ '^[0-9]+$' and word::bigint between %s and %s group by word::bigint order by word asc" % (num_1,num_2))
            records = cur.fetchall()
            for i in range(0,len(records)):
                print "%s: %s" % (str(records[i][0]),str(records[i][1]))
            conn.commit()
            conn.close()

    else:
        print "you must provide exactly two numbers, separated by a comma"
else:
    print "you must include two numbers, separated by a comma"
