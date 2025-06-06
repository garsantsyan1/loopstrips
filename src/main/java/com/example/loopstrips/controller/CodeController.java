package com.example.loopstrips.controller;

import com.example.loopstrips.dto.CodeResponse;
import com.example.loopstrips.service.CodeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequiredArgsConstructor
public class CodeController {

    private final CodeService codeService;

    @GetMapping(value = "/qr/{code}", produces = "application/json; charset=UTF-8")
    public ResponseEntity<CodeResponse> checkCode(@PathVariable String code) {
        if (code == null || code.isBlank()) {
            return ResponseEntity.badRequest().body(
                    new CodeResponse("error", "Параметр code обязателен", null, null, 0)
            );
        }
        return ResponseEntity.ok(codeService.checkCode(code));
    }

    @GetMapping("/")
    public ResponseEntity<String> home() {
        return ResponseEntity.ok()
                .contentType(MediaType.TEXT_PLAIN)
                .body("API is running");

    }

}