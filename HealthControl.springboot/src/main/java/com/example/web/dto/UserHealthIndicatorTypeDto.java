package com.example.web.dto;

import com.example.web.entity.HealthIndicatorType;
import com.example.web.tools.dto.BaseDto;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import org.apache.commons.beanutils.BeanUtils;

import java.lang.reflect.InvocationTargetException;
import java.util.List;

/**
 * 健康指标分类类
 */
@Data
public class UserHealthIndicatorTypeDto extends BaseDto {

    /**
     * 分类名称
     */
    @JsonProperty("Name")
    private String Name;

    /**
     * 所属人
     */
    @JsonProperty("BelongUserId")
    private Integer BelongUserId;

    /**
     * 是否公用
     */
    @JsonProperty("IsComm")
    private Boolean IsComm;

    @JsonProperty("BelongUserDto")
    private AppUserDto BelongUserDto;

    /* 对应的指标 */
    @JsonProperty("HealthIndicatorDtoList")
    private List<UserHealthIndicatorDto> HealthIndicatorDtoList;

    /**
     * 是否已选择
     *
     */
    @JsonProperty("IsSelected")
    private Boolean IsSelected;

    /**
     * 把健康指标分类传输模型转换成健康指标分类实体
     */
    public HealthIndicatorType MapToEntity() throws InvocationTargetException, IllegalAccessException {
        HealthIndicatorType HealthIndicatorType = new HealthIndicatorType();

        BeanUtils.copyProperties(HealthIndicatorType, this);

        return HealthIndicatorType;
    }

}

