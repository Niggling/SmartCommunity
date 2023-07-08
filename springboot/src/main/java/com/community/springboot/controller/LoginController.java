package com.community.springboot.controller;

import javax.validation.Valid;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.community.springboot.entity.dto.LoginDTO;
import com.community.springboot.entity.result.Result;
import com.community.springboot.service.LoginService;

import cn.dev33.satoken.annotation.SaIgnore;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@SuppressWarnings("all")
@CrossOrigin(origins = { "http://localhost:8081", "http://localhost:8082", "http://localhost:8080" })
@RequestMapping(value = "/login")
@RequiredArgsConstructor
public class LoginController {

    private final LoginService loginService;
    
    @SaIgnore
    @RequestMapping(value = "/auth",method = RequestMethod.POST)
    private Result loginResult(@RequestBody @Valid LoginDTO loginDTO) {
        loginService.loginWithSaToken(loginDTO);
        return Result.success("登录成功！");
    }
    
}
