#!/bin/bash

set -e

# === 1. Убедитесь, что .env существует ===
if [ ! -f "./.env" ]; then
  echo "❌ .env file not found. Please check deployment."
  exit 1
fi

# === 2. Загрузите переменные из .env ===
export $(cat ./.env | grep -v '#' | awk '/=/ {print $1}')

# === 3. Проверьте JAR файл ===
if [ ! -f "target/loopstrips-1.0.0.jar" ]; then
  echo "❌ JAR file not found!"
  exit 1
fi

# === 4. Остановка старых контейнеров ===
echo "🛑 Stopping old containers..."
docker-compose --env-file .env down -v || true

# === 5. Пересборка образов (если нужно) ===
echo "🧱 Pruning old images..."
docker image prune -f --filter "until=24h" || true

# === 6. Собираем и запускаем новые контейнеры ===
echo "🚀 Starting new containers..."
docker-compose --env-file .env up -d --build

echo "✅ Deployment completed successfully!"
