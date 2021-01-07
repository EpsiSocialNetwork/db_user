FROM postgres:13

COPY ddl_posthoop_user.sql .
COPY dml_posthoop_user.sql .

RUN cat ddl_posthoop_user.sql > /docker-entrypoint-initdb.d/init.sql
RUN cat dml_posthoop_user.sql >> /docker-entrypoint-initdb.d/init.sql

EXPOSE 5432