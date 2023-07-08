package com.community.springboot.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.gridfs.GridFSBucket;
import com.mongodb.client.gridfs.GridFSBuckets;
import org.springframework.data.mongodb.MongoDatabaseFactory;

// @SuppressWarnings("all")
@Configuration
public class GridFsConfig {

    /* 这样其实可以直接读取配置文件，也就不用传database name */
    @Bean("bucket")
    public GridFSBucket getBucket(MongoDatabaseFactory factory) {
        MongoDatabase database = factory.getMongoDatabase();
        GridFSBucket bucket = GridFSBuckets.create(database);
        return bucket;
    }

}
