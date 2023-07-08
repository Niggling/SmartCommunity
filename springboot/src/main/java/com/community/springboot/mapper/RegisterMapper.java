package com.community.springboot.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.community.springboot.entity.User;

@Mapper
public interface RegisterMapper extends BaseMapper<User> {
    
}
