package com.example.loopstrips.controller;

import com.example.loopstrips.dto.CodeResponse;
import com.example.loopstrips.service.CodeService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequiredArgsConstructor
public class CodeController {

    private final CodeService codeService;

    @GetMapping("/check")
    public ResponseEntity<CodeResponse> checkCode(@RequestParam String code) {
        if (code.isBlank()) {
            return ResponseEntity.badRequest().body(
                    new CodeResponse("error", "Параметр code обязателен", null)
            );
        }

        return ResponseEntity.ok(codeService.checkCode(code));
    }
}