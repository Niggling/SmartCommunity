package com.community.springboot.config.satoken;

import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import cn.dev33.satoken.interceptor.SaInterceptor;
import cn.dev33.satoken.router.SaRouter;
import cn.dev33.satoken.stp.StpUtil;

@SuppressWarnings(value = "all")
@Configuration
public class SaTokenConfiguration implements WebMvcConfigurer {

    @Autowired
    private PathProperties pathProperties;

    // 注册拦截器
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        List<String> urlList = pathProperties.getUrlList();
        // List<String> urlList = new ArrayList<>();
        // urlList.add("/login/auth");
        // urlList.add("/register/sure");
        // urlList.add("/captcha/getImage");
        // urlList.add("/user/search");
        // urlList.add("/district/all");
        // 注册 Sa-Token 拦截器，校验规则为 StpUtil.checkLogin() 登录校验。
        registry.addInterceptor(new SaInterceptor(handle -> {
            StpUtil.checkLogin();
        })).addPathPatterns("/**").excludePathPatterns(urlList);
    }
}