package com.example.web.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * AI配置
 */
@Data
@Configuration
public class AiConfig {

    /**
     * sk-8639e***********************f52d
     * sk-3f287e5274bd4a45a3fb52d4e98399eb
     * DeepSeek API Key
     */
    // private String apiKey = "sk-0cd395c9189c4dc69f42b502cc4ca7db";
    private String apiKey = "sk-3f287e5274bd4a45a3fb52d4e98399eb";

    /**
     * API URL
     * https://api-docs.deepseek.com/zh-cn/
     */
    private String apiUrl = "https://api.deepseek.com/chat/completions";

    /**
     * 模型名称
     */
    private String model = "deepseek-chat";

    /**
     * 最大token数
     */
    private Integer maxTokens = 4000;

    /**
     * 温度参数
     */
    private Double temperature = 0.3;

    /**
     * 是否启用模拟模式（用于测试）
     * true: 从本地airesult.txt文件读取模拟数据
     * false: 调用真实的DeepSeek API
     */
    private Boolean mockMode = false;
}