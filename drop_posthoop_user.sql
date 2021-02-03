-- author : jpeguet
-- date : 7th january 2021
-- file : drop_posthoop_user.sql
-- base : posthoop
-- role : drop all

select pg_terminate_backend(pid) from pg_stat_activity where datname='posthoop';
DROP DATABASE IF EXISTS posthoop_user;
DROP USER IF EXISTS posthoop;