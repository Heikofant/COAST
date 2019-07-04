import spacy
import json

from DictionaryService import DictionaryService, Word, DictionaryServiceen
from UserService import UserService, Authentication
from VerificationService import VerificationService
from Database import Database

DB_USERS_PATH = 'sqlite:///../db/user.db'
DB_WORDS_PATH = 'sqlite:///../db/wordsen.db'

userDatabase = Database(DB_USERS_PATH)
wordsDatabase = Database(DB_WORDS_PATH)

dictionaryService = DictionaryServiceen(wordsDatabase)
verificationService = VerificationService(userDatabase)
userService = UserService(userDatabase)

user = userService.get_user('donghparke@gmail.com')

#entries = dictionaryService.database.session.query(Word).all()
#print('length: ', len(entries))

#w = dictionaryService.query_text('Write something.', userService, user)
#dictionaryService.add_word('testtesttest', '111', 'test-test-test', 'test', 'na')
#print(w)
#print(dictionaryService.query_word('testtesttest', 'na', userService, user))

wi = dictionaryService.find_def('man')
print(wi)