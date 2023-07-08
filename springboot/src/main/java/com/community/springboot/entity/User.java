package com.community.springboot.entity;

import java.io.Serializable;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@TableName(value = "user")
public class User implements Serializable {

    @TableField(value = "userName")
    private String userName;

    @TableId(type = IdType.UUID, value = "userId")
    private String userId;

    @TableField(value = "password")
    private String password;

    @TableField(value = "salt")
    private String salt;
    
}
