#! /usr/bin/python3

import sqlalchemy
from sqlalchemy import (create_engine, Column, Integer, String, DateTime, MetaData, select, and_)
from sqlalchemy.orm import sessionmaker
from sqlalchemy import func
from sqlalchemy.ext.declarative import declarative_base

DB_WORDS_PATH = 'sqlite:///../db/defen.db'
wordsDatabase = create_engine(DB_WORDS_PATH)
conn = wordsDatabase.connect()

metaData = MetaData()

metaData.reflect(bind=wordsDatabase)

words = metaData.tables['words']

Session = sessionmaker()
Session.configure(bind=wordsDatabase)
session = Session()

def findDef(word, pos):
	# in case there's no pos info, get all the definitions without pos info
	if pos == 'na':
		wordsToPrint = session.query(words).filter(func.lower(words.c.word) == word.lower()).all()
	else:
		#get a list of the word with the given pos
		wordsToPrint = session.query(words).filter(and_(func.lower(words.c.word) == word.lower(), words.c.pos == pos)).all()	
	toPrintdef = []
	if not wordsToPrint:
		#in case there's no word that matches the given pos in the dictionary database, get to the definition of the word without pos info
		wordsToPrint = session.query(words).filter(func.lower(words.c.word) == word.lower()).all()
		for row in wordsToPrint:
			toPrintdef.append(row.definition)
		#If there's still no matching word in the dictionary database
		if not wordsToPrint:
			toPrintdef.append('This word doesn\'t exist in the dictionary.')
	else:	
		for row in wordsToPrint:
			toPrintdef.append(row.definition)
	
	if len(toPrintdef) > 3:
		toPrintdef = toPrintdef[:3]
	return ', '.join(toPrintdef) #return a string
	
def findSyn(word, pos):
	# in case there's no pos info, get all the definitions without pos info
	if pos == 'na':
		wordsToPrint = session.query(words).filter(func.lower(words.c.word) == word.lower()).all()
	else:
		#get a list of the word with the given pos
		wordsToPrint = session.query(words).filter(and_(func.lower(words.c.word) == word.lower(), words.c.pos == pos)).all()	
	toPrintdef = []
	if not wordsToPrint:
		#in case there's no word that matches the given pos in the dictionary database, get to the definition of the word without pos info
		wordsToPrint = session.query(words).filter(func.lower(words.c.word) == word.lower()).all()
		for row in wordsToPrint:
			toPrintdef.append(row.synonyms)
		#If there's still no matching word in the dictionary database
		if not wordsToPrint:
			toPrintdef.append('This word doesn\'t exist in the dictionary.')
	else:	
		for row in wordsToPrint:
			toPrintdef.append(row.synonyms)
	
	#get rid of duplicates
	toPrintdef = list(dict.fromkeys(toPrintdef))
	
	return	', '.join(list(filter(None, toPrintdef)))

#print(findDef('a', 'na'))
#print(findSyn('a', 'na'))