CREATE TABLE novelists (
	id serial primary key,
	name varchar(120) NOT NULL UNIQUE,
	gender varchar(10) NOT NULL,
	born varchar(25) NOT NULL,
	died varchar(25),
	nationality varchar(50) NOT NULL
);

CREATE TABLE novels (
    id serial primary key,
    title varchar(250) NOT NULL UNIQUE,
    year_published int NOT NULL,
	genre varchar(250),
	novelist_id serial,
	FOREIGN KEY (novelist_id) REFERENCES novelists(id)
);
