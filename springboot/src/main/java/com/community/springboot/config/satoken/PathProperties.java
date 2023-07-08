package com.community.springboot.config.satoken;

import java.util.List;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import lombok.Data;

@ConfigurationProperties(prefix = "path")
@Configuration
@Data
public class PathProperties {
    
    List<String> urlList;

}