package com.ment.configuration;

import java.util.Optional;

import org.hibernate.validator.HibernateValidatorConfiguration;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;

import jakarta.validation.Configuration;

public class CustomValidatorFactoryBean extends LocalValidatorFactoryBean {

    @Override
    protected void postProcessConfiguration(Configuration<?> configuration) {
        Optional.of(configuration)
                .filter(HibernateValidatorConfiguration.class::isInstance)
                .map(HibernateValidatorConfiguration.class::cast)
                .ifPresent(config -> config.propertyNodeNameProvider(new JacksonPropertyNodeNameProvider()));
        super.postProcessConfiguration(configuration);
    }

}
