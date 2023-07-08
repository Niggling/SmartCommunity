package com.community.springboot.mapper;

import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;
import com.community.springboot.entity.Car;
import com.community.springboot.entity.House;
import com.community.springboot.entity.Identity;
import com.community.springboot.entity.Question;
import com.community.springboot.entity.User;
import com.community.springboot.entity.dto.CarDTO;
import com.community.springboot.entity.dto.HouseDTO;
import com.community.springboot.entity.dto.IdDTO;
import com.community.springboot.entity.dto.QuestionDTO;
import com.community.springboot.entity.dto.RegisterDTO;

@Mapper(unmappedSourcePolicy = ReportingPolicy.IGNORE, unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface MapstructMapper {
    
    MapstructMapper mapStructMapper = Mappers.getMapper(MapstructMapper.class);

    @Mapping(target = "content", source = "content")
    Question questionDTOToQuestion(QuestionDTO questionDTO);

    @Mapping(target = "carId", source = "carId")
    Car carDTOToCar(CarDTO carDTO);

    @Mapping(target = "userName", source = "userName")
    User userDTOToUser(RegisterDTO registerDTO);
    
    @Mapping(target = "realName", source = "realName")
    @Mapping(target = "idCard", source = "idCard")
    Identity IdDTOToIdentity(IdDTO idDTO);

    @Mapping(target = "estate", source = "estate")
    House HouseDTOToHouse(HouseDTO houseDTO);
}