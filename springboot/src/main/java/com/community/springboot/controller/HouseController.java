package com.community.springboot.controller;

import javax.validation.Valid;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.community.springboot.entity.dto.HouseDTO;
import com.community.springboot.entity.result.Result;
import com.community.springboot.service.HouseService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@SuppressWarnings("all")
@CrossOrigin(origins = { "http://localhost:8081", "http://localhost:8082", "http://localhost:8080" })
@RequestMapping(value = "/house.user")
@RequiredArgsConstructor
public class HouseController {

    private final HouseService houseService;

    @RequestMapping(value = "/all/withCars", method = RequestMethod.PUT)
    private Result getAllMyCarsWithHouses(@RequestParam(value = "userId") String userId) {
        return Result.success(200, "房屋信息查询成功！", houseService.getMyHousesWithCars(userId));
    }
 
    @RequestMapping(value = "/add", method = RequestMethod.PUT)
    private Result addNewHouse(@RequestBody @Valid HouseDTO houseDTO) {
        houseService.addHouse(houseDTO);
        return Result.success(200, "房屋信息添加成功！", null);
    }
    
}
