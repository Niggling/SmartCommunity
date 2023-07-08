package com.community.springboot.entity;

import java.util.Date;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "questions")
public class Question {

    //如果要插入文件（如图片，视频等则根据此id来
    @TableId(type = IdType.UUID)
    @TableField(value = "questionId")
    private String questionId;

    @TableField(value = "userId")
    private String userId;
    
    @TableField(value = "content")
    private String content;

    @TableField(value = "reportDate")
    private Date reportDate;

    @TableField(value = "isFinished")
    private boolean isFinished;
    
    @TableLogic(value = "0", delval = "1")
    private Integer isDeleted;

}
