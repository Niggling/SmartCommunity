package com.community.springboot.config.verify;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import lombok.Data;

@ConfigurationProperties(prefix = "verify")
@Configuration
@Data
public class VerifyProperties {

    public String host;

    public String path;

    public String method;

    public String appcode;

}
