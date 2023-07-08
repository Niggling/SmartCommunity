package com.community.springboot.controller;

import javax.validation.Valid;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.community.springboot.entity.User;
import com.community.springboot.entity.dto.RegisterDTO;
import com.community.springboot.entity.result.Result;
import com.community.springboot.service.LoginService;
import com.community.springboot.service.RegisterService;
import cn.dev33.satoken.annotation.SaIgnore;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@SuppressWarnings("all")
@CrossOrigin(origins = { "http://localhost:8081", "http://localhost:8082", "http://localhost:8080" })
@RequiredArgsConstructor
@RequestMapping(value = "/register")
public class RegisterController {

    private final RegisterService registerService;

    @SaIgnore
    @RequestMapping(value = "/sure", method = RequestMethod.POST)
    private Result registerUser(@RequestBody @Valid RegisterDTO registerDTO) {
        registerService.registerUser(registerDTO);
        return Result.success("注册成功！");
    }

}
