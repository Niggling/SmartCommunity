package com.community.springboot.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.community.springboot.entity.Car;
import com.community.springboot.entity.dto.CarBindDTO;

@Mapper
public interface CarMapper extends BaseMapper<Car> {
    
    List<Car> getMyCarsAndHouses(String userId);

    Integer bindCarToHouse(CarBindDTO carBindDTO);

    Integer unbindCarAndHouse(CarBindDTO carBindDTO);

}
