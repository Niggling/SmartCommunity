package com.community.springboot.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.community.springboot.entity.Question;

@Mapper
public interface QuestionMapper extends BaseMapper<Question> {
    
}
