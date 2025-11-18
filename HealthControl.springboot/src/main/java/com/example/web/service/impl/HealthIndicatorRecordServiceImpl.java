package com.example.web.service.impl;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.web.SysConst;
import com.example.web.dto.*;
import com.example.web.dto.query.*;
import com.example.web.entity.*;
import com.example.web.mapper.*;
import com.example.web.enums.*;
import com.example.web.service.*;
import com.example.web.tools.dto.*;
import com.example.web.tools.exception.CustomException;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.lang.reflect.InvocationTargetException;
import java.util.*;
import java.util.stream.Collectors;

import lombok.SneakyThrows;
import java.io.IOException;
import com.example.web.tools.*;
import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.springframework.web.bind.annotation.RequestParam;
/**
 * 健康指标记录功能实现类
 */
@Service
public class HealthIndicatorRecordServiceImpl extends ServiceImpl<HealthIndicatorRecordMapper, HealthIndicatorRecord> implements HealthIndicatorRecordService {

	 /**
     * 操作数据库AppUser表mapper对象
     */
    @Autowired
    private AppUserMapper AppUserMapper;
    /**
     * 操作数据库的HealthIndicatorRecord表mapper对象
     */
    @Autowired
    private HealthIndicatorRecordMapper HealthIndicatorRecordMapper;
    @Autowired
    private HealthIndicatorMapper  HealthIndicatorMapper;                        
    @Autowired
    private HealthIndicatorTypeMapper  HealthIndicatorTypeMapper;                        

  
   /**
     * 构建表查询sql
     */
    private LambdaQueryWrapper<HealthIndicatorRecord> BuilderQuery(HealthIndicatorRecordPagedInput input) {
       //声明一个支持健康指标记录查询的(拉姆达)表达式
        LambdaQueryWrapper<HealthIndicatorRecord> queryWrapper = Wrappers.<HealthIndicatorRecord>lambdaQuery()
                .eq(input.getId() != null && input.getId() != 0, HealthIndicatorRecord::getId, input.getId());
   //如果前端搜索传入查询条件则拼接查询条件
        if (Extension.isNotNullOrEmpty(input.getIsAbnormity())) {
             queryWrapper = queryWrapper.like(HealthIndicatorRecord::getIsAbnormity, input.getIsAbnormity());
       	 }

        if (input.getHealthIndicatorId() != null) {
            queryWrapper = queryWrapper.eq(HealthIndicatorRecord::getHealthIndicatorId, input.getHealthIndicatorId());
       	 }

        if (input.getHealthIndicatorTypeId() != null) {
            queryWrapper = queryWrapper.eq(HealthIndicatorRecord::getHealthIndicatorTypeId, input.getHealthIndicatorTypeId());
       	 }

        if (input.getRecordUserId() != null) {
            queryWrapper = queryWrapper.eq(HealthIndicatorRecord::getRecordUserId, input.getRecordUserId());
       	 }
        if (input.getRecordTimeRange() != null && !input.getRecordTimeRange().isEmpty()) {
            queryWrapper = queryWrapper.le(HealthIndicatorRecord::getRecordTime, input.getRecordTimeRange().get(1));
            queryWrapper = queryWrapper.ge(HealthIndicatorRecord::getRecordTime, input.getRecordTimeRange().get(0));
        }
      

 
 
     if(Extension.isNotNullOrEmpty(input.getKeyWord()))
        {
			queryWrapper=queryWrapper.and(i->i
          	   .like(HealthIndicatorRecord::getIsAbnormity,input.getKeyWord()).or()   	 
        );
                                       
 		   }
    
      return queryWrapper;
    }
  
    /**
     * 处理健康指标记录对于的外键数据
     */
   private List<HealthIndicatorRecordDto> DispatchItem(List<HealthIndicatorRecordDto> items) throws InvocationTargetException, IllegalAccessException {
          
       for (HealthIndicatorRecordDto item : items) {           
          	            
           //查询出关联的HealthIndicator表信息           
            HealthIndicator  HealthIndicatorEntity= HealthIndicatorMapper.selectById(item.getHealthIndicatorId());
            item.setHealthIndicatorDto(HealthIndicatorEntity!=null?HealthIndicatorEntity.MapToDto():new HealthIndicatorDto());              
           
          	            
           //查询出关联的AppUser表信息           
            AppUser  RecordUserEntity= AppUserMapper.selectById(item.getRecordUserId());
            item.setRecordUserDto(RecordUserEntity!=null?RecordUserEntity.MapToDto():new AppUserDto());              
           
          	            
           //查询出关联的HealthIndicatorType表信息           
            HealthIndicatorType  HealthIndicatorTypeEntity= HealthIndicatorTypeMapper.selectById(item.getHealthIndicatorTypeId());
            item.setHealthIndicatorTypeDto(HealthIndicatorTypeEntity!=null?HealthIndicatorTypeEntity.MapToDto():new HealthIndicatorTypeDto());              
       }
       
     return items; 
   }
  
    /**
     * 健康指标记录分页查询
     */
    @SneakyThrows
    @Override
    public PagedResult<HealthIndicatorRecordDto> List(HealthIndicatorRecordPagedInput input) {
			//构建where条件+排序
        LambdaQueryWrapper<HealthIndicatorRecord> queryWrapper = BuilderQuery(input);
        // 动态排序处理
        if (input.getSortItem() != null) {
            // 根据字段名动态排序
            queryWrapper.last("ORDER BY " + input.getSortItem().getFieldName()
                    + (input.getSortItem().getIsAsc() ? " ASC" : " DESC"));
        } else {
            // 默认按创建时间从大到小排序
            queryWrapper = queryWrapper.orderByDesc(HealthIndicatorRecord::getCreationTime);
        }

        //构建一个分页查询的model
        Page<HealthIndicatorRecord> page = new Page<>(input.getPage(), input.getLimit());
         //从数据库进行分页查询获取健康指标记录数据
        IPage<HealthIndicatorRecord> pageRecords= HealthIndicatorRecordMapper.selectPage(page, queryWrapper);
        //获取所有满足条件的数据行数
        Long totalCount= HealthIndicatorRecordMapper.selectCount(queryWrapper);
        //把HealthIndicatorRecord实体转换成HealthIndicatorRecord传输模型
        List<HealthIndicatorRecordDto> items= Extension.copyBeanList(pageRecords.getRecords(),HealthIndicatorRecordDto.class);

		   DispatchItem(items);
        //返回一个分页结构给前端
        return PagedResult.GetInstance(items,totalCount);

    }
  
    /**
     * 单个健康指标记录查询
     */
    @SneakyThrows
    @Override
    public HealthIndicatorRecordDto Get(HealthIndicatorRecordPagedInput input) {
       if(input.getId()==null)
        {
         return new HealthIndicatorRecordDto();
        }
      
       PagedResult<HealthIndicatorRecordDto> pagedResult = List(input);
        return pagedResult.getItems().stream().findFirst().orElse(new HealthIndicatorRecordDto()); 
    }

    /**
     *健康指标记录创建或者修改
     */
    @SneakyThrows
    @Override
    public HealthIndicatorRecordDto CreateOrEdit(HealthIndicatorRecordDto input) {
        //声明一个健康指标记录实体
        HealthIndicatorRecord HealthIndicatorRecord=input.MapToEntity();  
        //调用数据库的增加或者修改方法
        saveOrUpdate(HealthIndicatorRecord);
        //把传输模型返回给前端
        return HealthIndicatorRecord.MapToDto();
    }
    /**
     * 健康指标记录删除
     */
    @Override
    public void Delete(IdInput input) {
        HealthIndicatorRecord entity = HealthIndicatorRecordMapper.selectById(input.getId());
        HealthIndicatorRecordMapper.deleteById(entity);
    }

    /**
     * 健康指标记录批量删除
     */
    @Override
    public void BatchDelete(IdsInput input) {
        for (Integer id : input.getIds()) {
            IdInput idInput = new IdInput();
            idInput.setId(id);
            Delete(idInput);
        }
 
    }
    /**
     * 健康指标记录批量创建
     */
    @SneakyThrows
    @Override
    public void BatchAdd(List<HealthIndicatorRecordDto> input) {

        for (HealthIndicatorRecordDto item : input) {
            CreateOrEdit(item);
        }
    }

    /**
     * 今日指标记录
     */

    @Override
    @SneakyThrows
    public List<TodayHealthIndicatorRecordDto> TodayRecordList(HealthIndicatorRecordPagedInput input) {
        LocalDateTime beginTime = LocalDate.now().atTime(0, 0, 0);
        LocalDateTime endTime = LocalDate.now().atTime(23, 59, 59);
        // LocalDateTime latestTime = LocalDate.now().;

        // 查询当前的用户
        AppUser user = AppUserMapper.selectById(input.getRecordUserId());
        // 根据指标进行排序并且只回去最新的一条记录
        List<HealthIndicatorRecord> record = HealthIndicatorRecordMapper
                .selectList(// 执行查询，并返回一个实体类列表
                        Wrappers.<HealthIndicatorRecord>lambdaQuery() // 创建LambdaQueryWrapper，用于类型安全地构建查询条件
                        .eq(HealthIndicatorRecord::getRecordUserId, input.getRecordUserId()) // 条件1：记录人ID等于输入值
                        .ge(HealthIndicatorRecord::getRecordTime, beginTime)// 条件2：记录时间大于等于开始时间
                        .le(HealthIndicatorRecord::getRecordTime, endTime)// 条件3：记录时间小于等于结束时间

                                //不用分组,插入的指标可以覆盖之前的指标
                    //    .groupBy(HealthIndicatorRecord::getHealthIndicatorId)// (已注释)按健康指标ID分组
                         .orderByDesc(HealthIndicatorRecord::getRecordTime)); // (已注释)按记录时间降序排列

                        // 默认按创建时间从大到小排序
                      //  .orderByDesc(HealthIndicatorRecord::getCreationTime) .last("LIMIT 1"));//创建时间排序

                       

                        
        List<TodayHealthIndicatorRecordDto> todayHealthIndicatorRecordDtoList = new ArrayList<>();
        // 根据指标进行groupby
        for (HealthIndicatorRecord item : record) {
            TodayHealthIndicatorRecordDto todayHealthIndicatorRecordDto = new TodayHealthIndicatorRecordDto();
            todayHealthIndicatorRecordDto.setHealthIndicatorTypeId(item.getHealthIndicatorTypeId());
            todayHealthIndicatorRecordDto.setRecordUserId(item.getRecordUserId());//记录人
            todayHealthIndicatorRecordDto.setRecordUserId(item.getRecordUserId());//记录人
            todayHealthIndicatorRecordDto.setRecordTime(item.getRecordTime());//记录时间
            todayHealthIndicatorRecordDto.setRecordValue(item.getRecordValue());//记录值
            todayHealthIndicatorRecordDto.setIsAbnormity(item.getIsAbnormity());//是否异常
            todayHealthIndicatorRecordDto.setLastRecordValue(item.getRecordValue());//上一次记录值
            // 查询出关联的HealthIndicator表信息
            HealthIndicator HealthIndicatorEntity = HealthIndicatorMapper.selectById(item.getHealthIndicatorId());
            todayHealthIndicatorRecordDto.setHealthIndicatorDto(
                    HealthIndicatorEntity != null ? HealthIndicatorEntity.MapToDto() : new HealthIndicatorDto());

            // 查询出关联的HealthIndicatorType表信息
            HealthIndicatorType HealthIndicatorTypeEntity = HealthIndicatorTypeMapper
                    .selectById(item.getHealthIndicatorTypeId());
            todayHealthIndicatorRecordDto
                    .setHealthIndicatorTypeDto(HealthIndicatorTypeEntity != null ? HealthIndicatorTypeEntity.MapToDto()
                            : new HealthIndicatorTypeDto());
            // 得到当前指标上一个记录
            HealthIndicatorRecord lastRecord = HealthIndicatorRecordMapper
                    .selectOne(Wrappers.<HealthIndicatorRecord>lambdaQuery()
                            .ne(HealthIndicatorRecord::getId, item.getId())
                            .eq(HealthIndicatorRecord::getHealthIndicatorId, item.getHealthIndicatorId())
                            .eq(HealthIndicatorRecord::getRecordUserId, input.getRecordUserId())
                            // .orderByDesc(HealthIndicatorRecord::getRecordTime).last("LIMIT 1"));
                            .orderByDesc(HealthIndicatorRecord::getRecordTime).last("LIMIT 1"));
            todayHealthIndicatorRecordDto.setLastRecordValue(lastRecord != null ? lastRecord.getRecordValue() : 0);
            

            todayHealthIndicatorRecordDtoList.add(todayHealthIndicatorRecordDto);
          

        }

        return todayHealthIndicatorRecordDtoList;
    }


    /**
     * 根据传入的健康指标分类ID和时间范围，查询对应指标数据
     * @param healthIndicatorTypeId 健康指标类型ID
     * @param beginTime 起始时间
     * @param endTime 截止时间
     * @return List<HashMap<String, Object>> 返回满足条件的指标记录列表，每条为Map结构（大写驼峰命名的Key）
     */

     /**
    @SneakyThrows
    public List<HashMap<String, Object>> GetRecordsByTypeAndTime(Long healthIndicatorTypeId, LocalDateTime beginTime, LocalDateTime endTime) {
        if (healthIndicatorTypeId == null || beginTime == null || endTime == null) {
            throw new CustomException("参数不能为空");
        }

        // 查询健康指标记录
        List<HealthIndicatorRecord> records = HealthIndicatorRecordMapper.selectList(
                Wrappers.<HealthIndicatorRecord>lambdaQuery()
                        .eq(HealthIndicatorRecord::getHealthIndicatorTypeId, healthIndicatorTypeId)
                        .ge(HealthIndicatorRecord::getRecordTime, beginTime)
                        .le(HealthIndicatorRecord::getRecordTime, endTime)
                        .orderByDesc(HealthIndicatorRecord::getRecordTime)
        );

        List<HashMap<String, Object>> resultList = new ArrayList<>();
        for (HealthIndicatorRecord record : records) {
            HashMap<String, Object> map = new HashMap<>();
            map.put("Id", record.getId());
            map.put("HealthIndicatorId", record.getHealthIndicatorId());
            map.put("HealthIndicatorTypeId", record.getHealthIndicatorTypeId());
            map.put("RecordUserId", record.getRecordUserId());
            map.put("RecordValue", record.getRecordValue());
            map.put("IsAbnormity", record.getIsAbnormity());
            map.put("RecordTime", record.getRecordTime());
            // 可根据业务需要添加更多字段
            resultList.add(map);
        }
        return resultList;
    }
 */

 
  /**
     * 根据传入的分类id 和时间范围查询对应的指标数据
     */
    @Override
    @SneakyThrows
    public List<HealthIndicatorRecordGroupDto> RecordListStatistics(HealthIndicatorRecordPagedInput input) {
        input.setRecordUserId(BaseContext.getCurrentUserDto().getUserId());
        LambdaQueryWrapper<HealthIndicatorRecord> queryWrapper = BuilderQuery(input);
        queryWrapper.orderByDesc(HealthIndicatorRecord::getRecordTime);

        List<HealthIndicatorRecord> record = HealthIndicatorRecordMapper.selectList(queryWrapper);
        var items = Extension.copyBeanList(record, HealthIndicatorRecordDto.class);

        // 处理外键关联信息
        DispatchItem(items);

        // 先根据日期进行分组，然后取每个指标在该日期的最新记录
        Map<LocalDate, Map<Integer, HealthIndicatorRecordDto>> dateGroupMap = new HashMap<>();

        for (HealthIndicatorRecordDto item : items) {
            LocalDate recordDate = item.getRecordTime().toLocalDate();
            Integer indicatorId = item.getHealthIndicatorId();

            // 如果该日期的分组不存在，创建新的分组
            dateGroupMap.computeIfAbsent(recordDate, k -> new HashMap<>());

            //HealthIndicatorRecordGroupDto
            // 如果该日期该指标还没有记录，或者当前记录时间更晚，则更新记录
            Map<Integer, HealthIndicatorRecordDto> indicatorMap = dateGroupMap.get(recordDate);
            if (!indicatorMap.containsKey(indicatorId) ||
                    item.getRecordTime().isAfter(indicatorMap.get(indicatorId).getRecordTime())) {
                indicatorMap.put(indicatorId, item);
            }
        }

        // 构建返回结果
        List<HealthIndicatorRecordGroupDto> groupList = new ArrayList<>();
        for (Map.Entry<LocalDate, Map<Integer, HealthIndicatorRecordDto>> dateEntry : dateGroupMap.entrySet()) {
            HealthIndicatorRecordGroupDto groupDto = new HealthIndicatorRecordGroupDto();
            groupDto.setDate(dateEntry.getKey());

            // 将该日期下的所有指标记录转换为列表
            List<HealthIndicatorRecordGroupItemDto> dayItems = new ArrayList<>();
            for (Map.Entry<Integer, HealthIndicatorRecordDto> entry : dateEntry.getValue().entrySet()) {
                HealthIndicatorRecordDto item = entry.getValue();
                HealthIndicatorRecordGroupItemDto itemDto = new HealthIndicatorRecordGroupItemDto();
                itemDto.setHealthIndicatorName(item.getHealthIndicatorDto().getName());
                itemDto.setRecordValue(item.getRecordValue());
                dayItems.add(itemDto);
            }
            groupDto.setItems(dayItems);

            groupList.add(groupDto);
        }

        // 按日期降序排序
        groupList.sort((a, b) -> b.getDate().compareTo(a.getDate()));

        return groupList;
    }

}
