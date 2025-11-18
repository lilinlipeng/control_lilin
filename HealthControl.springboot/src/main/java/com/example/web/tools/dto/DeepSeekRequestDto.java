package com.example.web.tools.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import java.util.List;
import java.util.Map;

@Data 
public class DeepSeekRequestDto { 
    /**
     * 模型名称
     */
    @JsonProperty("model")
    private String model; 
    
    /**
     * 消息列表 
     */    
    @JsonProperty("messages")
    private List<Message> messages; 
    
    /**
     * 响应格式
     */
    @JsonProperty("response_format")
    private Map<String, String> response_format; 

    /**
     * 最大令牌数 
     */   
    @JsonProperty("max_tokens")
    private Integer max_tokens;
    
    /**
     * 温度参数 
     */
    @JsonProperty("temperature")
    private Double temperature; 

    @Data 
    public static class Message {
        /**
         * 角色(system/user/assistant) 
         */
        @JsonProperty("role")
        private String role;
        
        /**
         * 消息内容 
         */
        @JsonProperty("content")
        private String content;
    }
}
  /*
@Data
public class DeepSeekRequestDto {

    @JsonProperty("model")
    private String Model;

    @JsonProperty("messages")
    private List<Message> Messages;

    @JsonProperty("max_tokens")
    private Integer Max_tokens;

    @JsonProperty("temperature")
    private Double Temperature;

    @JsonProperty("response_format")
    private Map<String, String> Response_format;

    @Data
    public static class Message {
        @JsonProperty("role")
        private String Role;

        @JsonProperty("content")
        private String Content;
    }
}
 */   
