package com.community.springboot.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import lombok.RequiredArgsConstructor;

@Service(value = "userService")
@Transactional(rollbackFor = Exception.class, isolation = Isolation.DEFAULT)
@SuppressWarnings("all")
@RequiredArgsConstructor
public class UserService {

    
}
