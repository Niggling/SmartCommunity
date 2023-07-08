package com.community.springboot.controller;

import javax.validation.Valid;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.community.springboot.entity.Car;
import com.community.springboot.entity.dto.CarBindDTO;
import com.community.springboot.entity.dto.CarDTO;
import com.community.springboot.entity.dto.LoginDTO;
import com.community.springboot.entity.result.Result;
import com.community.springboot.service.CarService;
import com.community.springboot.utils.IdentityUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@SuppressWarnings("all")
@CrossOrigin(origins = { "http://localhost:8081", "http://localhost:8082", "http://localhost:8080" })
@RequestMapping(value = "/car.user")
@RequiredArgsConstructor
public class CarController {

    private final CarService carService;

    @RequestMapping(value = "/all", method = RequestMethod.PUT)
    private Result getAllMyCars() {
        return Result.success(200, "车辆信息查询成功！", carService.getMyCars(IdentityUtils.getUserName()));
    }

    @RequestMapping(value = "/all/withHouses", method = RequestMethod.PUT)
    private Result getAllMyCarsWithHouses(@RequestParam(value = "userId") String userId) {
        return Result.success(200, "车辆信息查询成功！", carService.getMyCarsAndHouses(userId));
    }

    @RequestMapping(value = "/bind", method = RequestMethod.POST)
    private Result bindCarToHouse(@RequestBody @Valid CarBindDTO carBindDTO) {
        carService.bindCarToHouse(carBindDTO);
        return Result.success(200, "车辆绑定成功！", null);
    }

     @RequestMapping(value = "/unbind", method = RequestMethod.POST)
    private Result UnbindCarToHouse(@RequestBody @Valid CarBindDTO carBindDTO) {
        carService.unbindCarAndHouse(carBindDTO);
        return Result.success(200, "车辆解绑成功！", null);
    }

    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    private Result uploadCarInfo(@RequestBody @Valid CarDTO carDTO) {
        carService.addNewCar(carDTO);
        return Result.success("上传车辆信息成功！");
    }

}
