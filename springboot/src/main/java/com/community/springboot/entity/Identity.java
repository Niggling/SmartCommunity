package com.community.springboot.entity;

import java.io.Serializable;
import java.util.Date;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "identity")
public class Identity implements Serializable {

    @TableId(type = IdType.INPUT)
    @TableField(value = "userId")
    private String userId;
    
    @TableField(value = "realName")
    private String realName;

    @TableField(value = "idCard")
    private String idCard;

    @TableField(value = "address")
    private String address;

    @TableField(value = "sex")
    private Integer sex;

    @TableField(value = "verifyDate")
    private Date verifyDate;

}
