-- #Join Example Database
-- # Create a database named join_test_db and run the SQL provided in the Join Example DB section above; to create the same setup used for this lesson.
-- #
-- # Insert 4 new users into the database. One should have a NULL role. The other three should be authors.
-- #

USE employees;
CREATE TABLE roles (
                       id INT UNSIGNED NOT NULL AUTO_INCREMENT,
                       name VARCHAR(100) NOT NULL,
                       PRIMARY KEY (id)
);
CREATE TABLE users (
                       id INT UNSIGNED NOT NULL AUTO_INCREMENT,
                       name VARCHAR(100) NOT NULL,
                       email VARCHAR(100) NOT NULL,
                       role_id INT UNSIGNED DEFAULT NULL,
                       PRIMARY KEY (id),
                       FOREIGN KEY (role_id) REFERENCES roles (id)
);
INSERT INTO roles (name) VALUES ('admin');
INSERT INTO roles (name) VALUES ('author');
INSERT INTO roles (name) VALUES ('reviewer');
INSERT INTO roles (name) VALUES ('commenter');
INSERT INTO users (name, email, role_id) VALUES
                                             ('luke', 'luke@skywalker.com',2),
                                             ('leia','leia@organa.com',2),
                                             ('yoda','yoda@usetheforce.com',NULL),
                                             ('darth','darth@darkside.com',2);
# Use JOIN, LEFT JOIN, and RIGHT JOIN to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
# #
SELECT users.name as user_name, roles.name as role_name
FROM users
         JOIN roles ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
         LEFT JOIN roles ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
         RIGHT JOIN roles ON users.role_id = roles.id;

SELECT users.name as user_name,COUNT(users.name), roles.name as role_name,COUNT(roles.name)
FROM users
         JOIN roles ON users.role_id = roles.id GROUP BY users.name,roles.name;

SELECT users.name as user_name,COUNT(users.name), roles.name as role_name,COUNT(roles.name)
FROM users
         LEFT JOIN roles ON users.role_id = roles.id GROUP BY users.name,roles.name;

SELECT users.name as user_name,COUNT(users.name), roles.name as role_name,COUNT(roles.name)
FROM users
         RIGHT JOIN roles ON users.role_id = roles.id GROUP BY users.name,roles.name;
-- # Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use COUNT and the appropriate join type to get a list of roles along with the number of users that have a given role. Hint: You will also need to use GROUP BY in the query.
