/* SQLEditor (MySQL (2))*/

CREATE TABLE user
(
id VARCHAR(255) NOT NULL,
email VARCHAR(255),
created DATETIME,
last DATETIME,
PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET=utf8;

CREATE TABLE auth_password
(
user VARCHAR(255),
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
user VARCHAR(255) NOT NULL,
figures INTEGER NOT NULL,
date DATE NOT NULL,
PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET=utf8;

CREATE INDEX id_idx ON user(id);
ALTER TABLE auth_password ADD FOREIGN KEY user_idxfk (user) REFERENCES user (id);

CREATE INDEX password_idx ON auth_password(password);
CREATE INDEX status_idx ON event(status);
ALTER TABLE event ADD FOREIGN KEY user_idxfk_1 (user) REFERENCES user (id);

ALTER TABLE event ADD FOREIGN KEY figures_idxfk (figures) REFERENCES figures (id);
