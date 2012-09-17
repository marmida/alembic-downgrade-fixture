'define a single SA declarative model'

import sqlalchemy as sa
from sqlalchemy.ext.declarative import declarative_base 

Base = declarative_base()

class Stuff(Base):
    __tablename__ = 'stuff'

    id = sa.Column(sa.Integer, primary_key=True)
    name = sa.Column(sa.String(length=5), unique=True)