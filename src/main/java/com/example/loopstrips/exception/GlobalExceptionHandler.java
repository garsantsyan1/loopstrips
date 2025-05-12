package com.example.loopstrips.exception;

import com.example.loopstrips.dto.CodeResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public ResponseEntity<CodeResponse> handleAny(Exception ex) {
        return ResponseEntity.internalServerError().body(
                new CodeResponse("error", "Ошибка сервера: " + ex.getMessage(), null)
        );
    }
}