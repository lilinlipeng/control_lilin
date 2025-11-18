<template>
    <div class="forget-container">
        <div class="forget-box">
            <div class="forget-left">
                <div class="health-illustration">
                    <div class="health-icon">
                        <svg viewBox="0 0 100 100" class="key-icon">
                            <path d="M30 50 L20 60 Q15 65 20 70 L40 70 Q45 65 40 60 L30 50 Z" fill="currentColor"/>
                            <circle cx="70" cy="50" r="15" fill="none" stroke="currentColor" stroke-width="3"/>
                            <circle cx="70" cy="50" r="5" fill="currentColor"/>
                        </svg>
                    </div>
                    <!-- <h3 class="health-title">密码找回</h3> -->
                    <p class="health-subtitle">安全重置您的密码</p>
                </div>
            </div>
            <div class="forget-right">
                <div class="forget-form-container">
                    <div class="logo-section">
                        <div class="logo">
                            <img src="@/assets/logo.png" alt="健康管理" class="logo-icon" />
                        </div>
                        <h2 class="forget-title">找回密码</h2>
                        <p class="forget-subtitle">请填写以下信息重置密码</p>
                    </div>
                    
                    <el-form ref="loginFormRef" :model="formData" label-position="top" :rules="rules" class="forget-form">
                        <el-form-item prop="UserName">
                            <el-input 
                                v-model="formData.UserName" 
                                placeholder="请输入账号" 
                                size="large"
                                prefix-icon="User"
                                class="custom-input"
                            />
                        </el-form-item>

                        <el-form-item prop="Email">
                            <el-input 
                                v-model="formData.Email" 
                                placeholder="请输入邮箱" 
                                size="large"
                                prefix-icon="Message"
                                class="custom-input"
                            />
                        </el-form-item>

                        <el-form-item prop="PhoneNumber">
                            <el-input 
                                v-model="formData.PhoneNumber" 
                                placeholder="请输入联系方式" 
                                size="large"
                                prefix-icon="Phone"
                                class="custom-input"
                            />
                        </el-form-item>

                        <el-form-item prop="Password">
                            <el-input 
                                type="password" 
                                v-model="formData.Password" 
                                show-password 
                                placeholder="请输入新密码" 
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
                                    <ValidCode ref="validCodeRef" />
                                </div>
                            </div>
                        </el-form-item>

                        <el-form-item>
                            <el-button 
                                type="primary" 
                                class="forget-button" 
                                @click="handleForgetPassword"
                                size="large"
                            >
                                确定
                            </el-button>
                        </el-form-item>
                    </el-form>

                    <div class="forget-options">
                        <router-link :to="{ path: '/Login' }" class="login-link">
                            返回登录
                        </router-link>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { Post } from '@/api/http';
import ValidCode from '@/components/Identifyingcode/ImageCode.vue';
import { ElMessage } from 'element-plus';
import { reactive, ref } from 'vue';
import { useRouter } from 'vue-router';

// 路由实例
const router = useRouter()

// 表单引用
const loginFormRef = ref(null)
const validCodeRef = ref(null)

// 表单数据
const formData = reactive({
    UserName: '',
    Password: '',
    Email: '',
    PhoneNumber: '',
    Code: ''
})

// 表单验证规则
const rules = {
    UserName: [
        { required: true, message: '请输入账号', trigger: 'blur' },
        { min: 3, max: 20, message: '账号长度应在3到20个字符之间', trigger: 'blur' }
    ],
    Password: [
        { required: true, message: '请输入密码', trigger: 'blur' },
        { min: 6, message: '密码长度不能少于6个字符', trigger: 'blur' },
        {
            validator: (rule, value, callback) => {
                const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$/
                if (!passwordRegex.test(value)) {
                    callback(new Error('密码必须包含大小写字母和数字'))
                } else {
                    callback()
                }
            },
            trigger: 'blur'
        }
    ],
    Email: [
        { required: true, message: '该项为必填项', trigger: 'blur' },
        {
            validator: (rule, value, callback) => {
                const reg = /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/
                if (!value || !reg.test(value)) {
                    callback(new Error('请输入正确邮箱'))
                } else {
                    callback()
                }
            },
            trigger: 'blur'
        }
    ],
    PhoneNumber: [
        { required: true, message: '该项为必填项', trigger: 'blur' },
        {
            validator: (rule, value, callback) => {
                const reg = /^1[123456789]\d{9}$/
                if (!value || !reg.test(value)) {
                    callback(new Error('请输入正确的手机号'))
                } else {
                    callback()
                }
            },
            trigger: 'blur'
        }
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
}

// 处理找回密码
const handleForgetPassword = async () => {
    if (!loginFormRef.value) return

    await loginFormRef.value.validate(async (valid) => {
        if (valid) {
            try {
                const res = await Post('/User/ForgetPassword', formData)
                if (res.Success) {
                    ElMessage.success('修改密码成功!')
                    router.push('/Login')
                } else {
                    validCodeRef.value.refreshCode()
                }
            } catch (error) {
                console.error(error)
                validCodeRef.value.refreshCode()
            }
        } else {
            ElMessage.error('验证不通过')
            validCodeRef.value.refreshCode()
        }
    })
}
</script>

<style scoped lang="scss">
/* 忘记密码页面容器 */
.forget-container {
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

/* 忘记密码框 */
.forget-box {
    display: flex;
    width: 1000px;
    height: 630px;
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
.forget-left {
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
    margin: 0 auto 24x;
    color: white;
    animation: keyFloat 2s ease-in-out infinite;
}

.key-icon {
    width: 100%;
    height: 100%;
}

@keyframes keyFloat {
    0%, 100% { transform: translateY(0px) rotate(0deg); }
    50% { transform: translateY(-5px) rotate(2deg); }
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
.forget-right {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 60px 50px;
    background: white;
}

.forget-form-container {
    width: 100%;
    max-width: 400px;
    margin: 0 auto;
}

/* Logo 区域 */
.logo-section {
    text-align: center;
    margin-bottom: 15px;
}

.logo {
    width: 60px;
    height: 60px;
    margin: 0 auto 5px;
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

.forget-title {
    font-size: 24px;
    color: #2E7D32;
    margin-bottom: 8px;
    font-weight: 600;
}

.forget-subtitle {
    font-size: 14px;
    color: #666;
    margin: 0;
}

/* 忘记密码表单 */
.forget-form {
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

/* 忘记密码按钮 */
.forget-button {
    width: 100%;
    height: 48px;
    font-size: 16px;
    font-weight: 600;
    background: linear-gradient(135deg, #4CAF50, #66BB6A);
    border: none;
    border-radius: 12px;
    margin-top: 0px;
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

/* 忘记密码选项区域 */
.forget-options {
    text-align: center;
    margin-top: 0px;
}

.login-link {
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
    .forget-box {
        width: 95vw;
        flex-direction: column;
        border-radius: 16px;
    }

    .forget-left {
        padding: 40px 20px;
        min-height: 200px;
    }
    
    .health-title {
        font-size: 24px;
    }
    
    .health-subtitle {
        font-size: 14px;
    }

    .forget-right {
        padding: 40px 30px;
    }
    
    .forget-form-container {
        max-width: 100%;
    }
    
    .forget-title {
        font-size: 20px;
    }
}

@media (max-width: 480px) {
    .forget-container {
        padding: 20px 0;
    }
    
    .forget-box {
        width: 100vw;
        height: 100vh;
        border-radius: 0;
        flex-direction: column;
    }
    
    .forget-left {
        min-height: 160px;
        padding: 30px 20px;
    }
    
    .forget-right {
        padding: 30px 20px;
        flex: 1;
    }
}
</style>

