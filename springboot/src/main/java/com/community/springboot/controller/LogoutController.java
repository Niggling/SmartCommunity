package com.community.springboot.controller;

import javax.validation.Valid;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.community.springboot.entity.dto.LoginDTO;
import com.community.springboot.entity.result.Result;
import com.community.springboot.service.LogoutService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@SuppressWarnings("all")
@CrossOrigin(origins = { "http://localhost:8081", "http://localhost:8082", "http://localhost:8080" })
@RequestMapping(value = "/logout")
@RequiredArgsConstructor
public class LogoutController {
    
    private final LogoutService logoutService;

    @RequestMapping(value = "/sure",method = RequestMethod.POST)
    private Result logoutCurrentAccount() {
        return Result.success(200, logoutService.logoutWithSaToken() + ":登出成功！", null);
    }

}
