package com.community.springboot.service;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.shiro.crypto.hash.Sha1Hash;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import com.community.springboot.entity.User;
import com.community.springboot.entity.dto.RegisterDTO;
import com.community.springboot.mapper.MapstructMapper;
import com.community.springboot.mapper.RegisterMapper;
import lombok.RequiredArgsConstructor;

@Service(value = "registerService")
@Transactional(isolation = Isolation.DEFAULT, rollbackFor = Exception.class)
@SuppressWarnings(value = "all")
@RequiredArgsConstructor
public class RegisterService {
    
    private final RegisterMapper registerMapper;

    public Integer registerUser(RegisterDTO registerDTO) {
        User user = MapstructMapper.mapStructMapper.userDTOToUser(registerDTO);
        String salt = RandomStringUtils.randomAlphanumeric(16);
        user.setSalt(salt);
        user.setPassword(new Sha1Hash(user.getPassword(), salt, 1024).toHex());
        return registerMapper.insert(user);
    }

}
