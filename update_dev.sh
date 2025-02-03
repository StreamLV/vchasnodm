docker compose -f dev.docker-compose.yml stop
docker compose -f dev.docker-compose.yml build --no-cache vchasno_dm
docker compose -f dev.docker-compose.yml up -d
