install required packages (in virtual env)

python3 virtualenv coast_venv
source coast_venv/bin/activate
pip3 install flask
pip3 install sqlalchemy
pip3 install pyphen
pip3 install spacy==2.0.18
python3 -m spacy download en
python3 -m spacy download de
pip3 install gTTs
pip3 install waitress

auf dem sfs server muss spacy version 2.0.18 installiert werden, da für die neueren Versionen (ich glaube) wheels nicht passt

--> pip3 install spacy==2.0.18