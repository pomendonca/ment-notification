package com.ment.configuration;

import org.springframework.context.annotation.Configuration;

import com.ulisesbocchio.jasyptspringboot.annotation.EnableEncryptableProperties;
import com.ulisesbocchio.jasyptspringboot.annotation.EncryptablePropertySource;

import lombok.Getter;

@Getter
@Configuration
@EnableEncryptableProperties
@EncryptablePropertySource("application.yaml")
public class ApplicationConfig {

}