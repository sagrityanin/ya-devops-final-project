CREATE INDEX IF NOT EXISTS session_movie ON sessions (movie_id);
CREATE INDEX IF NOT EXISTS session_customer ON sessions (movie_id);
CREATE INDEX IF NOT EXISTS customers_id ON customers  (id);
CREATE INDEX IF NOT EXISTS session_id ON sessions  (id);
CREATE INDEX IF NOT EXISTS session_cust_id_idx ON sessions (customer_id);
CREATE INDEX IF NOT EXISTS movies_id_idx ON movies (id);