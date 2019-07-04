from DictionaryService import DictionaryService, DictionaryServiceen
from UserService import UserService, Authentication
from VerificationService import VerificationService
from Database import Database

import spacy
import DefinitionService


DB_USERS_PATH = 'sqlite:///../db/user.db'
DB_WORDS_PATH = 'sqlite:///../db/wordsen.db'

userDatabase = Database(DB_USERS_PATH)
wordsDatabase = Database(DB_WORDS_PATH)

dictionaryService = DictionaryService(wordsDatabase)
verificationService = VerificationServiceen(userDatabase)
userService = UserService(userDatabase)

user = userService.get_user('donghparke@gmail.com')
print(user.json())

#text = '!@#$%^&*()_Die Metall- und Elektroindustrie schrumpft, statt 32.000 Menschen leben nur noch 17.000 Einwohner dort.'
#text = 'Wir haben in den vergangenen Tagen bereits häufiger über ihn berichtet, jetzt ist es Gewissheit: Nach 37 Jahren ist die Regierungszeit von Diktator Robert Mugabe in Simbabwe zu Ende, die Details dazu hat die Süddeutsche Zeitung. Der 93-Jährige hatte zuletzt vergeblich versucht, seine Frau Grace ins Präsidentschaftsamt zu heben, nun soll stattdessen der Anfang November von Mugabe gefeuerte Emmerson Mnangagwa übernehmen. Der Schweizer SRF porträtiert diesen Nachfolger, den reichsten Mann des Landes, der von vielen „Krokodil“ genannt wird. Ob er wirkliche Veränderung bringt, ist völlig offen. Eine Analyse von Mugabes Amtszeit hat die Deutsche Welle.'
#text = 'Asylum-seekers in eastern Germany are 10 times more likely to be hate crime victims as those who live in the west, a study published on Sunday found.'
#text = 'a Sunday'
text = 'Am Sonntag werde ich ausschlafen.'

#response = DefinitionService.findDef('love','noun')
#print(response)

#response = DefinitionService.findDef('this','adv')
#print(response)

#response = dictionaryService.query_text(text, userService, user)
#print(response)

#response = dictionaryService.query_text(text, userService, user)