-- set up connection
sqlplus tvdb/tvdb@xe;

-- reverse list for dropping
DROP TABLE PLAYED_BY;
DROP TABLE APPEARS_IN;
DROP TABLE CREATED_BY;
DROP TABLE INVOLVED_WITH;
DROP TABLE PROVIDES_SERIES;
DROP TABLE COMMENTS;
DROP TABLE EPISODE;
DROP TABLE CHARACTERS;
DROP TABLE SEASON;
DROP TABLE PROVIDER;
DROP TABLE PERSON;
DROP TABLE SERIES;


-- create tables
CREATE TABLE series
	( year	NUMBER(4)
	, name	VARCHAR(50) NOT NULL
	, constraint series_pk PRIMARY KEY (year, name)
	);

CREATE TABLE person
	( name	VARCHAR(50) NOT NULL
	, dob	DATE NOT NULL
	, bio	VARCHAR(255)
	, CONSTRAINT person_pk PRIMARY KEY (name, dob)
	);

CREATE TABLE provider
	( name	VARCHAR(50) NOT NULL
	, acronym	VARCHAR(50)
	, CONSTRAINT provider_pk PRIMARY KEY (name)
	);

CREATE TABLE SEASON 
	( num INTEGER NOT NULL
	, series_name VARCHAR(50) NOT NULL
	, series_year INTEGER NOT NULL
	, CONSTRAINT season_pk PRIMARY KEY (num, series_name, series_year)
	);
ALTER TABLE SEASON ADD FOREIGN KEY(series_name, series_year) REFERENCES SERIES(name, year);


CREATE TABLE CHARACTERS 
	( name VARCHAR(25) NOT NULL
	, syear INTEGER NOT NULL
	, sname VARCHAR(50) NOT NULL
	, CONSTRAINT characters_pk PRIMARY KEY(name, syear, sname)
	);
ALTER TABLE CHARACTERS ADD FOREIGN KEY(syear, sname) REFERENCES SERIES(year, name);


CREATE TABLE EPISODE 
	( num INTEGER NOT NULL
	, name VARCHAR(25)
	, air_date DATE
	, plot_summary VARCHAR(255)
	, seas_num INTEGER NOT NULL
	, series_name VARCHAR(50) NOT NULL
	, series_year INTEGER NOT NULL
	, CONSTRAINT episode_pk PRIMARY KEY(num, seas_num, series_name, series_year)
	);
ALTER TABLE EPISODE ADD FOREIGN KEY(seas_num, series_name, series_year) REFERENCES SEASON(num, series_name, series_year);


CREATE TABLE COMMENTS 
	( author VARCHAR(30) NOT NULL
	, time DATE NOT NULL
	, message VARCHAR(255) NOT NULL
	, pname VARCHAR(50)
	, pdob DATE
	, provname VARCHAR(50)
	, sname VARCHAR(50)
	, syear INTEGER
	, seasnum INTEGER
	, epnum INTEGER
	, cname VARCHAR(25)
	, commenttype VARCHAR(1) NOT NULL
	, CONSTRAINT comment_pk PRIMARY KEY(author, time,commenttype)
	);
ALTER TABLE COMMENTS ADD FOREIGN KEY(pname, pdob) REFERENCES PERSON(name, dob);
ALTER TABLE COMMENTS ADD FOREIGN KEY(provname) REFERENCES PROVIDER(name);
ALTER TABLE COMMENTS ADD FOREIGN KEY(sname, syear) REFERENCES SERIES(name, year);
ALTER TABLE COMMENTS ADD FOREIGN KEY(seasnum, sname, syear) REFERENCES SEASON(num, series_name, series_year);
ALTER TABLE COMMENTS ADD FOREIGN KEY(epnum, seasnum, sname, syear) REFERENCES EPISODE(num, seas_num, series_name, series_year);
ALTER TABLE COMMENTS ADD FOREIGN KEY(cname, syear, sname) REFERENCES CHARACTERS(name, syear, sname);


CREATE TABLE PROVIDES_SERIES 
	( pname VARCHAR(50) NOT NULL
	, syear INTEGER NOT NULL
	, sname VARCHAR(50) NOT NULL
	, CONSTRAINT provides_series_pk PRIMARY KEY(pname, syear, sname)
	);
ALTER TABLE PROVIDES_SERIES ADD FOREIGN KEY(syear, sname) REFERENCES SERIES(year, name);
ALTER TABLE PROVIDES_SERIES ADD FOREIGN KEY(pname) REFERENCES PROVIDER(name);


CREATE TABLE INVOLVED_WITH 
	( pname VARCHAR(50) NOT NULL
	, pdob DATE NOT NULL
	, enum INTEGER NOT NULL
	, seasnum INTEGER NOT NULL
	, sname VARCHAR(50) NOT NULL
	, syear INTEGER NOT NULL
	, role VARCHAR(1) NOT NULL
	, CONSTRAINT involved_with_pk PRIMARY KEY(pname, pdob, enum, seasnum, sname, syear, role)
	);
ALTER TABLE INVOLVED_WITH ADD FOREIGN KEY(pname, pdob) REFERENCES PERSON(name, dob);
ALTER TABLE INVOLVED_WITH ADD FOREIGN KEY(enum, seasnum, sname, syear) REFERENCES EPISODE(num, seas_num, series_name, series_year);



CREATE TABLE CREATED_BY 
	( pname VARCHAR(50) NOT NULL
	, pdob DATE NOT NULL
	, sname VARCHAR(50) NOT NULL
	, syear INTEGER NOT NULL
	, CONSTRAINT created_by_pk PRIMARY KEY(pname, pdob, sname, syear)
	);
ALTER TABLE CREATED_BY ADD FOREIGN KEY(pname, pdob) REFERENCES PERSON(name, dob);
ALTER TABLE CREATED_BY ADD FOREIGN KEY(sname, syear) REFERENCES SERIES(name, year);




CREATE TABLE APPEARS_IN 
	( cname VARCHAR(25) NOT NULL
	, syear INTEGER NOT NULL
	, sname VARCHAR(50) NOT NULL
	, epnum INTEGER NOT NULL
	, seasnum INTEGER NOT NULL
	, CONSTRAINT appears_in_pk PRIMARY KEY(cname, syear, sname, epnum, seasnum)
	);
ALTER TABLE APPEARS_IN ADD FOREIGN KEY(epnum, seasnum, syear, sname) REFERENCES EPISODE(num, seas_num, series_year, series_name);
ALTER TABLE APPEARS_IN ADD FOREIGN KEY(cname, syear, sname) REFERENCES CHARACTERS(name, syear, sname);




CREATE TABLE PLAYED_BY 
	( cname VARCHAR(25) NOT NULL
	, syear INTEGER NOT NULL
	, sname VARCHAR(50) NOT NULL
	, pname VARCHAR(50) NOT NULL
	, pdob DATE NOT NULL
	, CONSTRAINT played_by_pk PRIMARY KEY(cname, syear, sname, pname, pdob)
	);
ALTER TABLE PLAYED_BY ADD FOREIGN KEY(pname, pdob) REFERENCES PERSON(name, dob);
ALTER TABLE PLAYED_BY ADD FOREIGN KEY(cname, syear, sname) REFERENCES CHARACTERS(name, syear, sname);



