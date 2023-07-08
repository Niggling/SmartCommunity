package com.community.springboot.service;

import java.util.HashMap;
import java.util.Map;
import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import com.alibaba.fastjson2.JSONObject;
import com.community.springboot.config.verify.VerifyProperties;
import com.community.springboot.entity.Identity;
import com.community.springboot.entity.dto.IdDTO;
import com.community.springboot.mapper.IdentityMapper;
import com.community.springboot.mapper.MapstructMapper;
import com.community.springboot.utils.HttpUtils;
import com.community.springboot.utils.IdentityUtils;
import lombok.RequiredArgsConstructor;

@Service(value = "verifyService")
@Transactional(rollbackFor = Exception.class, isolation = Isolation.DEFAULT)
@SuppressWarnings("all")
@RequiredArgsConstructor
public class VerifyService {

    private final IdentityMapper identityMapper;

    private final VerifyProperties verifyProperties;

    // 本质是发送请求给其他api服务器
    public Integer verifyId(IdDTO idDTO) throws Exception {
        Map<String, String> headers = new HashMap<String, String>();
        headers.put("Authorization", "APPCODE " + verifyProperties.getAppcode());
        headers.put("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
        Map<String, String> querys = new HashMap<String, String>();
        Map<String, String> bodys = new HashMap<String, String>();
        bodys.put("idcard", idDTO.getIdCard());
        bodys.put("name", idDTO.getRealName());
        HttpResponse response = HttpUtils.doPost(verifyProperties.getHost(), verifyProperties.getPath(),
                verifyProperties.getMethod(), headers, querys, bodys);
        JSONObject jsonObject = JSONObject.parseObject(EntityUtils.toString(response.getEntity()));
        Assert.isTrue(jsonObject.getString("desc") == "一致", "信息不匹配，请重新输入！");
        return addIdentity(idDTO, jsonObject);
    }

    private Integer addIdentity(IdDTO idDTO, JSONObject jsonObject) {
        Identity identity = MapstructMapper.mapStructMapper.IdDTOToIdentity(idDTO);
        identity.setUserId(IdentityUtils.getUserName());
        identity.setAddress(jsonObject.getString("address"));
        identity.setSex(jsonObject.getString("sex") == "男" ? 0 : 1);
        return identityMapper.insert(identity);
    }
}
