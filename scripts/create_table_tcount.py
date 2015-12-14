import psycopg2

conn = psycopg2.connect(database="tcount", user="postgres",port="5432")
cur = conn.cursor()
cur.execute('''CREATE TABLE Tweetwordcount
       (word TEXT PRIMARY KEY     NOT NULL,
       count INT     NOT NULL);''')
conn.commit()
conn.close()
