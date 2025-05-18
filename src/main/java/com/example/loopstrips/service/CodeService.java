package com.example.loopstrips.service;


import com.example.loopstrips.dto.CodeResponse;
import com.example.loopstrips.model.Code;
import com.example.loopstrips.repository.CodeRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@Service
@RequiredArgsConstructor
public class CodeService {

    private final CodeRepository repo;

    @Transactional
    public CodeResponse checkCode(String codeStr) {
        String trimmedCode = codeStr.trim();

        return repo.findById(trimmedCode)
                .map(code -> updateAndCreateResponse(code, trimmedCode))
                .orElseGet(() -> createInvalidResponse(trimmedCode));
    }

    private CodeResponse updateAndCreateResponse(Code code, String codeStr) {
        // Увеличиваем счётчик сканирований
        int updatedScanCount = code.getScanCount() + 1;
        code.setScanCount(updatedScanCount);
        repo.save(code);

        // Определяем статус и сообщение в зависимости от количества проверок
        boolean isWarning = updatedScanCount > 10;
        String status = isWarning ? "warning" : "success";
        String message = isWarning
                ? "Обратите внимание на количество проверок, если Вы не проверяли товар, возможно вы столкнулись с подделкой! Обязательно сообщите об этом производителю!"
                : "Оригинальный товар";

        // Возвращаем DTO с результатом проверки
        return new CodeResponse(status, message, codeStr, code.getFlavor(), updatedScanCount);
    }

    private CodeResponse createInvalidResponse(String codeStr) {
        return new CodeResponse("invalid", "Неоригинальный товар", codeStr, null, 0);
    }

}
