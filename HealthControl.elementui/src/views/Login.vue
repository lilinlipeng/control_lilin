<template>
    <div class="login-container">
        <div class="login-box">
            <div class="login-left">
                <div class="health-illustration">
                    <div class="health-icon">
                        <svg viewBox="0 0 100 100" class="heart-icon">
                            <path d="M50 90 L20 60 Q10 50 20 40 Q30 30 50 50 Q70 30 80 40 Q90 50 80 60 Z" fill="currentColor"/>
                        </svg>
                    </div>
                    <h3 class="health-title">健康管理</h3>
                    <p class="health-subtitle">守护您的健康每一天</p>
                </div>
            </div>
            <div class="login-right">
                <div class="login-form-container">
                    <div class="logo-section">
                        <div class="logo">
                            <img src="@/assets/logo.png" alt="健康管理" class="logo-icon" />
                        </div>
                        <h2 class="login-title">健康管理后台</h2>
                        <p class="login-subtitle">请使用您的账号登录</p>
                    </div>
                    
                    <el-form ref="loginForm" :model="formData" label-position="top" :rules="rules" class="login-form">
                        <el-form-item prop="UserName">
                            <el-input 
                                v-model="formData.UserName" 
                                placeholder="请输入账号" 
                                size="large"
                                prefix-icon="User"
                                class="custom-input"
                            />
                        </el-form-item>

                        <el-form-item prop="Password">
                            <el-input 
                                v-model="formData.Password" 
                                type="password" 
                                show-password 
                                placeholder="请输入密码" 
                                size="large"
                                prefix-icon="Lock"
                                class="custom-input"
                            />
                        </el-form-item>

                        <el-form-item prop="Code">
                            <div class="code-container">
                                <el-input 
                                    v-model="formData.Code" 
                                    placeholder="请输入验证码" 
                                    size="large"
                                    prefix-icon="Key"
                                    class="custom-input code-input"
                                />
                                <div class="code-image">
                                    <ImageCode ref="validCodeRef" />
                                </div>
                            </div>
                        </el-form-item>

                        <el-form-item>
                            <el-button 
                                type="primary" 
                                class="login-button" 
                                @click="loginBtn"
                                size="large"
                            >
                                登 录
                            </el-button>
                        </el-form-item>
                    </el-form>

                    <div class="login-options">
                        <router-link :to="{ path: '/ForgetPassword' }" class="forget-link">
                            忘记密码？
                        </router-link>
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

// 路由和状态管理
const router = useRouter()
const commonStore = useCommonStore()
// 表单引用
const loginForm = ref(null)
const validCodeRef = ref(null)

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
            try {
                const { Success } = await commonStore.Login(formData)

                if (Success) {
                    ElMessage.success('登录成功')
                    router.push({
                        path: '/Admin'
                    })
                }
            } catch (error) {
                console.error('登录失败', error)
            }
        } else {
            ElMessage.error('登录验证不通过')
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
    background: linear-gradient(135deg, #E8F5E8 0%, #F0F8F0 50%, #E8F5E8 100%);
    position: relative;
    
    &::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: 
            radial-gradient(circle at 20% 20%, rgba(76, 175, 80, 0.1) 0%, transparent 50%),
            radial-gradient(circle at 80% 80%, rgba(139, 195, 74, 0.1) 0%, transparent 50%);
        pointer-events: none;
    }
}

/* 登录框 */
.login-box {
    display: flex;
    width: 1000px;
    max-width: 90vw;
    background-color: white;
    border-radius: 20px;
    box-shadow: 
        0 20px 60px rgba(76, 175, 80, 0.15),
        0 8px 25px rgba(0, 0, 0, 0.08);
    overflow: hidden;
    position: relative;
    z-index: 1;
}

/* 左侧健康主题区域 */
.login-left {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    background: linear-gradient(135deg, #4CAF50 0%, #66BB6A 100%);
    padding: 60px 40px;
    position: relative;
    
    &::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="health-pattern" x="0" y="0" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="10" cy="10" r="1" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23health-pattern)"/></svg>');
        opacity: 0.3;
    }
}

.health-illustration {
    text-align: center;
    color: white;
    position: relative;
    z-index: 2;
}

.health-icon {
    width: 80px;
    height: 80px;
    margin: 0 auto 24px;
    color: white;
    animation: heartbeat 2s ease-in-out infinite;
}

.heart-icon {
    width: 100%;
    height: 100%;
}

@keyframes heartbeat {
    0%, 100% { transform: scale(1); }
    50% { transform: scale(1.05); }
}

.health-title {
    font-size: 28px;
    font-weight: 600;
    margin-bottom: 12px;
    letter-spacing: 1px;
}

.health-subtitle {
    font-size: 16px;
    opacity: 0.9;
    line-height: 1.5;
}

/* 右侧表单区域 */
.login-right {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 60px 50px;
    background: white;
}

.login-form-container {
    width: 100%;
    max-width: 400px;
    margin: 0 auto;
}

/* Logo 区域 */
.logo-section {
    text-align: center;
    margin-bottom: 40px;
}

.logo {
    width: 60px;
    height: 60px;
    margin: 0 auto 20px;
    background: linear-gradient(135deg, #4CAF50, #66BB6A);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 8px 20px rgba(76, 175, 80, 0.3);
}

.logo-icon {
    width: 40px;
    height: 40px;
    object-fit: contain;
}

.login-title {
    font-size: 24px;
    color: #2E7D32;
    margin-bottom: 8px;
    font-weight: 600;
}

.login-subtitle {
    font-size: 14px;
    color: #666;
    margin: 0;
}

/* 登录表单 */
.login-form {
    .el-form-item {
        margin-bottom: 24px;
    }
}

/* 自定义输入框样式 */
:deep(.custom-input) {
    .el-input__wrapper {
        border-radius: 12px;
        border: 2px solid #E8F5E8;
        background-color: #FAFFFA;
        transition: all 0.3s ease;
        
        &:hover {
            border-color: #C8E6C9;
            background-color: #F1F8E9;
        }
        
        &.is-focus {
            border-color: #4CAF50;
            background-color: white;
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
        }
    }
    
    .el-input__inner {
        color: #2E7D32;
        font-weight: 500;
        
        &::placeholder {
            color: #81C784;
        }
    }
    
    .el-input__prefix {
        color: #4CAF50;
    }
}

/* 验证码容器 */
.code-container {
    display: flex;
    align-items: center;
    gap: 12px;
}

.code-input {
    flex: 1;
}

.code-image {
    flex-shrink: 0;
    border-radius: 8px;
    overflow: hidden;
    border: 2px solid #E8F5E8;
}

/* 登录按钮 */
.login-button {
    width: 100%;
    height: 48px;
    font-size: 16px;
    font-weight: 600;
    background: linear-gradient(135deg, #4CAF50, #66BB6A);
    border: none;
    border-radius: 12px;
    margin-top: 8px;
    transition: all 0.3s ease;
    
    &:hover {
        background: linear-gradient(135deg, #43A047, #5CB85C);
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(76, 175, 80, 0.4);
    }
    
    &:active {
        transform: translateY(0);
    }
}

/* 登录选项区域 */
.login-options {
    text-align: center;
    margin-top: 24px;
}

.forget-link {
    color: #4CAF50;
    text-decoration: none;
    font-size: 14px;
    font-weight: 500;
    transition: color 0.3s ease;
    
    &:hover {
        color: #2E7D32;
        text-decoration: underline;
    }
}

/* 响应式调整 */
@media (max-width: 768px) {
    .login-box {
        width: 95vw;
        flex-direction: column;
        border-radius: 16px;
    }

    .login-left {
        padding: 40px 20px;
        min-height: 200px;
    }
    
    .health-title {
        font-size: 24px;
    }
    
    .health-subtitle {
        font-size: 14px;
    }

    .login-right {
        padding: 40px 30px;
    }
    
    .login-form-container {
        max-width: 100%;
    }
    
    .login-title {
        font-size: 20px;
    }
}

@media (max-width: 480px) {
    .login-container {
        padding: 20px 0;
    }
    
    .login-box {
        width: 100vw;
        height: 100vh;
        border-radius: 0;
        flex-direction: column;
    }
    
    .login-left {
        min-height: 160px;
        padding: 30px 20px;
    }
    
    .login-right {
        padding: 30px 20px;
        flex: 1;
    }
}
</style>
