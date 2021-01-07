-- author : cbarange
-- date : 07th Junuary 2021
-- file : ddl_posthoop_user.sql
-- base : posthoop
-- role : create database, schema and table for user

-- --- CREATE ROLE DATABASE SCHEMA ---
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

CREATE DATABASE posthoop
  WITH 
  OWNER = posthoop
  TEMPLATE = template0
  ENCODING = 'UTF8'
  CONNECTION LIMIT = -1;

\c posthoop


CREATE SCHEMA posthoop AUTHORIZATION posthoop;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

SET ROLE posthoop;
-- --- CREATE TABLES ---
CREATE TABLE posthoop."user" (
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
ALTER TABLE posthoop."user" OWNER TO posthoop;

CREATE TABLE posthoop."follow" (
  "uid_user" uuid,
  "follow_uid_user" uuid NOT NULL,
  "created_at" timestamp DEFAULT (now()),
  PRIMARY KEY ("uid_user", "follow_uid_user")
);
ALTER TABLE posthoop."follow" OWNER TO posthoop;

-- --- FOREIGN KEY ---
ALTER TABLE posthoop."follow" ADD FOREIGN KEY ("uid_user") REFERENCES posthoop."user" ("uid");

ALTER TABLE posthoop."follow" ADD FOREIGN KEY ("follow_uid_user") REFERENCES posthoop."user" ("uid");
