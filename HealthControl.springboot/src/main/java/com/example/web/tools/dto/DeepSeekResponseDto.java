/*
 * DeepSeek API响应DTO
 */

package com.example.web.tools.dto;


import lombok.Data;
import java.util.List;

@Data
public class DeepSeekResponseDto {

    /*
     * 唯一标识符
     */
    private String id;

    /**
     * 对象类型
     */
    private String object;

    /**
     * c创建时间
     */
    private Long created;

   /**
    * 模型名称
    */
    private String model;

    /**
     * 选择列表
     */
    private List<Choice> choices;

    /**
     * 使用情况
     */
    private Usage usage;

    @Data
    public static class Choice {

       /**
        * 索引
        */
        private Integer index;

        /**
         * 信息
         */
        private Message message;

        /**
         * 结束类型
         */
        private String finish_reason;
    }

    @Data
    public static class Message {

       /**
        * 角色
        */
        private String role;
        /**
         * 内容
         */
        private String content;
    }

    @Data
    public static class Usage {

        /**
         * 提示令牌数
         */
        private Integer prompt_tokens;

        /*
         *  完成令牌数
         */
        private Integer completion_tokens;

        /**
         * 总令牌数
         */
        private Integer total_tokens;
    }
}