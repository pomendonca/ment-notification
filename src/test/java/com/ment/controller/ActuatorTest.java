package com.ment.controller;

import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.UnsupportedEncodingException;

import org.junit.jupiter.api.Test;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

public class ActuatorTest extends AbstractControllerTest {

    private static final String ACTUATOR_HEALTH_CHECK_URL = "/v1/actuator/health";
    /*
     * Get /actuator/health
     */

    @Test
    public void shouldReturnHealthCheck() throws Exception {
        whenCallActuatorHealthCheck();
        thenExpectOkStatus();
        thenExpectUpStatus();
    }

    // when
    private void whenCallActuatorHealthCheck() throws Exception {
        response = mockMvc.perform(MockMvcRequestBuilders.get(ACTUATOR_HEALTH_CHECK_URL))
                .andReturn()
                .getResponse();
    }

    // then
    private void thenExpectUpStatus() throws UnsupportedEncodingException {
        assertTrue(response.getContentAsString().contains("\"status\":\"UP\""));
    }

}
