package com.community.springboot.entity.dto;

import java.io.Serializable;
import java.util.Date;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.PastOrPresent;
import org.hibernate.validator.constraints.Length;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class QuestionDTO implements Serializable {
    
    @NotBlank(message = "用户id不能为空！")
    @Length(min = 10, max = 500, message = "内容必须为{min}到{max}个字之间！")
    private String content;
    
}
