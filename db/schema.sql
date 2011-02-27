/* SQLEditor (MySQL (2))*/

CREATE TABLE manufacturer
(
id VARCHAR(255) UNIQUE,
PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET=utf8;

CREATE TABLE figure
(
id VARCHAR(255) UNIQUE,
manufacturer VARCHAR(255),
scale VARCHAR(15),
PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET=utf8;

CREATE TABLE user
(
id VARCHAR(255) NOT NULL UNIQUE,
email VARCHAR(255),
created DATETIME,
last DATETIME,
PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET=utf8;

CREATE TABLE auth_twitter
(
user VARCHAR(255) UNIQUE,
twitter_user VARCHAR(255),
twitter_user_id VARCHAR(255) UNIQUE,
twitter_access_token VARCHAR(255),
twitter_access_token_secret VARCHAR(255),
PRIMARY KEY (user)
) ENGINE=InnoDB CHARACTER SET=utf8;

CREATE TABLE purchase
(
id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
num INTEGER NOT NULL,
user VARCHAR(255) NOT NULL,
manufacturer VARCHAR(255) COMMENT 'Autocomplete from manufacturer table',
description VARCHAR(255) COMMENT 'Autocomplete from figure table for given manufacturer',
scale VARCHAR(15),
acquired DATE,
notes TINYTEXT,
PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET=utf8;

CREATE TABLE action
(
id INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
purchase INTEGER NOT NULL COMMENT '...I want to paint some of these....',
use_as VARCHAR(255) COMMENT '...as Balearic slingers...',
num INTEGER,
user VARCHAR(255) NOT NULL,
done DATE NOT NULL,
notes TINYTEXT,
action ENUM('painted'),
PRIMARY KEY (id)
) ENGINE=InnoDB CHARACTER SET=utf8;

CREATE TABLE auth_password
(
user VARCHAR(255) UNIQUE,
password VARCHAR(255) NOT NULL,
PRIMARY KEY (user)
) ENGINE=InnoDB CHARACTER SET=utf8;

CREATE INDEX manufacturer_idx ON figure(manufacturer);
ALTER TABLE figure ADD FOREIGN KEY manufacturer_idxfk (manufacturer) REFERENCES manufacturer (id);

CREATE INDEX id_idx ON user(id);
CREATE INDEX user_idx ON auth_twitter(user);
ALTER TABLE auth_twitter ADD FOREIGN KEY user_idxfk (user) REFERENCES user (id);

CREATE INDEX twitter_user_id_idx ON auth_twitter(twitter_user_id);
ALTER TABLE purchase ADD FOREIGN KEY user_idxfk_1 (user) REFERENCES user (id);

CREATE INDEX manufacturer_idx ON purchase(manufacturer);
CREATE INDEX scale_idx ON purchase(scale);
ALTER TABLE action ADD FOREIGN KEY purchase_idxfk (purchase) REFERENCES purchase (id);

CREATE INDEX use_as_idx ON action(use_as);
ALTER TABLE action ADD FOREIGN KEY user_idxfk_2 (user) REFERENCES user (id);

ALTER TABLE auth_password ADD FOREIGN KEY user_idxfk_3 (user) REFERENCES user (id);

CREATE INDEX password_idx ON auth_password(password);