package com.ment.configuration;

import java.lang.reflect.Constructor;
import java.lang.reflect.Executable;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

import org.apache.commons.lang3.StringUtils;
import org.springframework.core.ParameterNameDiscoverer;
import org.springframework.web.bind.annotation.RequestParam;

public class CustomParameterNameDiscoverer implements ParameterNameDiscoverer {

    @Override
    public String[] getParameterNames(Method method) {
        return parameterNames(method);
    }

    @Override
    public String[] getParameterNames(Constructor<?> constructor) {
        return parameterNames(constructor);
    }

    private String[] parameterNames(Executable executable) {
        List<String> parameterNames = new ArrayList<>();
        Stream.of(executable.getParameters()).forEach(param -> {
            RequestParam requestParamAnnotation = param.getAnnotation(RequestParam.class);
            if (requestParamAnnotation != null && !StringUtils.isBlank(requestParamAnnotation.name())) {
                parameterNames.add(requestParamAnnotation.name());
            } else {
                parameterNames.add(param.getName());
            }
        });
        return parameterNames.toArray(new String[0]);
    }

}
