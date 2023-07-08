package com.community.springboot.service;

import org.apache.shiro.crypto.hash.Sha1Hash;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.community.springboot.entity.User;
import com.community.springboot.entity.dto.LoginDTO;
import com.community.springboot.mapper.LoginMapper;
import cn.dev33.satoken.exception.SaTokenException;
import cn.dev33.satoken.stp.StpUtil;
import lombok.RequiredArgsConstructor;

@Service(value = "loginService")
@Transactional(isolation = Isolation.DEFAULT, rollbackFor = Exception.class)
@SuppressWarnings(value = "all")
@RequiredArgsConstructor
public class LoginService {

    private final LoginMapper loginMapper;

    public void loginWithSaToken(LoginDTO loginDTO) {
        User user = loginMapper.selectOne(new QueryWrapper<User>()
            .eq("userId", loginDTO.getUserId()));
        if(new Sha1Hash(loginDTO.getPassword(), user.getSalt(), 1024).toHex().equals(user.getPassword())) {
            StpUtil.login(user.getUserId(), true);
        } else {
            throw new SaTokenException("登录失败！您的用户名或者密码有误");
        }
    }
}
