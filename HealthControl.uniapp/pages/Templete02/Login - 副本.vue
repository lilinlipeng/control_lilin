<template>
    <view class="login-container">
        <!-- 背景装饰 -->
        <view class="bg-decoration">
            <view class="circle circle-1"></view>
            <view class="circle circle-2"></view>
            <view class="circle circle-3"></view>
        </view>

        <!-- Logo区域 -->
        <view class="logo-area">
            <image class="logo animate-float" src="/assets/logo.png" mode="aspectFit"></image>
            <text class="welcome-text animate-fade-in">欢迎使用字母哥基础架构</text>
            <text class="slogan animate-fade-in-delay">Vue3</text>
        </view>

        <!-- 登录表单区域 -->
        <view class="login-view animate-slide-up">
            <view class="login-card">
                <form class="login-form">
                    <view class="input-group">
                        <text class="icon">👤</text>
                        <input type="text" v-model="formData.UserName" placeholder="请输入您的账号" class="custom-input" />
                        <view class="input-line"></view>
                    </view>

                    <view class="input-group">
                        <text class="icon">🔒</text>
                        <input type="password" v-model="formData.Password" placeholder="请输入您的密码" class="custom-input"
                            password="true" />
                        <view class="input-line"></view>
                    </view>
                    <view class="input-group">
                        <text class="icon">👤</text>
                        <uni-data-checkbox v-model="formData.RoleType" :localdata="RoleTypeList" />
                        <view class="input-line"></view>
                    </view>

                    <button class="login-btn" @click="Login">
                        <text class="btn-text">登 录</text>
                        <view class="btn-wave"></view>
                    </button>

                    <view class="quick-actions">
                        <text class="forget-pwd" @click="ForgetPassword">忘记密码？</text>
                        <text class="register-link" @click="Reg">立即注册</text>
                    </view>
                </form>

                <!-- 其他登录方式 -->
                <view class="other-login">
                    <view class="divider">
                        <text>其他登录方式</text>
                    </view>
                    <view class="login-methods animate-fade-in">
                        <view class="method-item" @click="otherLogin(0)">
                            <view class="method-icon-wrapper">
                                <image class="method-icon" src="/assets/wx.png"></image>
                            </view>
                            <text class="method-text">微信登录</text>
                        </view>
                    </view>
                </view>
            </view>
        </view>
    </view>
</template>

<script setup>
import { useCommonStore } from "@/store";
import { Post } from "@/utils/http";
import { onLoad } from "@dcloudio/uni-app";
import { ref } from 'vue';


// 响应式数据
const formData = ref({
    UserName: "",
    Password: "",
    RoleType: "2"
})
const RoleTypeList = ref([])
const commonStore = useCommonStore()


// 获取角色列表
const GetRoleTypeListApi = async () => {
    const { Data: { Items } } = await Post("/Select/RoleType")
    RoleTypeList.value = Items.filter(item => item.Code != 1).map(item => ({
        text: item.Name,
        value: item.Code
    }))
}

// 登录方法
const Login = async () => {
    if (!formData.value.UserName) {
        uni.showToast({
            title: "请输入账户",
            icon: "none"
        })
        return
    }
    if (!formData.value.Password) {
        uni.showToast({
            title: "请输入密码",
            icon: "none"
        })
        return
    }

    const { Data, Success } = await commonStore.Login(formData.value)

    if (Success) {
        await commonStore.GetInfo()
        uni.reLaunch({
            url: "/pages/Front/Index"
        })
    }
}

// 忘记密码
const ForgetPassword = () => {
    uni.redirectTo({
        url: "/pages/Front/ForgetPassword"
    })
}

// 注册方法
const Reg = () => {
    uni.redirectTo({
        url: "/pages/Front/Register"
    })
}

// 其他登录方式
const otherLogin = async (type) => {
    if (type == 0) {
        // #ifdef H5
        uni.showToast({
            title: "H5不支持微信登录",
            icon: "none"
        })
        return
        // #endif
        uni.showLoading({
            title: "正在登录中~"
        })
        let WxCode = null

        await GetLoginCode().then(code => {
            WxCode = code
        })

        const { Data, Success } = await commonStore.Login({
            WxCode: WxCode,
        })

        uni.hideLoading()
        if (Success) {
            await commonStore.GetInfo()
            uni.reLaunch({
                url: "/pages/Front/Index"
            })
        }
    } else {
        uni.$comm.ShowToast("该方式还未实现,尽情期待！")
    }
}


onLoad(() => {
    GetRoleTypeListApi()
})
</script>

<style>
page {
    background-color: white;
}

.txt {
    font-size: 32upx;
    font-weight: bold;
    color: #333333;
}

.img-a {
    width: 100%;
    height: 450upx;
    background-size: 100%;
}

.reg {
    font-size: 28upx;
    color: #fff;
    height: 90upx;
    line-height: 90upx;
    border-radius: 50upx;
    font-weight: bold;
    background: #f5f6fa;
    color: #000000;
    text-align: center;
    margin-top: 30upx;
}

.login-view {
    width: 100%;
    position: relative;
    margin-top: -120upx;
    background-color: #ffffff;
    border-radius: 8% 8% 0% 0;
}

.t-login {
    width: 600upx;
    margin: 0 auto;
    font-size: 28upx;
    padding-top: 80upx;
}

.t-login button {
    font-size: 28upx;
    background: var(--primary-color);
    color: #fff;
    height: 90upx;
    line-height: 90upx;
    border-radius: 50upx;
    font-weight: bold;
}

.t-login input {
    height: 90upx;
    line-height: 90upx;
    margin-bottom: 50upx;
    border-bottom: 1px solid #e9e9e9;
    font-size: 28upx;
}

.t-login .t-a {
    position: relative;
}

.t-b {
    text-align: left;
    font-size: 42upx;
    color: #ffffff;
    padding: 130upx 0 0 70upx;
    font-weight: bold;
    line-height: 70upx;
}

.t-login .t-c {
    position: absolute;
    right: 22upx;
    top: 22upx;
    background: #5677fc;
    color: #fff;
    font-size: 24upx;
    border-radius: 50upx;
    height: 50upx;
    line-height: 50upx;
    padding: 0 25upx;
}

.t-login .t-d {
    text-align: center;
    color: #999;
    margin: 80upx 0;
}

.t-login .t-e {
    text-align: center;
    width: 250upx;
    margin: 80upx auto 0;
}

.t-login .t-g {
    float: left;
    width: 50%;
}

.t-login .t-e image {
    width: 50upx;
    height: 50upx;
}

.t-login .t-f {
    text-align: center;
    margin: 150upx 0 0 0;
    color: #666;
}

.t-login .t-f text {
    margin-left: 20upx;
    color: #aaaaaa;
    font-size: 27upx;
}

.t-login .uni-input-placeholder {
    color: #aeaeae;
}

.cl {
    zoom: 1;
}

.cl:after {
    clear: both;
    display: block;
    visibility: hidden;
    height: 0;
    content: '\20';
}

.login-container {
    min-height: 100vh;
    background: linear-gradient(135deg, #f0f4ff 0%, #ffffff 100%);
    position: relative;
    overflow: hidden;
}

/* 背景装饰 */
.bg-decoration {
    position: absolute;
    width: 100%;
    height: 100%;
    pointer-events: none;
}

.circle {
    position: absolute;
    border-radius: 50%;
    opacity: 0.1;
}

.circle-1 {
    width: 600rpx;
    height: 600rpx;
    background: linear-gradient(45deg, #2CC4F5, #2b85e4);
    top: -200rpx;
    right: -200rpx;
    animation: float 8s ease-in-out infinite;
}

.circle-2 {
    width: 400rpx;
    height: 400rpx;
    background: linear-gradient(45deg, #2b85e4, #2CC4F5);
    bottom: -150rpx;
    left: -150rpx;
    animation: float 12s ease-in-out infinite;
}

.circle-3 {
    width: 300rpx;
    height: 300rpx;
    background: linear-gradient(45deg, #2CC4F5, #2b85e4);
    top: 40%;
    left: 60%;
    animation: float 10s ease-in-out infinite;
}

/* Logo 区域增强 */
.logo-area {
    padding: 100rpx 0;
    text-align: center;
}

.logo {
    width: 200rpx;
    height: 200rpx;
    margin-bottom: 30rpx;
    filter: drop-shadow(0 8rpx 16rpx rgba(0, 0, 0, 0.1));
}

.welcome-text {
    font-size: 40rpx;
    color: #333;
    font-weight: bold;
    margin-bottom: 16rpx;
    display: block;
}

.slogan {
    font-size: 28rpx;
    color: #666;
    opacity: 0.8;
    display: block;
}

/* 登录卡片增强 */
.login-card {


    padding: 60rpx 40rpx;
    margin: 40rpx 30rpx 0rpx;

}

/* 输入框组样式增强 */
.input-group {
    margin-bottom: 50rpx;
    position: relative;
    display: flex;
    align-items: center;
    padding: 0 20rpx;
}

.iconfont {
    font-size: 40rpx;
    color: #999;
    margin-right: 20rpx;
}

.custom-input {
    flex: 1;
    height: 90rpx;
    font-size: 32rpx;
    background: transparent;
}

.input-line {
    position: absolute;
    bottom: -10rpx;
    left: 0;
    right: 0;
    height: 2rpx;
    background: linear-gradient(90deg, transparent, #e0e0e0, transparent);
    transition: all 0.3s;
}

.custom-input:focus+.input-line {
    height: 3rpx;
    background: linear-gradient(90deg, transparent, #2CC4F5, transparent);
}

/* 按钮样式增强 */
.login-btn {
    position: relative;
    width: 100%;
    height: 90rpx;
    background: linear-gradient(135deg, #2CC4F5, #2b85e4);
    border: none;
    border-radius: 45rpx;
    margin: 60rpx 0 30rpx;
    padding: 0;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 15rpx 30rpx rgba(44, 196, 245, 0.3);
    transition: transform 0.3s ease;
}

.btn-text {
    color: #ffffff;
    font-size: 32rpx;
    font-weight: 600;
    letter-spacing: 4rpx;
    z-index: 1;
}

.btn-wave {
    position: absolute;
    top: 0;
    left: -100%;
    width: 200%;
    height: 100%;
    background: linear-gradient(90deg,
            transparent,
            rgba(255, 255, 255, 0.3),
            transparent);
    transform: skewX(-15deg);
    animation: wave 2s infinite;
}

@keyframes wave {
    0% {
        left: -100%;
    }

    50%,
    100% {
        left: 100%;
    }
}

.login-btn:active {
    transform: scale(0.98);
    box-shadow: 0 8rpx 15rpx rgba(44, 196, 245, 0.2);
}

/* 快捷操作区 */
.quick-actions {
    display: flex;
    justify-content: space-between;
    margin-top: 30rpx;
    padding: 0 20rpx;
}

.forget-pwd,
.register-link {
    font-size: 28rpx;
    color: #666;
    opacity: 0.8;
}

.register-link {
    color: #2CC4F5;
}

/* 其他登录方式增强 */
.method-icon-wrapper {
    width: 100rpx;
    height: 100rpx;
    background: rgba(255, 255, 255, 0.9);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 16rpx;
    box-shadow: 0 8rpx 16rpx rgba(0, 0, 0, 0.05);
    transition: all 0.3s;
}

.method-icon {
    width: 60rpx;
    height: 60rpx;
}

.method-icon-wrapper:active {
    transform: scale(0.95);
}

/* 动画效果增强 */
@keyframes float {

    0%,
    100% {
        transform: translateY(0) rotate(0deg);
    }

    50% {
        transform: translateY(-20rpx) rotate(5deg);
    }
}

@keyframes shine {
    0% {
        left: -150%;
    }

    50% {
        left: 150%;
    }

    100% {
        left: 150%;
    }
}

.animate-float {
    animation: float 3s ease-in-out infinite;
}

.animate-fade-in {
    animation: fadeIn 0.8s ease-out;
}

.animate-fade-in-delay {
    animation: fadeIn 0.8s ease-out 0.3s backwards;
}

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(20rpx);
    }

    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.login-form {
    margin: 30rpx 0;
}

.other-login {
    margin-top: 60rpx;
    text-align: center;
}

.divider {
    display: flex;
    align-items: center;
    justify-content: center;
    color: #999;
    font-size: 24rpx;
    margin-bottom: 40rpx;
}

.login-methods {
    display: flex;
    justify-content: center;
    margin-top: 30rpx;
}

.method-item {
    text-align: center;
    padding: 20rpx;
}

.method-text {
    font-size: 24rpx;
    color: #666;
    display: block;
}

.icon {
    font-size: 36rpx;
    color: #999;
    margin-right: 20rpx;
}
</style>