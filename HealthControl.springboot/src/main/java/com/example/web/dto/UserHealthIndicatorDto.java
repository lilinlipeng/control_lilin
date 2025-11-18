package com.example.web.dto;

import com.example.web.entity.HealthIndicator;
import com.example.web.tools.dto.BaseDto;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import org.apache.commons.beanutils.BeanUtils;

import java.lang.reflect.InvocationTargetException;

/**
 * 健康指标类
 */
@Data
public class UserHealthIndicatorDto extends BaseDto
{



    /**
     * 指标名称
     */
    @JsonProperty("Name")
    private String Name;


    /**
     * 所属人
     */
    @JsonProperty("BelongUserId")
    private Integer BelongUserId;


    /**
     * 描述内容
     */
    @JsonProperty("Content")
    private String Content;


    /**
     * 封面
     */
    @JsonProperty("Cover")
    private String Cover;


    /**
     * 是否公用
     */
    @JsonProperty("IsComm")
    private Boolean IsComm;


    /**
     * 阈值
     */
    @JsonProperty("Threshold")
    private String Threshold;


    /**
     * 指标归类
     */
    @JsonProperty("HealthIndicatorTypeId")
    private Integer HealthIndicatorTypeId;

    @JsonProperty("HealthIndicatorTypeDto")
    private HealthIndicatorTypeDto HealthIndicatorTypeDto;

    @JsonProperty("BelongUserDto")
    private AppUserDto BelongUserDto;

    /**
     * 是否已选择
     */
    @JsonProperty("IsSelected")
    private Boolean IsSelected;



    /**
     * 把健康指标传输模型转换成健康指标实体
     */
    public HealthIndicator MapToEntity() throws InvocationTargetException, IllegalAccessException {
        HealthIndicator HealthIndicator= new HealthIndicator();

        BeanUtils.copyProperties(HealthIndicator,this);

        return HealthIndicator;
    }

}
