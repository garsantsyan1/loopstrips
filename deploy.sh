#!/bin/bash
set -e

# === 1. Загрузите переменные из .env ===
if [ ! -f "./.env" ]; then
  echo "❌ .env file not found"
  exit 1
fi

export $(cat .env | grep -v '#' | awk '/=/ {print $1}')

# === 2. Проверьте JAR файл ===
if [ ! -f "target/loopstrips-1.0.0.jar" ]; then
  echo "❌ JAR file not found!"
  exit 1
fi

# === 3. Остановите контейнеры без удаления volume ===
echo "🛑 Stopping old containers..."
docker-compose --env-file .env down || true

# === 4. Соберите новый образ (без лишних действий)
echo "🧱 Rebuilding app..."
docker-compose --env-file .env build || true

# === 5. Запустите контейнеры
echo "🚀 Starting new containers..."
docker-compose --env-file .env up -d
