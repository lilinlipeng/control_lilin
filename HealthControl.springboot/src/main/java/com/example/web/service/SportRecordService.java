package com.example.web.service;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.web.dto.*;
import com.example.web.dto.query.*;
import com.example.web.entity.*;
import com.example.web.tools.dto.*;
import com.example.web.enums.*;
import java.lang.reflect.InvocationTargetException;
import java.time.LocalDateTime;
import org.springframework.web.bind.annotation.RequestParam;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import jakarta.servlet.http.HttpServletResponse;

/**
 * 运动记录功能的Service接口的定义清单
 */
public interface SportRecordService extends IService<SportRecord> {

    /**
     * 运动记录的分页查询方法接口定义
     */
    public PagedResult<SportRecordDto> List(SportRecordPagedInput input) ;
    /**
     * 运动记录的新增或者修改方法接口定义
     */
    public SportRecordDto CreateOrEdit(SportRecordDto input);

     /**
     * 获取运动记录信息
     */
    public SportRecordDto Get(SportRecordPagedInput input);
 	 /**
     * 运动记录删除
     */
    public void Delete(IdInput input);

    /**
     * 运动记录批量删除
     */
    public void BatchDelete(IdsInput input);

    /**
     * 用户运动统计
     */
    public SportRecordSummaryDto SportRecordSummary(SportRecordPagedInput input);

    /**
     * 计算指定时间段内的卡路里消耗
     */
 //
   // private double calculateCaloriesForPeriod(Integer userId, LocalDateTime startTime, LocalDateTime endTime);
    /**
     * 计算指定时间段内的运动次数
     */
   // private int calculateSportCountForPeriod(Integer userId, LocalDateTime startTime, LocalDateTime endTime);
   // public int calculateSportCountForPeriod(Integer userId, LocalDateTime startTime, LocalDateTime endTime);
}
