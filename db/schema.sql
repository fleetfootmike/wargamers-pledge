/* SQLEditor (MySQL (2))*/

CREATE TABLE user
(
id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
name VARCHAR(255),
email VARCHAR(255),
created DATETIME,
last DATETIME,
PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET=utf8;

CREATE TABLE auth_password
(
user INTEGER,
login VARCHAR(255) NOT NULL UNIQUE,
password VARCHAR(255) NOT NULL
) ENGINE=InnoDB CHARACTER SET=utf8;

CREATE TABLE figures
(
id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
status ENUM('bought','painted') NOT NULL,
number INTEGER NOT NULL,
owner INTEGER NOT NULL,
notes TINYTEXT,
PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET=utf8;

CREATE TABLE event
(
id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
status ENUM('bought','painted') NOT NULL,
user INTEGER NOT NULL,
figures INTEGER NOT NULL,
date DATE NOT NULL,
PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET=utf8;

ALTER TABLE auth_password ADD FOREIGN KEY user_idxfk (user) REFERENCES user (id);

CREATE INDEX password_idx ON auth_password(password);
ALTER TABLE figures ADD FOREIGN KEY owner_idxfk (owner) REFERENCES user (id);

CREATE INDEX status_idx ON event(status);
ALTER TABLE event ADD FOREIGN KEY user_idxfk_1 (user) REFERENCES user (id);

ALTER TABLE event ADD FOREIGN KEY figures_idxfk (figures) REFERENCES figures (id);
