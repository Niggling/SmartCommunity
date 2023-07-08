package com.community.springboot.service;

import org.springframework.stereotype.Service;
import cn.dev33.satoken.stp.StpUtil;
import lombok.RequiredArgsConstructor;

@Service(value = "logoutService")
@SuppressWarnings(value = "all")
public class LogoutService {
    
    public String logoutWithSaToken() {
        String userId = StpUtil.getLoginId().toString();
        StpUtil.logout();
        return userId;
    }

}
