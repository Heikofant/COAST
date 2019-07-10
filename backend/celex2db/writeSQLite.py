import sys, os

sys.path.append(os.path.relpath("../API"))

import DictionaryService
from Database import Database

DB_WORDS_PATH = 'sqlite:///../db/words.db'
DB_WORDS_PATH_EN = 'sqlite:///../db/wordsen.db'

wordsDatabase = Database(DB_WORDS_PATH)
wordsDatabase_en = Database(DB_WORDS_PATH_EN)

def write_sqlite(dictionary, step_size):
    print("--- connecting to database ---")

    dictionary_service = DictionaryService.DictionaryService(wordsDatabase)

    print("--- writing database entries ---")

    # write model to db
    num_added = 0
    num_skipped = 0
    current = 0

    for word in dictionary.words:

        if current > 0 and current % step_size == 0:
            #dictionary_service.commit()
            print("added to database: " + str(num_added))
            print("skipped: " + str(num_skipped))

        current = current + 1

        if dictionary_service.add_word(word.text, word.stress_pattern, word.hyphenation, word.lemma, word.pos, bulk_add=True):
            num_added = num_added + 1
        else:
            num_skipped = num_skipped + 1

    #dictionary_service.commit()
    print("added to database: " + str(num_added))
    print("skipped: " + str(num_skipped))
    
    
def write_sqlite_en(dictionary, step_size):
    print("--- connecting to database ---")

    dictionary_service = DictionaryService.DictionaryServiceen(wordsDatabase_en)

    print("--- writing database entries ---")

    # write model to db
    num_added = 0
    num_skipped = 0
    current = 0

    for word in dictionary.words:

        if current > 0 and current % step_size == 0:
            #dictionary_service.commit()
            print("added to database: " + str(num_added))
            print("skipped: " + str(num_skipped))

        current = current + 1

        if dictionary_service.add_word(word.text, word.stress_pattern, word.hyphenation, word.lemma, word.pos, bulk_add=True):
            num_added = num_added + 1
        else:
            num_skipped = num_skipped + 1

    #dictionary_service.commit()
    print("added to database: " + str(num_added))
    print("skipped: " + str(num_skipped))    
