package com.community.springboot.entity.dto;

import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class HouseDTO implements Serializable {

    private String estate;

    private String block;

    private String location;

    private Integer relationship;
    
}
