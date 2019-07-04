#! /usr/bin/python3
import sys
import json
import sqlalchemy
from sqlalchemy import (create_engine, Column, Integer, String, MetaData, Table)

DB_WORDS_PATH = 'sqlite:///../db/defen.db'
wordsDatabase = create_engine(DB_WORDS_PATH)

conn = wordsDatabase.connect()

# create table
metaData = MetaData(wordsDatabase)
wordDef = Table('words', metaData, Column('word',String), Column('pos', String), Column('definition', String), Column('synonyms', String))
metaData.create_all()

wordnet_file = open("./wordnet/wordnet.json")
#wordnet_file = open("./wordnet/wordnet_first10000.json")
wordnetData = json.load(wordnet_file)

#print(wordnetData["synset"]["a1000283"]["word"][1])
#print(wordnetData["synset"]["a1000283"]["gloss"])
#print(wordnetData["synset"][1])

wordnet=wordnetData["synset"]

count = 0
for key,val in wordnet.items():
	if count % 1000 == 0:
		print('doing ', count, 'of', len(wordnet.items()))
#iterate the list "word" and print all the words one by one with gloss with its synonyms
	for i in val["word"]:
		Pos = val["pos"]
		# pos 's' means adjective satelite, which is a cluster of adjective words with similar meaning
		if Pos == 's':
			Pos = 'adj'
		elif Pos == 'a':
			Pos = 'adj'	
		elif Pos == 'n':
			Pos = 'noun'
		elif Pos == 'v':
			Pos = 'verb'
		else:
			Pos = 'adv'			
		Synonyms = val["word"][:]
		Synonyms.remove(i)
		#if there is _ in the list of the synonyms, replace with a break
		Synonyms = map(lambda x: x.replace('_', ' '), Synonyms)
		conn.execute(wordDef.insert().values(word=i, pos=Pos, definition=val["gloss"], synonyms=", ".join(Synonyms)))
	count += 1
print("added ", count, " words in the database")		
			