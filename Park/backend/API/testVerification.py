from DictionaryService import DictionaryServiceen
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

# dictionaryService.add_word('feb', '1', 'feb', 'feb', 'noun')

print('---------------------------------')
print('----------- User Words ----------')
print('---------------------------------')

words = userService.list_all_words()
for w in words:
    print(w)

print('---------------------------------')
print('----------- Proposals -----------')
print('---------------------------------')

proposals = verificationService.list_proposals()
for p in proposals:
    print(p)

print()
print('---------------------------------')
print('--------- Added entries ---------')
print('---------------------------------')

entries = dictionaryService.list_added_entries()
for e in entries:
    print(e)


#remove duplicate entries from the same user
userService.cleanup_duplicate_entries()
