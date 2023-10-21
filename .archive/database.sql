-- create a new user
CREATE USER oytun_demirbilek WITH login password 'change_me_2413' 
nosuperuser inherit nocreatedb nocreaterole noreplication valid until 'infinity' 
IN GROUP read_only_all;

ALTER USER maintenance WITH password 'MsD72hpjhWFvYa';

-- create a new role
-- CREATE ROLE read_only_all;
GRANT mle TO oytun_demirbilek;

GRANT
SELECT
    ON ALL TABLES IN SCHEMA public TO read_only_all;

GRANT
INSERT
,
UPDATE
,
SELECT
,
    DELETE ON ALL TABLES IN SCHEMA public TO read_write_all;