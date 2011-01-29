/* user table

We'll add other authtypes and extra columns as needed to handle external auth.
user.id will be used in user-specific URLs.
*/

CREATE TABLE user
(
    id INTEGER NOT NULL AUTO_INCREMENT,
    userid VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255),
    authtype ENUM('local') DEFAULT 'local',
    PRIMARY KEY (id)
);

