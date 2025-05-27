#!/bin/bash

# === 1. Генерация .env ===
if [ ! -f "./.env" ]; then
  echo "Creating .env file..."
  cat > ./.env <<EOL
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
MYSQL_DATABASE=${MYSQL_DATABASE}
MYSQL_HOST=loopstrips-db
MYSQL_PORT=3306

SPRING_DATASOURCE_URL=jdbc:mysql://loopstrips-db:3306/${MYSQL_DATABASE}?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
SPRING_DATASOURCE_USERNAME=root
SPRING_DATASOURCE_PASSWORD=${MYSQL_ROOT_PASSWORD}
EOL
else
  echo "File .env already exists."
fi

# === 2. Остановка контейнеров ===
docker-compose --env-file .env down -v || true

# === 3. Удаление старых образов (необязательно) ===
docker image prune -f --filter "until=24h" || true

# === 4. Проверка JAR-файла ===
if [ ! -f "target/loopstrips-1.0.0.jar" ]; then
  echo "JAR file not found! Deployment aborted."
  exit 1
fi

# === 5. Перезапуск с билдом ===
docker-compose --env-file .env up -d --build

echo "✅ Deployment completed!"
