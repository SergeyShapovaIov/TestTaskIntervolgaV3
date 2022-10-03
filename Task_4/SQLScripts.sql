/*
Script for creating the main table "sportsmens"
*/
CREATE TABLE sportsmens(
	id INT NOT NULL AUTO_INCREMENT,
    full_name VARCHAR(255) NOT NULL,
    e_mail VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    age INT NOT NULL,
    date_time_addition TIMESTAMP DEFAULT NOW() ,
    passport_number VARCHAR(30) NOT NULL ,
    middle_ground FLOAT NOT NULL,
    biography VARCHAR(1000) NOT NULL,
    videopresentation VARCHAR(255) NOT NULL,
    CONSTRAINT id_pk PRIMARY KEY (id),
	CHECK (phone_number LIKE '+7_%_%_%_%_%_%_%_%_%_%')
);

/*
In order to run a SELECT query, you need to create two more tables: "competitions" and "results".
The design of these tables was done in the last task.
*/
CREATE TABLE competitions(
	id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    date_time DATETIME NOT NULL,
    CONSTRAINT id_pk PRIMARY KEY (id)
);

CREATE TABLE results(
id_competitions INT NOT NULL,
id_sportsmen INT NOT NULL,
result DOUBLE,
CONSTRAINT id_competitions_sportsmen_pk PRIMARY KEY (id_competitions,id_sportsmen),
CONSTRAINT id_competitions_competitions_fk FOREIGN KEY (id_competitions)
	REFERENCES competitions (id),
CONSTRAINT id_sportsmen_sportsmens_fk FOREIGN KEY (id_sportsmen)
	REFERENCES sportsmens (id)
);

/*
Let's fill the tables with test data, to illustrate the execution of the query.
*/

INSERT INTO sportsmens VALUES (1,'Ryan Sands','ryan_sands@gmail.com','+79015672361','1982-03-10',40,CURRENT_TIMESTAMP, '1213456798', 3.4, 'good sportsman', 'example_presentation.pptx');
INSERT INTO sportsmens VALUES (2,'Kilian Burgada','kilian_burgada@gmail.com','+79057832134','1987-10-27',35,CURRENT_TIMESTAMP, '1213456798', 2.1, 'good sportsman', 'example_presentation.pptx');
INSERT INTO sportsmens VALUES (3,'Pau Capelle','pau_capelle@gmail.com','+79015672361','1982-03-10',40,CURRENT_TIMESTAMP, '1213456798', 3.4, 'good sportsman', 'example_presentation.pptx');
INSERT INTO sportsmens VALUES (4,'Jim Walmsley','jim_walmsley@gmail.com','+79015672361','1982-03-10',40,CURRENT_TIMESTAMP, '1213456798', 3.4, 'good sportsman', 'example_presentation.pptx');
INSERT INTO sportsmens VALUES (5,'Xavier Tevnar','xavier_tevnar@gmail.com','+79015672361','1982-03-10',40,CURRENT_TIMESTAMP, '1213456798', 3.4, 'good sportsman', 'example_presentation.pptx');
INSERT INTO sportsmens VALUES (6,'Francois DAin','francois_DAin@gmail.com','+79015672361','1982-03-10',40,CURRENT_TIMESTAMP, '1213456798', 3.4, 'good sportsman', 'example_presentation.pptx');
INSERT INTO sportsmens VALUES (7,'Tom Evans','tom_evans@gmail.com','+79015672361','1982-03-10',40,CURRENT_TIMESTAMP, '1213456798', 3.4, 'good sportsman', 'example_presentation.pptx');
INSERT INTO sportsmens VALUES (8,'Damian Hall','damian_hall@gmail.com','+79015672361','1982-03-10',40,CURRENT_TIMESTAMP, '1213456798', 3.4, 'good sportsman', 'example_presentation.pptx');
INSERT INTO sportsmens VALUES (9,'Rui Ueda','rui_ueda@gmail.com','+79015672361','1982-03-10',40,CURRENT_TIMESTAMP, '1213456798', 3.4, 'good sportsman', 'example_presentation.pptx');
INSERT INTO sportsmens VALUES (10,'Dylan Bowman','dylan_bowman@gmail.com','+79015672361','1982-03-10',40,CURRENT_TIMESTAMP, '1213456798', 3.4, 'good sportsman', 'example_presentation.pptx');

INSERT INTO competitions VALUES (1,'Moscow competition','2024-10-31 10:10:00');
INSERT INTO competitions VALUES (2,'Volgograd competition','2024-10-31 10:10:00');
INSERT INTO competitions VALUES (3,'Omsc competition','2024-10-31 10:10:00');
INSERT INTO competitions VALUES (4,'Saratov competition','2024-10-31 10:10:00');

INSERT INTO results VALUES (1,7,30.5);
INSERT INTO results VALUES (2,7,30.5);
INSERT INTO results VALUES (3,7,30.5);
INSERT INTO results VALUES (4,7,30.5);
INSERT INTO results VALUES (1,1,30.5);
INSERT INTO results VALUES (2,1,30.5);
INSERT INTO results VALUES (3,1,30.5);
INSERT INTO results VALUES (1,9,30.5);
INSERT INTO results VALUES (2,9,30.5);
INSERT INTO results VALUES (1,4,30.5);
INSERT INTO results VALUES (1,10,30.5);
INSERT INTO results VALUES (2,4,30.5);
INSERT INTO results VALUES (2,5,30.5);
INSERT INTO results VALUES (3,6,30.5);

/*
SQL query to display the top 5 athletes by number of attended competitions
*/
SELECT full_name, COUNT(id_competitions) AS number_competitions
FROM marafon.sportsmens 
INNER JOIN results ON sportsmens.id = results.id_sportsmen GROUP BY id_sportsmen
ORDER BY number_competitions DESC 
LIMIT 5