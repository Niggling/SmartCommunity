package com.community.springboot.service;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.community.springboot.entity.Car;
import com.community.springboot.entity.House;
import com.community.springboot.entity.dto.HouseDTO;
import com.community.springboot.mapper.HouseMapper;
import com.community.springboot.mapper.MapstructMapper;
import com.community.springboot.utils.IdentityUtils;
import com.github.houbb.sensitive.word.core.SensitiveWordHelper;
import lombok.RequiredArgsConstructor;

@Service(value = "houseService")
@Transactional(rollbackFor = Exception.class, isolation = Isolation.DEFAULT)
@SuppressWarnings("all")
@RequiredArgsConstructor
public class HouseService {

    private final HouseMapper houseMapper;

    public Integer addHouse(HouseDTO houseDTO) {
        House house = MapstructMapper.mapStructMapper.HouseDTOToHouse(houseDTO);
        Assert.isTrue(!SensitiveWordHelper.contains(houseDTO.toString()), "信息含有敏感词！");
        return houseMapper.insert(house.builder().userId(IdentityUtils.getUserName()).build());
    }

    public List<House> getMyCars(String userId) {
        return houseMapper.selectList(new QueryWrapper<House>()
                .eq(userId != null, "userId", userId));
    }

    public List<House> getMyHousesWithCars(String userId) {
        return houseMapper.getMyHousesWithCars(userId);
    }
    
}
