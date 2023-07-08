package com.community.springboot.service;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.community.springboot.entity.Car;
import com.community.springboot.entity.dto.CarBindDTO;
import com.community.springboot.entity.dto.CarDTO;
import com.community.springboot.mapper.CarMapper;
import com.community.springboot.mapper.MapstructMapper;
import com.community.springboot.utils.IdentityUtils;
import com.github.houbb.sensitive.word.core.SensitiveWordHelper;
import lombok.RequiredArgsConstructor;

@Service(value = "carService")
@Transactional(rollbackFor = Exception.class, isolation = Isolation.DEFAULT)
@SuppressWarnings("all")
@RequiredArgsConstructor
public class CarService {

    private final CarMapper carMapper;

    public List<Car> getMyCars(String userId) {
        return carMapper.selectList(new QueryWrapper<Car>()
                .eq(userId != null, "userId", userId));
    }

    public Integer addNewCar(CarDTO carDTO) {
        Assert.isTrue(!SensitiveWordHelper.contains(carDTO.getCarName()), "车辆名字包含敏感词！");
        Car car = MapstructMapper.mapStructMapper.carDTOToCar(carDTO);
        car.setIsDeleted(0);
        car.setUserId(IdentityUtils.getUserName());
        return carMapper.insert(car);
    }

    public List<Car> getMyCarsAndHouses(String userId) {
        return carMapper.getMyCarsAndHouses(userId);
    }

    public Integer bindCarToHouse(CarBindDTO carBindDTO) {
        return carMapper.bindCarToHouse(carBindDTO);
    }

    public Integer unbindCarAndHouse(CarBindDTO carBindDTO) {
        return carMapper.unbindCarAndHouse(carBindDTO);
    }

}