Instructions
============

This is a fixture showing how alembic hits an error when trying to downgrade 
table drops on postgres.

To invoke these tests, run from this directory:

    make check

To reset the database before running again, do:

    make clean

Then you can re-run `make check` again.

Note
----
The makefile assumes that your default psql login has rights to create
databases and roles.  If that's not true, you will need to hack it.