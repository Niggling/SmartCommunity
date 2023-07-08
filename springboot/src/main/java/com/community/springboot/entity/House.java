package com.community.springboot.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import org.springframework.data.annotation.Transient;
import com.alibaba.fastjson2.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@TableName(value = "houses")
public class House implements Serializable {

    @TableId(type = IdType.UUID)
    @TableField(value = "houseId")
    private String houseId;
    
    @TableField(value = "userId")
    private String userId;

    @TableField(value = "estate")
    private String estate;

    @TableField(value = "block")
    private String block;

    @TableField(value = "location")
    private String location;

    @TableField(value = "relationship")
    private Integer relationship;

    @JSONField(format = "yyyy/MM/dd")
    @TableField(value = "bindDate")
    private Date bindDate;

    @Transient
    private List<String> family;

    @Transient
    private List<Car> cars;

    @TableField(value = "is_binded")
    private boolean isBinded;

    @TableLogic(value = "0", delval = "1")
    private Integer isDeleted;
    
}
