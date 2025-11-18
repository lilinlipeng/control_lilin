package com.example.web.tools;

import ch.qos.logback.classic.Logger;
import ch.qos.logback.classic.util.LogbackMDCAdapter;
import com.example.web.tools.HttpUtils;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.SneakyThrows;
import java.util.HashMap;
import java.util.Map;

public class WeiXinUtils {

    public static final String WECHAT_SENDMSG_URL = "https://api.weixin.qq.com/cgi-bin/message/subscribe/send?";
    public static final String APP_ID = "你的Appid";
    public static final String APP_SECRET = "你的密钥";

    private static final ObjectMapper objectMapper = new ObjectMapper();

    /**
     * 找微信去获取认证token
     */
    @SneakyThrows
    public static String GetAccessToken() {
        String apiUrl = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + APP_ID
                + "&secret=" + APP_SECRET;
        String result = HttpUtils.Get(apiUrl, null);
        JsonNode jsonNode = objectMapper.readTree(result);
        return jsonNode.get("access_token").asText();

    }

    /**
     * 根据code获取openid
     */
    @SneakyThrows
    public static String GetOpenIdByCode(String code) {
        Logger logger = null;
        try {
            String apiUrl = "https://api.weixin.qq.com/sns/jscode2session?appid=" + APP_ID + "&secret=" + APP_SECRET
                    + "&js_code=" + code + "&grant_type=authorization_code";
            String result = HttpUtils.Get(apiUrl, null);
            JsonNode jsonNode = objectMapper.readTree(result);
            // 安全地获取openid
            if (jsonNode.has("openid") && jsonNode.get("openid") != null) {

                return jsonNode.get("openid").asText();
               
            } else {
                // 处理openid不存在的情况
                logger.warn("微信响应中未包含openid，完整响应: {}", jsonNode.toString());
                return null;
            }

        }  catch (Exception e) {

            logger.error("获取OpenId失败", e);
            return null;
        }
    }

    /**
     * 发送订阅消息
     * 
     * @param accessToken
     * @param templateId
     * @param page
     * @param openId
     * @param data
     * @return
     */
    @SneakyThrows
    public static Boolean sendSubscribeMessage(String accessToken, String templateId, String page, String openId,
            Object data) {
        Map<String, Object> param = new HashMap<>();
        param.put("template_id", templateId);
        param.put("page", page); // 用户点击消息，跳转的页面，可携带参数
        param.put("touser", openId);
        param.put("data", data);
        param.put("miniprogram_state", "developer");
        param.put("lang", "zh_CN");

        String url = WECHAT_SENDMSG_URL + "access_token=" + accessToken;

        try {
            String result = HttpUtils.Post(url, param, null);
            JsonNode jsonNode = objectMapper.readTree(result);

            Integer errCode = jsonNode.get("errcode").asInt();
            if (errCode == 0) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }

}
