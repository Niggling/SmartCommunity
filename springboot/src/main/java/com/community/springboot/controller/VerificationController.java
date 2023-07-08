package com.community.springboot.controller;

import javax.validation.Valid;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.community.springboot.entity.dto.IdDTO;
import com.community.springboot.entity.result.Result;
import com.community.springboot.service.VerifyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@SuppressWarnings("all")
@CrossOrigin(origins = { "http://localhost:8081", "http://localhost:8082", "http://localhost:8080" })
@RequestMapping(value = "/verify")
@RequiredArgsConstructor
public class VerificationController {

    private final VerifyService verifyService;
    
    @RequestMapping(value = "/identity", method = RequestMethod.POST)
    private Result verifyId(@RequestBody @Valid IdDTO idDTO) throws Exception {
        verifyService.verifyId(idDTO);
        return Result.success(200, "身份校验通过，信息已保存！", null);
    }
    
}
