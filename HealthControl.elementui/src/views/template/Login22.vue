<template>
    <div class="login-container">
        <div class="login-box">
            <div class="login-left">
               <!-- <img class="login-image" src="@/assets/健康 (1).png" alt="登录背景图"></img> -->
                <div class="health-banner">
                    <div class="banner-content">
                        <div class="health-icon">
                            <!-- <el-icon size="60" color="#4CAF50">
                                <i class="el-icon-my-picture"></i>
                            </el-icon> -->
                            
                            <img class="login-image" src="./@/assets/健康 (1).png" alt="登录背景图"></img>
                            <!-- <el-icon size="60" color="#4CAF50">
                                <User />
                            </el-icon> -->
                        </div>
                        <h1 class="banner-title">个人健康管理中心</h1>
                        <p class="banner-subtitle">科学管理，健康生活</p>
                        <div class="health-features">
                            <div class="feature-item">
                                <el-icon color="#4CAF50"><Monitor /></el-icon>
                                <span>健康数据监控</span>
                            </div>
                            <div class="feature-item">
                                <el-icon color="#4CAF50"><Document /></el-icon>
                                <span>健康档案管理</span>
                            </div>
                            <div class="feature-item">
                                <el-icon color="#4CAF50"><TrendCharts /></el-icon>
                                <span>趋势分析报告</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="login-right">
                <div class="login-form-container">
                    <div class="form-header">
                        <h2 class="login-title">管理员登录</h2>
                        <p class="login-subtitle">欢迎来到个人健康小程序管理端</p>
                    </div>
                    
                    <el-form ref="loginForm" :model="formData" label-width="70px" label-position="top" :rules="rules"
                        class="login-form">
                        <el-form-item label="账号" prop="UserName">
                            <el-input 
                                v-model="formData.UserName" 
                                placeholder="请输入管理员账号" 
                                prefix-icon="User"
                                clearable
                            />
                        </el-form-item>

                        <el-form-item label="密码" prop="Password">
                            <el-input 
                                v-model="formData.Password" 
                                type="password" 
                                show-password 
                                placeholder="请输入登录密码"
                                prefix-icon="Lock"
                                clearable
                            />
                        </el-form-item>

                        <el-form-item label="验证码" prop="Code">
                            <div class="code-container">
                                <el-input 
                                    v-model="formData.Code" 
                                    placeholder="请输入验证码" 
                                    prefix-icon="Key"
                                    clearable
                                />
                                <div class="code-image">
                                    <ImageCode ref="validCodeRef" />
                                </div>
                            </div>
                        </el-form-item>

                        <el-form-item>
                            <el-button type="primary" class="login-button" @click="loginBtn" :loading="loginLoading">
                                <el-icon><Right /></el-icon>
                                <span>登 录</span>
                            </el-button>
                        </el-form-item>
                    </el-form>

                    <div class="login-options">
                        <div class="forget-link">
                            <router-link :to="{ path: '/ForgetPassword' }">
                                <el-icon><QuestionFilled /></el-icon>
                                <span class="link-text">忘记密码？</span>
                            </router-link>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { Post } from '@/api/http'
import ImageCode from '@/components/Identifyingcode/ImageCode.vue'
import { useCommonStore } from '@/store'
import { ElMessage } from 'element-plus'
import { onMounted, reactive, ref } from 'vue'
import { useRouter } from 'vue-router'
import { User, Lock, Key, Right, QuestionFilled, Monitor, Document, TrendCharts } from '@element-plus/icons-vue'

// 路由和状态管理
const router = useRouter()
const commonStore = useCommonStore()
// 表单引用
const loginForm = ref(null)
const validCodeRef = ref(null)
const loginLoading = ref(false)

// 表单数据
const formData = reactive({
    UserName: '',
    Password: '',
    RoleType: '1',
    Code: ''
})

// 角色选项
const roleOptions = ref([])

// 表单校验规则
const rules = reactive({
    UserName: [
        { required: true, message: '请输入账号', trigger: 'blur' },
        { min: 3, max: 20, message: '账号长度应在3到20个字符之间', trigger: 'blur' }
    ],
    Password: [
        { required: true, message: '请输入密码', trigger: 'blur' },
    ],
    RoleType: [
        { required: true, message: '请选择角色', trigger: 'blur' },
    ],
    Code: [
        { required: true, message: '请输入验证码', trigger: 'blur' },
        {
            validator: (rule, value, callback) => {
                const identifyCode = validCodeRef.value.getCode()
                if (value !== identifyCode) {
                    callback(new Error('请输入正确的验证码'))
                } else {
                    callback()
                }
            },
            trigger: 'blur'
        }
    ]
})

// 组件挂载时获取角色类型
onMounted(() => {
    getRoleTypeApi()
})

// 获取角色类型
const getRoleTypeApi = async () => {
    try {
        const { Data: { Items } } = await Post('/Select/RoleType')
        roleOptions.value = Items
    } catch (error) {
        console.error('获取角色类型失败', error)
    }
}

// 登录按钮点击事件
const loginBtn = () => {
    loginForm.value.validate(async (valid) => {
        if (valid) {
            loginLoading.value = true
            try {
                const { Success } = await commonStore.Login(formData)

                if (Success) {
                    ElMessage.success('登录成功，欢迎使用健康管理系统')
                    router.push({
                        path: '/Admin'
                    })
                }
            } catch (error) {
                console.error('登录失败', error)
                ElMessage.error('登录失败，请检查账号密码')
            } finally {
                loginLoading.value = false
            }
        } else {
            ElMessage.error('请完善登录信息')
            return false
        }
    })
}


</script>

<style scoped lang="scss">
/* 登录页面容器 */
.login-container {
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, #e8f5e8 0%, #f0f8ff 50%, #fff5f5 100%);
    position: relative;
    
    &::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="%23e0e0e0" stroke-width="0.5"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
        opacity: 0.3;
        z-index: 0;
    }
}

/* 登录框 */
.login-box {
    display: flex;
    width: 1200px;
    height: 600px;
    background-color: white;
    border-radius: 16px;
    box-shadow: 0 12px 40px rgba(76, 175, 80, 0.15);
    overflow: hidden;
    position: relative;
    z-index: 1;
    border: 1px solid rgba(76, 175, 80, 0.1);
}

/* 左侧健康主题区域 */
.login-left {
    flex: 1.5;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, #4CAF50 0%, #81C784 100%);
    position: relative;
    overflow: hidden;
    
    &::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -50%;
        width: 200%;
        height: 200%;
        background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
        animation: float 6s ease-in-out infinite;
    }
}

@keyframes float {
    0%, 100% { transform: translateY(0px) rotate(0deg); }
    50% { transform: translateY(-20px) rotate(180deg); }
}

.health-banner {
    text-align: center;
    color: white;
    z-index: 2;
    position: relative;
}

.banner-content {
    padding: 40px;
}

.health-icon {
    margin-bottom: 20px;
    animation: pulse 2s infinite;    
}
.health-icon img {
  width: 50%; /* 使图片宽度与容器相同 */
  height: auto; /* 高度自动按比例缩放 */
}

@keyframes pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.05); }
    100% { transform: scale(1); }
}

.banner-title {
    font-size: 32px;
    font-weight: 700;
    margin-bottom: 10px;
    text-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.banner-subtitle {
    font-size: 16px;
    opacity: 0.9;
    margin-bottom: 40px;
    font-weight: 300;
}

.health-features {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.feature-item {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 12px 20px;
    background: rgba(255,255,255,0.1);
    border-radius: 8px;
    backdrop-filter: blur(10px);
    transition: all 0.3s ease;
    
    &:hover {
        background: rgba(255,255,255,0.2);
        transform: translateX(5px);
    }
    
    span {
        font-size: 14px;
        font-weight: 500;
    }
}

/* 右侧表单区域 */
.login-right {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 50px 40px;
    background: linear-gradient(180deg, #ffffff 0%, #fafafa 100%);
}

.login-form-container {
    width: 100%;
}

.form-header {
    text-align: center;
    margin-bottom: 40px;
}

/* 登录标题 */
.login-title {
    font-size: 28px;
    color: #2E7D32;
    margin-bottom: 8px;
    font-weight: 700;
    letter-spacing: 0.5px;
}

.login-subtitle {
    font-size: 14px;
    color: #666;
    font-weight: 400;
    opacity: 0.8;
}

/* 登录表单 */
.login-form {
    margin-top: 20px;
}

.login-form :deep(.el-form-item__label) {
    color: #2E7D32;
    font-weight: 600;
    font-size: 14px;
}

.login-form :deep(.el-input__wrapper) {
    border-radius: 8px;
    border: 1px solid #e0e0e0;
    transition: all 0.3s ease;
    box-shadow: none;
    
    &:hover {
        border-color: #4CAF50;
    }
    
    &.is-focus {
        border-color: #4CAF50;
        box-shadow: 0 0 0 2px rgba(76, 175, 80, 0.1);
    }
}

.login-form :deep(.el-input__inner) {
    color: #333;
    font-size: 14px;
}

/* 验证码容器 */
.code-container {
    display: flex;
    align-items: center;
    gap: 12px;
}

.code-image {
    flex-shrink: 0;
    border-radius: 6px;
    overflow: hidden;
    border: 1px solid #e0e0e0;
}

/* 登录按钮 */
.login-button {
    width: 100%;
    height: 45px;
    font-size: 16px;
    font-weight: 600;
    margin-top: 20px;
    border-radius: 8px;
    background: linear-gradient(135deg, #4CAF50 0%, #66BB6A 100%);
    border: none;
    transition: all 0.3s ease;
    
    &:hover {
        background: linear-gradient(135deg, #45a049 0%, #5cb85c 100%);
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(76, 175, 80, 0.3);
    }
    
    &:active {
        transform: translateY(0);
    }
    
    .el-icon {
        margin-right: 8px;
    }
}

/* 登录选项区域 */
.login-options {
    display: flex;
    justify-content: center;
    margin-top: 30px;
    font-size: 14px;
}

.forget-link {
    a {
        display: flex;
        align-items: center;
        gap: 6px;
        text-decoration: none;
        transition: all 0.3s ease;
        
        &:hover {
            transform: translateY(-1px);
        }
    }
}

/* 链接文本 */
.link-text {
    color: #4CAF50;
    cursor: pointer;
    font-weight: 500;
    transition: color 0.3s;

    &:hover {
        color: #2E7D32;
    }
}

/* 响应式调整 */
@media (max-width: 992px) {
    .login-container {
        padding: 20px;
    }
    
    .login-box {
        width: 100%;
        height: auto;
        flex-direction: column;
        max-width: 500px;
    }

    .login-left {
        display: none;
    }

    .login-right {
        padding: 40px 30px;
    }
    
    .login-title {
        font-size: 24px;
    }
    
    .health-features {
        gap: 15px;
    }
    
    .feature-item {
        padding: 10px 15px;
    }
}

@media (max-width: 576px) {
    .login-right {
        padding: 30px 20px;
    }
    
    .form-header {
        margin-bottom: 30px;
    }
    
    .login-title {
        font-size: 22px;
    }
    
    .login-button {
        height: 42px;
        font-size: 15px;
    }

    /* 假设自定义图标类名为 el-icon-my-picture 
    
    */
.el-icon-my-picture {
  background: url('@/assets/健康 (1).png') center center no-repeat;
  background-size: 10px; /* 控制图标大小 */
  width: 10px;  /* 设置宽度 */
  height: 10px; /* 设置高度 */
}
.el-icon-my-picture:before {
  content: "替"; /* 占位文本，必须要有 */
  font-size: 16px;
  visibility: hidden; /* 隐藏占位文本，只显示背景图片 */
}
}
</style>
