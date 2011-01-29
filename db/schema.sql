/* user table

We'll add other authtypes and extra columns as needed to handle external auth.
user.id will be used in user-specific URLs.

user.email is optional.
*/
CREATE TABLE user
(
    id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    userid VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255),
    authtype ENUM('local') DEFAULT 'local',
    email VARCHAR(255),
PRIMARY KEY (id)
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

CREATE INDEX userid_idx ON user(userid);
ALTER TABLE figures ADD FOREIGN KEY owner_idxfk (owner) REFERENCES user (id);

CREATE INDEX status_idx ON event(status);
ALTER TABLE event ADD FOREIGN KEY user_idxfk (user) REFERENCES user (id);

ALTER TABLE event ADD FOREIGN KEY figures_idxfk (figures) REFERENCES figures (id);