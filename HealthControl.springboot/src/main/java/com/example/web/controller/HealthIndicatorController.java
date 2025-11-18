package com.example.web.controller;
import com.example.web.SysConst;
import com.example.web.dto.*;
import com.example.web.dto.query.*;
import com.example.web.entity.*;
import com.example.web.mapper.*;
import com.example.web.service.*;
import com.example.web.tools.dto.*;
import com.example.web.tools.exception.CustomException;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import lombok.SneakyThrows;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.util.*;
import java.util.stream.Collectors;
import jakarta.servlet.http.HttpServletResponse;
/**
 * 健康指标控制器 
 */
@RestController()
@RequestMapping("/HealthIndicator")
public class HealthIndicatorController {
    @Autowired()
    private  HealthIndicatorService HealthIndicatorService;
    @Autowired()
    private HealthIndicatorMapper HealthIndicatorMapper;


    /**
     * 健康指标分页查询
     */
    @RequestMapping(value = "/List", method = RequestMethod.POST)
    @SneakyThrows
    public PagedResult<HealthIndicatorDto> List(@RequestBody HealthIndicatorPagedInput input)  {
        return HealthIndicatorService.List(input);
    }
     /**
     * 单个健康指标查询接口
     */
    @RequestMapping(value = "/Get", method = RequestMethod.POST)
    @SneakyThrows
    public HealthIndicatorDto Get(@RequestBody HealthIndicatorPagedInput input) {

        return HealthIndicatorService.Get(input);
    }
  
    /**
     * 健康指标创建或则修改
     */
    @RequestMapping(value = "/CreateOrEdit", method = RequestMethod.POST)
    public HealthIndicatorDto CreateOrEdit(@RequestBody HealthIndicatorDto input) throws Exception {
        return HealthIndicatorService.CreateOrEdit(input);
    }


    /**
     * 用户添加公共指标
     */
    @RequestMapping(value = "/UserAddCommIndicator", method = RequestMethod.POST)
    @SneakyThrows
    public void UserAddCommIndicator(@RequestBody HealthIndicatorDto input) {
        HealthIndicatorService.UserAddCommIndicator(input);
    }

    /**
     * 用户取消
     */
    @RequestMapping(value = "/UserCancelCommIndicator", method = RequestMethod.POST)
    @SneakyThrows
    public void UserCancelCommIndicator(@RequestBody HealthIndicatorDto input){
        HealthIndicatorService.UserCancelCommIndicator(input);
    }

    /**
     * 移除指标
     * 缺少@RequestBody
     */
    @RequestMapping(value = "/UserRemoveIndicator", method = RequestMethod.POST)
    public void UserRemoveIndicator(@RequestBody HealthIndicatorDto input){
        HealthIndicatorService.UserRemoveIndicator(input);
        System.out.println("====================UserRemoveIndicator===input========================="+input);

    }

    /**
     * 用户创建或则编辑指标
     */
    @RequestMapping(value = "/UserCreateOrEditIndicator", method = RequestMethod.POST)
    public void UserCreateOrEditIndicator(@RequestBody HealthIndicatorDto input){
        HealthIndicatorService.UserCreateOrEditIndicator(input);
        System.out.println("===================UserCreateOrEditIndicator====input========================="+input);

    }
  
    /**
     * 健康指标删除
     */
    @RequestMapping(value = "/Delete", method = RequestMethod.POST)
    public void Delete(@RequestBody IdInput input)
    {
        HealthIndicatorService.Delete(input);
    }

    /**
     * 健康指标批量删除
     */
    @RequestMapping(value = "/BatchDelete", method = RequestMethod.POST)
    public void BatchDelete(@RequestBody IdsInput input)
    {
        HealthIndicatorService.BatchDelete(input);
    }
  

 
}
