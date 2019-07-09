import sqlalchemy
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm import scoped_session

Base = declarative_base()


class Database:

    def __init__(self, path):
        # init sqlalchemy
        self.engine = sqlalchemy.create_engine(path, connect_args={'check_same_thread': False})

        Base.metadata.bind = self.engine
        Base.metadata.create_all(self.engine)

        session_factory = sessionmaker(bind=self.engine)
        Session = scoped_session(session_factory)
        self.session = Session()