
CREATE KEYSPACE "users"
WITH REPLICATION = {
  'class': 'SimpleStrategy', 'replication_factor': 1
};

CREATE TABLE "personal_info" (id int PRIMARY KEY, name text, dob text);
INSERT INTO personal_info (id, name, dob) VALUES ( 1 , 'Alice' , '02-25-1954' );

CREATE KEYSPACE "my_status"
    WITH REPLICATION = {
          'class': 'SimpleStrategy', 'replication_factor': 1
    };
use my_status;

CREATE TABLE "users" (
  "username" text PRIMARY KEY,
  "email" text,
  "encrypted_password" blob
);

 INSERT INTO "users"
 ("username", "email", "encrypted_password")
 VALUES (
   'alice',
   'alice@gmail.com',
   0x8914977ed729792e403da53024c6069a9158b8c4
 );


INSERT INTO "users"
    ("username", "encrypted_password")
    VALUES (
      'bob',
      0x10920941a69549d33aaee6116ed1f47e19b8e713
    );

SELECT * FROM "users"
WHERE "username" = 'alice';

SELECT * FROM "users"
WHERE "username" = 'bogus';

SELECT * FROM "users"
WHERE "username" IN ('alice', 'bob');

INSERT INTO "users"
("username", "email", "encrypted_password")
VALUES (
  'carol',
  'carol@gmail.com',
  0xed3d8299b191b59b7008759a104c10af3db6e63a
);

INSERT INTO "users"
("username", "email", "encrypted_password")
VALUES (
  'dave',
  'dave@gmail.com',
  0x6d1d90d92bbab0012270536f286d243729690a5b
);

SELECT "username", token("username")
FROM "users";

SELECT * FROM "users"
WHERE token("username") > token('dave')
LIMIT 2;

DELETE FROM "users" WHERE "username"   = 'alice';


    UPDATE "users"
    SET "email" = 'alice@gmail.com',
    "encrypted_password" = 0x8914977ed729792e403da53024c6069a9158b8c4
    WHERE "username" = 'ranya';


#compound primary keys

    CREATE TABLE "user_status_updates" (
      "username" text,
      "id" timeuuid,
      "body" text,
      PRIMARY KEY ("username", "id")
    );


INSERT INTO "user_status_updates"
("username", "id", "body")
VALUES (
  'alice',
  76e7a4d0-e796-11e3-90ce-5f98e903bf02,
  'Learning Cassandra!'
);


SELECT "username", "id", "body", DATEOF("id")
FROM "user_status_updates";

SELECT "username", "id", "body", UNIXTIMESTAMPOF("id")
FROM "user_status_updates";


ELECT * FROM "user_status_updates"
WHERE "username" = 'alice'
AND "id" = 76e7a4d0-e796-11e3-90ce-5f98e903bf02;

INSERT INTO "user_status_updates" ("username", "id", "body")
VALUES ('alice', NOW(), 'Alice Update 1');
INSERT INTO "user_status_updates" ("username", "id", "body")
VALUES ('bob', NOW(), 'Bob Update 1');
INSERT INTO "user_status_updates" ("username", "id", "body")
VALUES ('alice', NOW(), 'Alice Update 2');
INSERT INTO "user_status_updates" ("username", "id", "body")
VALUES ('bob', NOW(), 'Bob Update 2');
INSERT INTO "user_status_updates" ("username", "id", "body")
VALUES ('alice', NOW(), 'Alice Update 3');
INSERT INTO "user_status_updates" ("username", "id", "body")
VALUES ('bob', NOW(), 'Bob Update 3');

SELECT "username", "id", "body", UNIXTIMESTAMPOF("id")
FROM "user_status_updates";


CREATE TABLE "user_status_updates_by_datetime" (
  "username" text,
  "status_date" date,
  "status_time" time,
  "body" text,
  PRIMARY KEY ("username", "status_date", "status_time")
);
INSERT INTO "user_status_updates_by_datetime" ("username",
              "status_date", "status_time", "body")
             VALUES ('alice', '2016-11-11', '14:50:45.123456', 'Alice Update 7');



INSERT INTO "users_with_status_updates"
("username", "id", "email", "encrypted_password", "body")
VALUES (
  'alice',
  76e7a4d0-e796-11e3-90ce-5f98e903bf03,
  'alice@gmail.com',
  0x8914977ed729792e403da53024c6069a9158b8c5,
  'Learning Cassandra!'
);


SELECT DISTINCT "username", "email", "encrypted_password"
FROM "users_with_status_updates"
WHERE "username" = 'alice';










