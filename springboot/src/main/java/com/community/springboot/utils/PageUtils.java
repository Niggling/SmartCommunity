package com.community.springboot.utils;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;
import org.springframework.stereotype.Component;
import com.community.springboot.entity.Question;
import com.community.springboot.service.QuestionService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.RequiredArgsConstructor;

@Component
@SuppressWarnings("all")
@RequiredArgsConstructor
public class PageUtils {

    private final QuestionService questionService;
    
    public PageInfo<Question> getMyPagedQuestions(String methodName, int pageNum, int pageSize)
            throws NoSuchMethodException, SecurityException, IllegalAccessException,
            IllegalArgumentException, InvocationTargetException, InstantiationException {
        Method lisMethod = QuestionService.class.getMethod(methodName);
        PageHelper.startPage(pageNum, pageSize, true);
        List<Question> Questions = (List<Question>) lisMethod.invoke(questionService);
        PageInfo<Question> infoPage = new PageInfo<>(Questions);
        return infoPage;
    }

}
