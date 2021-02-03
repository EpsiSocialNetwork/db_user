-- author : jpeguet
-- date : 7th january 2021
-- file : ddl_posthoop_user.sql
-- base : posthoop_user
-- role : create database, schema and table

CREATE ROLE posthoop WITH 
  LOGIN
  NOSUPERUSER
  NOCREATEDB
  NOCREATEROLE
  INHERIT
  NOREPLICATION
  CONNECTION
  LIMIT -1
  PASSWORD 'Epsi2020!';

CREATE DATABASE posthoop_user
  WITH 
  OWNER = posthoop
  TEMPLATE = template0
  ENCODING = 'UTF8'
  CONNECTION LIMIT = -1;

\c posthoop_user


CREATE SCHEMA posthoop_user AUTHORIZATION posthoop;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

SET ROLE posthoop;
-- --- CREATE TABLES ---
CREATE TABLE posthoop_user."user" (
  "uid" uuid PRIMARY KEY DEFAULT (uuid_generate_v4()),
  "email" varchar UNIQUE NOT NULL,
  "password" varchar NOT NULL,
  "username" varchar NOT NULL,
  "fullname" varchar NOT NULL,
  "description" varchar,
  "picture_profile" uuid,
  "created_at" timestamp DEFAULT (now()),
  "code_country" char(2),
  "meta" varchar
);
ALTER TABLE posthoop_user."user" OWNER TO posthoop;

CREATE TABLE posthoop_user."follow" (
  "uid_user" uuid,
  "follow_uid_user" uuid NOT NULL,
  "created_at" timestamp DEFAULT (now()),
  PRIMARY KEY ("uid_user", "follow_uid_user")
);
ALTER TABLE posthoop_user."follow" OWNER TO posthoop;


ALTER TABLE posthoop_user."follow" ADD FOREIGN KEY ("uid_user") REFERENCES posthoop_user."user" ("uid");

ALTER TABLE posthoop_user."follow" ADD FOREIGN KEY ("follow_uid_user") REFERENCES posthoop_user."user" ("uid");

-- VIEW
CREATE ROLE posthoop_view WITH 
  LOGIN
  NOSUPERUSER
  NOCREATEDB
  NOCREATEROLE
  INHERIT
  NOREPLICATION
  CONNECTION
  LIMIT -1
  PASSWORD 'Epsi2020!';

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE "posthoop_user"."user", "posthoop_user"."follow" TO posthoop_view;

CREATE SCHEMA "v1_0" AUTHORIZATION posthoop_view;

CREATE VIEW "v1_0"."user" AS
  select uid, email, password, username, fullname, description, picture_profile, code_country
  from posthoop_user.user;

ALTER VIEW "v1_0"."user" OWNER TO posthoop_view;

CREATE VIEW "v1_0"."follow" AS
  select uid_user, follow_uid_user, created_at
  from posthoop_user.follow;

ALTER VIEW "v1_0"."user" OWNER TO posthoop_view;