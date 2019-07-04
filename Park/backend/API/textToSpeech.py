from gtts import gTTS
import base64
import os

#tts = gTTS(text='hi how r u', lang='en')
#tts.save("mp3/good.mp3")

def textToSpeech(word):
	# first convert the string to an mp3 file
	mpthree = str(hash(word))+".mp3" # use hash for the file name so it's not one fixed name

	tts = gTTS(word, lang='en')
	tts.save(mpthree)
	
	# read the audio information 
	mpContent = open(mpthree,"rb")
	bin_data = mpContent.read()
	mpContent.close()
	
	# delete the mp3 file
	os.remove(mpthree)
	
	# encode in base64 and return
	return 'data:audio/mp3;base64,'+base64.b64encode(bin_data).decode("ascii")
	
def textToSpeechger(word):

	mpthree = str(hash(word))+".mp3" # use hash for the file name so it's not one fixed name

	tts = gTTS(word, lang='de')
	tts.save(mpthree)
	
	# read the audio information
	mpContent = open(mpthree,"rb")
	bin_data = mpContent.read()
	mpContent.close()
	
	# delete the mp3 file
	os.remove(mpthree)
	
	# encode in base64 and return
	return 'data:audio/mp3;base64,'+base64.b64encode(bin_data).decode("ascii")
	
	
#print(textToSpeechger('Wird das gehen?'))	
#print(textToSpeech('This is just a test'))