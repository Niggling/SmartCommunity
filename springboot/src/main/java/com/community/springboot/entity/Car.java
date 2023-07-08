package com.community.springboot.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
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
@TableName(value = "cars")
public class Car implements Serializable {

    @TableField(value = "userId")
    private String userId;

    @TableId(type = IdType.UUID)
    @TableField(value = "carId")
    private String carId;

    @TableField(value = "carName")
    private String carName;

    @TableField(value = "purchaseDate")
    private Date purchaseDate;

    @TableField(value = "location")
    private String location;

    @TableLogic(value = "0", delval = "1")
    private Integer isDeleted;

    @TableField(value = "description")
    private String description;

    private List<House> houses;

}
