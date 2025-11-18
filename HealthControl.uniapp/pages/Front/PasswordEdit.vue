<template>
    <view class="password-edit-container">
        <!-- 背景装饰 -->
        <view class="bg-decoration">
            <view class="circle circle-1"></view>
            <view class="circle circle-2"></view>
            <view class="circle circle-3"></view>
        </view>

        <!-- Logo区域 -->
        <view class="logo-area">
            <image class="logo animate-float" src="/assets/logo.png" mode="aspectFit"></image>
            <text class="welcome-text animate-fade-in">修改密码</text>
            <text class="slogan animate-fade-in-delay">保护您的账户安全</text>
        </view>

        <!-- 表单区域 -->
        <view class="form-view animate-slide-up">
            <view class="form-card">
                <form class="password-form">
                    <view class="input-group">
                        <text class="icon">🔐</text>
                        <input type="password" v-model="formData.OrginPassword" placeholder="请输入原始密码" class="custom-input" />
                    </view>

                    <view class="input-group">
                        <text class="icon">🔑</text>
                        <input type="password" v-model="formData.NewPassword" placeholder="请输入新密码" class="custom-input" />
                    </view>

                    <view class="input-group">
                        <text class="icon">✅</text>
                        <input type="password" v-model="formData.TwoPassword" placeholder="请再次输入新密码" class="custom-input" />
                    </view>

                    <button class="submit-btn" @click="createOrEdit">
                        <text class="btn-text">确认修改</text>
                        <view class="btn-wave"></view>
                    </button>

                    <view class="quick-actions">
                        <text class="back-link" @click="goBack">返回上一页</text>
                    </view>
                </form>
            </view>
        </view>
    </view>
</template>

<script setup>
import { useCommonStore } from '@/store';
import { computed, reactive, ref } from 'vue';
import { Post } from "@/utils/http";
const commonStore = useCommonStore();
const editModalForm = ref(null);

// 表单数据
const formData = reactive({
    OrginPassword: '',
    NewPassword: '',
    TwoPassword: ''
});

// 表单验证规则
const rules = {
    OrginPassword: {
        rules: [{
            required: true,
            errorMessage: '请输入原始密码'
        }]
    },
    NewPassword: {
        rules: [{
            required: true,
            errorMessage: '请输入新密码'
        }]
    },
    TwoPassword: {
        rules: [{
            required: true,
            errorMessage: '请再次输入新密码'
        }]
    }
};

const Token = computed(() => commonStore.Token)
const UserInfo = computed(() => commonStore.UserInfo)
const RoleType = computed(() => commonStore.RoleType)
const UserId = computed(() => commonStore.UserId)

// 方法
const goBack = () => {
    uni.navigateBack();
};

const createOrEdit = async () => {
    editModalForm.value.validate().then(async (res) => {
        const updatedUserInfo = {
            Id: UserId.value,
            OrginPassword: formData.OrginPassword,
            Password: formData.TwoPassword
        };

        const { Success } = await Post("/User/ChangePassword", updatedUserInfo);
        if (Success) {
            await commonStore.Logout();

        }

    });


};
</script>

<style scoped lang="scss">
/* 密码编辑页面容器 */
.password-edit-container {
    min-height: 100vh;
    background: linear-gradient(135deg, #e8f5e8 0%, #f0f8f0 50%, #ffffff 100%);
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
    background: linear-gradient(45deg, #4CAF50, #66BB6A);
    top: -200rpx;
    right: -200rpx;
    animation: float 8s ease-in-out infinite;
}

.circle-2 {
    width: 400rpx;
    height: 400rpx;
    background: linear-gradient(45deg, #66BB6A, #81C784);
    bottom: -150rpx;
    left: -150rpx;
    animation: float 12s ease-in-out infinite;
}

.circle-3 {
    width: 300rpx;
    height: 300rpx;
    background: linear-gradient(45deg, #81C784, #A5D6A7);
    top: 40%;
    left: 60%;
    animation: float 10s ease-in-out infinite;
}

/* Logo 区域 */
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

/* 表单视图 */
.form-view {
    width: 100%;
    position: relative;
    margin-top: -120rpx;
    background-color: #ffffff;
    border-radius: 8% 8% 0% 0;
}

/* 表单卡片 */
.form-card {
    background: rgba(255, 255, 255, 0.95);
    border-radius: 24rpx;
    padding: 60rpx 40rpx;
    margin: 40rpx 30rpx 0rpx;
    box-shadow: 0 20rpx 40rpx rgba(76, 175, 80, 0.1);
    backdrop-filter: blur(10rpx);
}

/* 输入框组样式 */
.input-group {
    margin-bottom: 50rpx;
    position: relative;
    display: flex;
    align-items: center;
    padding: 20rpx;
    background: rgba(76, 175, 80, 0.05);
    border-radius: 16rpx;
    border: 2rpx solid transparent;
    transition: all 0.3s ease;
}

.input-group:focus-within {
    border-color: #4CAF50;
    background: rgba(76, 175, 80, 0.08);
    box-shadow: 0 0 0 4rpx rgba(76, 175, 80, 0.1);
}

.icon {
    font-size: 36rpx;
    color: #999;
    margin-right: 20rpx;
}

.custom-input {
    flex: 1;
    height: 50rpx;
    font-size: 32rpx;
    background: transparent;
    color: #333;
}

/* 按钮样式 */
.submit-btn {
    position: relative;
    width: 100%;
    height: 90rpx;
    background: linear-gradient(135deg, #4CAF50, #66BB6A);
    border: none;
    border-radius: 45rpx;
    margin: 60rpx 0 30rpx;
    padding: 0;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 15rpx 30rpx rgba(76, 175, 80, 0.3);
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

/* 快捷操作区 */
.quick-actions {
    display: flex;
    justify-content: center;
    margin-top: 30rpx;
    padding: 0 20rpx;
}

.back-link {
    color: #4CAF50;
    font-size: 28rpx;
}

/* 动画关键帧 */
@keyframes float {
    0%, 100% {
        transform: translateY(0) rotate(0deg);
    }
    50% {
        transform: translateY(-20rpx) rotate(5deg);
    }
}

@keyframes wave {
    0% {
        left: -100%;
    }
    50%, 100% {
        left: 100%;
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

.submit-btn:active {
    transform: scale(0.98);
    box-shadow: 0 8rpx 15rpx rgba(76, 175, 80, 0.2);
}
</style>