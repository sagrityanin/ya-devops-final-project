
cat > /opt/bingo/config.yaml <<EOF
student_email: andrey@dynfor.ru
postgres_cluster:
  hosts:
  - address: bingo_db
    port: 5432
  user: $POSTGRES_USER
  password: $POSTGRES_PASSWORD
  db_name: $POSTGRES_DB
  ssl_mode: disable
  use_closest_node: false
EOF
echo "Create config.yaml"
cd /app
sleep 20
echo "Start prepare db"
./bingo prepare_db
export PGPASSWORD=$POSTGRES_PASSWORD
psql -h bingo_db -p 5432 -U $POSTGRES_USER \
-d $POSTGRES_DB < create_index.sql
