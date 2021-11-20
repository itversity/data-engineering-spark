CREATE DATABASE lms_db;
CREATE USER lms_user WITH ENCRYPTED PASSWORD 'itversity';
GRANT ALL ON DATABASE lms_db TO lms_user;

\c lms_db

CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  user_first_name VARCHAR(30),
  user_last_name VARCHAR(30)
);

ALTER TABLE users OWNER TO lms_user;

INSERT INTO users (user_first_name, user_last_name)
VALUES ('Scott', 'Tiger'),
  ('Donald', 'Duck');
