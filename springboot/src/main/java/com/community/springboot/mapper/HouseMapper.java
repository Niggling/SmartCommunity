package com.community.springboot.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.community.springboot.entity.House;

@Mapper
public interface HouseMapper extends BaseMapper<House> {
    
    List<House> getMyHousesWithCars(String userId);

}
