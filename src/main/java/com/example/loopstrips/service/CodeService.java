package com.example.loopstrips.service;


import com.example.loopstrips.dto.CodeResponse;
import com.example.loopstrips.model.Code;
import com.example.loopstrips.repository.CodeRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;


@Service
@RequiredArgsConstructor
public class CodeService {

    private final CodeRepository repo;

    @Transactional
    public CodeResponse checkCode(String codeStr) {
        codeStr = codeStr.trim();
        Optional<Code> optionalCode = repo.findById(codeStr);

        if (optionalCode.isEmpty()) {
            return new CodeResponse("invalid", "Неоригинальный товар", codeStr);
        }

        Code code = optionalCode.get();

        if (code.isUsed()) {
            return new CodeResponse("used", "Код уже использован", codeStr);
        }

        code.setUsed(true);
        repo.save(code);

        return new CodeResponse("success", "Оригинальный товар", codeStr);
    }
}
