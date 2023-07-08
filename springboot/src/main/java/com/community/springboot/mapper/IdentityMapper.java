package com.community.springboot.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.community.springboot.entity.Identity;

@Mapper
public interface IdentityMapper extends BaseMapper<Identity> {
    
}
