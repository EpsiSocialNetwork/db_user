-- author : cbarange
-- date : 07th Junuary 2021
-- file : dml_posthoop_user.sql
-- base : posthoop_user
-- role : insert data

\c posthoop_user
SET ROLE posthoop;

INSERT INTO posthoop_user."user"(email, password, username, fullname, description, code_country)
  VALUES ('jules@mail.com', 'P4ssW0ord!', 'jules', 'jules_peguet', 'jules bio', 'FR');

INSERT INTO posthoop_user."user"(email, password, username, fullname, description, code_country)
  VALUES ('cbarange@mail.com', 'Str0ng_P4ssW0ord!', 'cbarange', 'cbarange', 'cbarange bio', 'FR');
