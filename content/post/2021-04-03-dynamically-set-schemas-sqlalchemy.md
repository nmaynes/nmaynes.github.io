---
author: nmaynes1
categories:
- Tutorials
tags:
- data
- databases
- sqlalchemy
- orm
title: "Dynamically Set ORM Schemas via Sqlalchemy"
date: 2021-04-03T07:54:57-04:00
---

Sometimes the solution to a problem is so obvious, it takes a while to figure it out. I recently stumbled on such a
problem when trying to configure a set of Object Relational Mappings (ORM) to support an application with
the same set of table objects across different schemas in Postgres. Developing an ORM to support this pattern,
a multi-tenant database model, proved challenging because of where I started. Below, I will detail the correct
way to support the multi-tenant pattern as well as various approaches I came across and why they should not be used.

I think one of the reasons good information is difficult to find is due to how the problem can be described. When
thinking about the behavior of the application, it makes sense to describe setting the schema name for each tenant
as a dynamic process. Something that is not defined in the ORM but is defined when the ORM is called and instantiated.
So I began searching SQLAlchemy documentation to find ways to dynamically set schemas. These searches did not yield
what I was looking to find until I stumbled across the documentation for
["Multi-Tenancy Schema Translation for Table objects"](https://stackoverflow.com/questions/9298296/sqlalchemy-support-of-postgres-schemas).

I searched StackOverflow for examples or explanations of how to properly define the schema mapping and noticed lots of
code that was ingenious and out of date or just wrong.


#### StackOverflow questions with a range of answers
[Stackoverflow question asking how to dynamically set schema](https://stackoverflow.com/questions/29595161/sqlalchemy-dynamic-schema-on-entity-at-runtime/55979164#55979164)
[Stackoverflow question about sqlalchemy support of postgres schemas](https://stackoverflow.com/questions/9298296/sqlalchemy-support-of-postgres-schemas)

I needed a solution that
would dynamically set the schema using SQLAchemy's declarative model, tear down the objects created by the ORM in the
correct schemas, provide full support for constraints and indexes, and support Alembic migrations.
It almost goes without saying, I also wanted something that would be easy to maintain.
Luckily defining a schema translation map is pretty easy.

### schema_translation_map
A simple example includes defining a declarative ORM and then calling `Base.metadata.create_all(conn)` via a function
that iterates over a list of schema names. Assuming you already have the database connection sorted out, we just need to
provide the Engine, Connection, or Session object with a `schema_translation_map`. I will demonstrate with an Engine
object from SQLAlchemy 1.3.x. (Note, other versions of SQLAlchemy provide similar behavior but require small tweaks.
Consult the SQLAlchemy documentation for the version you are using.)

```python
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import String
from sqlalchemy.schema import CreateSchema
from sqlalchemy.dialects.postgresql import UUID
import uuid

Base = declarative_base()
class MyTable(Base):
    __tablename__ = "my_table"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    name = Column(String)


schemas = ["schema_1", "schema_2"]

connection_string = "postgresql://your_connection_details_go_here"

for schema in schemas:
    engine = create_engine(connection_string, echo=True, execution_options={"schema_translate_map": {None: schema}})
    with engine.connect() as conn:
        if engine.dialect.has_schema(conn, schema):
            Base.metadata.create_all(conn)
        else:
            conn.execute(CreateSchema(schema))
            Base.metadata.create_all(conn)
```

The code above creates an ORM for MyTable using declarative mapping. It then loops through the schema names and creates
an engine for each with the schema name as an argument to `schema_translate_map`. It then checks whether the schema
exists. If the schema does exist, it calls `Base.metadata.create_all()` to create the database objects according to the
ORM. If the schema does not exist, it is created first.

This is a simple example. I recommend you create a wrapper function to call Base.metadata.create_all() to provide even
more logic for handling various deployment scenarios.