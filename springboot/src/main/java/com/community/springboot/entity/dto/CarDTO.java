package com.community.springboot.entity.dto;

import java.io.Serializable;
import java.util.Date;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.PastOrPresent;
import org.hibernate.validator.constraints.Length;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CarDTO implements Serializable {

    @NotBlank(message = "车牌不能为空！")
    private String carId;

    @NotBlank(message = "车名以及型号不能为空！")
    private String carName;

    @PastOrPresent(message = "日期不能为将来！")
    private Date purchaseDate;

    @NotBlank(message = "车名以及型号不能为空！")
    @Length(min = 10, max = 500, message = "地址必须为{min}到{max}个字之间！")
    private String location;
}
