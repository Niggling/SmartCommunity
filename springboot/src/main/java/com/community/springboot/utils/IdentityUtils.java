package com.community.springboot.utils;

import org.springframework.stereotype.Component;
import cn.dev33.satoken.stp.StpUtil;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@SuppressWarnings("all")
public class IdentityUtils {
    
    public static String getUserName() {
        return StpUtil.getLoginIdAsString();
    }

}
