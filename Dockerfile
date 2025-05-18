# Dockerfile

# Используем официальный образ Java 21
FROM eclipse-temurin:21-jdk-alpine

# Устанавливаем рабочую директорию внутри контейнера
WORKDIR /app

# Копируем .jar файл в контейнер
COPY target/loopstrips-1.0.0.jar app.jar

# Открываем порт приложения
EXPOSE 8080

# Запускаем Spring Boot
ENTRYPOINT ["java", "-jar", "app.jar"]