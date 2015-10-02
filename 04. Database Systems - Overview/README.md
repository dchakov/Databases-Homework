## Database Systems - Overview
### _Homework_

1. #### What database models do you know?
	
	- **Hierarchial(tree)**	is a data model in which the data is organized into a tree-like structure. The data is stored as records which are connected to one another through links. A record is a collection of fields, with each field containing only one value. The entity type of a record defines which fields the record contains.
	- **Network/graph** is a database model conceived as a flexible way of representing objects and their relationships. Its distinguishing feature is that the schema, viewed as a graph in which object types are nodes and relationship types are arcs, is not restricted to being a hierarchy or lattice.
	- **Relational(table)** is a digital database whose organization is based on the relational model of data. This model organizes data into one or more tables (or "relations") of rows and columns, with a unique key for each row. Generally, each entity type described in a database has its own table, the rows representing instances of that type of entity and the columns representing values attributed to that instance. Because each row in a table has its own unique key, rows in a table can be linked to rows in other tables by storing the unique key of the row to which it should be linked (where such unique key is known as a "foreign key"). Codd showed that data relationships of arbitrary complexity can be represented using this simple set of concepts.
	- **Object-oriented** is a database management system in which information is represented in the form of objects as used in object-oriented programming.



1. #### Which are the main functions performed by a Relational Database Management System (RDBMS)?
Relational database management systems (RDBMS) support the relational (table-oriented) data model. The schema of a table (relation schema) is defined by the table name and a fixed number of attributes with fixed data types. A record (entity) corresponds to a row in the table and consists of the values of each attribute. A relation thus consists of a set of uniform records.
Manage data stored in tables.Implement creating deleting tables and relationship between them.Adding, changing, deleting,searching and retrieving of data stored in the tables.

1. #### Define what is "table" in database terms.
Database table consist of data, arranged in rows and columns.All rows have the same structure.Columns have name and type.

1. #### Explain the difference between a primary and a foreign key.


	- ***Primary key*** is a column of the table that uniquely identifies its rows(usually its is a number).Two records(rows) are different if and only if their primary keys are different.The 
	- ***foreign key*** is an identifier of a record located in another table(usually its primary key).

1. #### Explain the different kinds of relationships between tables in relational databases.
	- **One-to-many**.A single record in the first table has many corresponding records in the second table

	- **Many-to-many**.Records in the first table have many corresponding records in the second one and vice versa.Implemented through additional table.


	- **One-to-one**.A single record in a table corresponds to a single record in the other table.

1. #### When is a certain database schema normalized?
When all the repeating data is removed from the table then the relational schema is normalized.Non-normalized schemas contain many data repetitions.

  * **What are the advantages of normalized databases?**
	
	Smaller database: By eliminating duplicate data, you will be able to reduce the overall size of the database.
			
	While fully normalized databases require more joins, joins are generally very fast if indexes are available on the join columns.

	Better performance:
	Narrow tables: Having more fine-tuned tables allows your tables to have less columns and allows you to fit more records per data page.
	Only join tables that you need.

1. #### What are database integrity constraints and when are they used?
Integrity constraints ensure data integrity in the database tables.Enforce data rules which cannot be violated.
	
	- **Primary key constraint**.Ensures that the primary key of a table has unique value for each table row.
	- **Unique key constraint**.Ensures that all values in a certain column (or a group of columns) are unique.
	- **Foreign key constraint**.Ensures that the value in given column is a key from another table.
	- **Check constraint**.Ensures that values in a certain column meet some predefined condition.

1. #### Point out the pros and cons of using indexes in a database.
	Indices speed up searching of values in a certain column or group of columns
	Index searching is often faster, since indexes tend to be narrower and shorter.
	You usually have fewer indexes per table, so data modification commands are faster.
	Fewer indexes per table mean faster maintenance tasks such as index rebuilds.

1. #### What's the main purpose of the SQL language?
	SQL (Structured Query Language).Standardized declarative language for manipulation of relational databases.SQL language supports creating, altering, deleting tables and other objects in the database.Searching, retrieving, inserting, modifying and deleting table data (rows).

1. #### What are transactions used for?
	Transactions are a sequence of database operations which are executed as a single unit.Either all of them execute successfully.Or none of them is executed at all.
  * **Give an example.**
	A bank transfer from one account into another (withdrawal + deposit).If either the withdrawal or the deposit fails the entire operation should be cancelled

1. #### What is a NoSQL database?
	NoSQL (non-relational) databases use document-based model.It is a schema-free document storage.Support  concurrency and transactions indexing and querying .Support operations Create, Read, Update, Delete.

1. #### Explain the classical non-relational data models.
	**Relational databases**
	Data is stored as table rows and there is a relationships between related rows.Single entity spans multiple tables.RDBMS systems are very mature, rock solid

	**NoSQL databases**
	Data stored as documents.Single entity (document) is a single record.Documents do not have a fixed structure

1. #### Give few examples of NoSQL databases and their pros and cons.
	**MongoDB** ***Document Stores***

	Document stores, also called document-oriented database systems, are characterized by their schema-free organization of data.	Records do not need to have a uniform structure, i.e. different records may have different columns.	The types of the values ​​of individual columns can be different for each record.
	Columns can have more than one value (arrays).
	Records can have a nested structure.
	
	**Redis** ***Key-value Stores***

	Key-value stores are probably the simplest form of database management systems. They can only store pairs of keys and values, as well as retrieve values when a key is known.
	These simple systems are normally not adequate for complex applications. On the other hand, it is exactly this simplicity, that makes such systems attractive in certain circumstances. For example resource-efficient key-value stores are often applied in embedded systems or as high performance in-process databases.

	**Cassandra** ***Wide Column Stores***

	Wide column stores, also called extensible record stores, store data in records with an ability to hold very large numbers of dynamic columns. Since the column names as well as the record keys are not fixed, and since a record can have billions of columns, wide column stores can be seen as two-dimensional key-value stores.
	Wide column stores share the chracteristic of being schema-free with document stores, however the implementation is very different.