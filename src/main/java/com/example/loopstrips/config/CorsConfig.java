package com.example.loopstrips.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CorsConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/qr/**") // разрешаем CORS только для /qr/...
                .allowedOrigins("https://loopstripes.ru", "https://loopstripes.tilda.ws")  // домены, которые могут делать запросы
                .allowedMethods("GET"); // какие HTTP методы разрешены
    }
}