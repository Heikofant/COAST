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

duplicates =[]
for w in words:
    for w2 in words:
        if w['id'] != w2['id'] and w['text'] == w2['text'] and w['hyphenation'] == w2['hyphenation'] and w['user_first_name'] == w2['user_first_name'] and w['user_last_name'] == w2['user_last_name']:
            if not duplicates.__contains__(w['id']) and not duplicates.__contains__(w2['id']):
                duplicates.append(w['id'])



#for d in duplicates:
#    print(d)
#    userService.delete_word(d)
#    verificationService.cleanup_proposals_by_id(d)
