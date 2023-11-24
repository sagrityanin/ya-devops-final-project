
cat > /opt/bingo/config.yaml <<EOF
student_email: andrey@dynfor.ru
postgres_cluster:
  hosts:
  - address: $POSTGRES_HOST
    port: $POSTGRES_PORT
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
psql -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER \
-d $POSTGRES_DB < create_index.sql
