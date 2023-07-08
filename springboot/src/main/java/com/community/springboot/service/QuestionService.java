package com.community.springboot.service;

import java.util.Date;
import java.util.List;
import org.springframework.data.mongodb.gridfs.GridFsTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.community.springboot.entity.Question;
import com.community.springboot.entity.dto.QuestionDTO;
import com.community.springboot.mapper.MapstructMapper;
import com.community.springboot.mapper.QuestionMapper;
import com.community.springboot.utils.IdentityUtils;
import com.github.houbb.sensitive.word.core.SensitiveWordHelper;
import cn.dev33.satoken.stp.StpUtil;
import lombok.RequiredArgsConstructor;

@Service(value = "questionService")
@Transactional(isolation = Isolation.DEFAULT, rollbackFor = Exception.class)
@SuppressWarnings(value = "all")
@RequiredArgsConstructor
public class QuestionService {

    private GridFsTemplate gridFsTemplate;
    
    private final QuestionMapper questionMapper;

    // 先插入最多3张图片
    public Integer uploadQuestion(QuestionDTO questionDTO) {
        Assert.isTrue(!SensitiveWordHelper.contains(questionDTO.getContent()), "问题包含敏感词！");
        Question question = MapstructMapper.mapStructMapper.questionDTOToQuestion(questionDTO);
        question.setFinished(false);
        question.setIsDeleted(0);
        question.setReportDate(new Date());
        question.setUserId(IdentityUtils.getUserName());
        return questionMapper.insert(question);
    }

    public List<Question> getAllMyQuestions() {
        return questionMapper.selectList(new QueryWrapper<Question>().eq("userId", IdentityUtils.getUserName()));
    }

    private void uploadQuestionImage() {

    }

}
