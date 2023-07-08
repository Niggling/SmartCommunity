package com.community.springboot.entity.dto;

import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CarBindDTO implements Serializable {
    
    private String carId;

    private String houseId;

}
