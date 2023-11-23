CREATE INDEX IF NOT EXISTS session_movie ON sessions (movie_id);
CREATE INDEX IF NOT EXISTS session_customer ON sessions (movie_id);
CREATE INDEX IF NOT EXISTS customers_id ON customers  (id);
CREATE INDEX IF NOT EXISTS session_id ON sessions  (id);
