CREATE ROLE llm_readonly WITH LOGIN PASSWORD '__LLM_READONLY_PASSWORD__';

GRANT CONNECT ON DATABASE player_stats TO llm_readonly;
GRANT USAGE ON SCHEMA public TO llm_readonly;

-- give select privileges
GRANT SELECT ON ALL TABLES IN SCHEMA public TO llm_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO llm_readonly;

-- remove all other privileges
REVOKE INSERT, UPDATE, DELETE, TRUNCATE ON ALL TABLES IN SCHEMA public FROM llm_readonly;
REVOKE CREATE ON SCHEMA public FROM llm_readonly;
