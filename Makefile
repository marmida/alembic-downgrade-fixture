# run 'make check' to run the test
# this assumes your default psql login has rights to create dbs and roles

DBNAME=alembictest
DBUSER=alembictest
DBPASS=1234
VIRTUALENVDIR=venv

.PHONY: clean check

check: venv
	echo 'Creating database $(DBNAME) and adding user $(DBUSER)'
	createuser -DRS $(DBUSER)
	echo "create database $(DBNAME); grant all privileges on database $(DBNAME) to $(DBUSER); alter role $(DBUSER) password '1234'" | psql -d postgres
	echo 'Creating revisions'
	PYTHONPATH=rev0 $(VIRTUALENVDIR)/bin/alembic revision -m 'initial' --autogenerate
	PYTHONPATH=rev0 $(VIRTUALENVDIR)/bin/alembic upgrade head
	PYTHONPATH=rev1 $(VIRTUALENVDIR)/bin/alembic revision -m 'drop' --autogenerate
	PYTHONPATH=rev1 $(VIRTUALENVDIR)/bin/alembic upgrade head
	# this next command fails on the following: 
	#    sqlalchemy.exc.ProgrammingError: (ProgrammingError) syntax error at or near "stuff_id_seq"
	PYTHONPATH=rev1 $(VIRTUALENVDIR)/bin/alembic downgrade -1

clean:
	echo 'drop database $(DBNAME); drop user $(DBUSER);' | psql -d postgres
	rm migrations/versions/*

venv:
	echo 'Creating python environment'
	virtualenv venv
	$(VIRTUALENVDIR)/bin/pip install -r requirements.txt