package com.community.springboot.controller;

import javax.validation.Valid;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.community.springboot.entity.dto.LoginDTO;
import com.community.springboot.entity.dto.QuestionDTO;
import com.community.springboot.entity.result.Result;
import com.community.springboot.service.QuestionService;
import com.community.springboot.utils.IdentityUtils;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@SuppressWarnings("all")
@CrossOrigin(origins = { "http://localhost:8081", "http://localhost:8082", "http://localhost:8080" })
@RequestMapping(value = "/questions")
@RequiredArgsConstructor
public class QuestionController {

    private final QuestionService questionService;
    
    @RequestMapping(value = "/upload",method = RequestMethod.POST)
    private Result uploadSingleQuestion(@RequestBody @Valid QuestionDTO questionDTO) {
        questionService.uploadQuestion(questionDTO);
        return Result.success(200, "问题提交成功！", null);
    }

    @RequestMapping(value = "/all",method = RequestMethod.POST)
    private Result getAllQuestions() {
        return Result.success(200, "查询成功！", questionService.getAllMyQuestions());
    }

}
