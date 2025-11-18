<template>
    <div class="login-container">
        <div class="login-card">
           
            <img class="login-logo" :src="logoUrl" alt="个人健康小程序管理端 LOGO" />
           
            <h2 class="login-title">个人健康小程序管理端</h2>

            <el-form v-if="editorShow" ref="loginForm" :model="formData" label-width="70px" label-position="top" :rules="rules" class="login-form">
                <el-form-item label="账号" prop="UserName">
                    <el-input v-model="formData.UserName" placeholder="请输入账号" />
                </el-form-item>

                <el-form-item label="密码" prop="Password">
                    <el-input v-model="formData.Password" type="password" show-password placeholder="请输入密码" />
                </el-form-item>

                <el-form-item label="验证码" prop="Code">
                    <div class="code-container">
                        <el-input v-model="formData.Code" placeholder="请输入验证码" />
                        <div class="code-image">
                            <ImageCode ref="validCodeRef" />
                        </div>
                    </div>
                </el-form-item>

                <el-form-item>
                    <el-button type="primary" class="login-button" @click="loginBtn">登 录</el-button>
                </el-form-item>
            </el-form>

            <div class="login-options">
                <div class="forget-link">
                    <router-link :to="{ path: '/ForgetPassword' }">
                        <span class="link-text">忘记密码</span>
                    </router-link>
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
import { reactive, ref } from 'vue'
import { useRouter } from 'vue-router'
import logoUrl from '@/assets/logo.png'

// 路由和状态管理
const router = useRouter()
const commonStore = useCommonStore()
// 表单引用
const loginForm = ref(null)
const validCodeRef = ref(null)
const editorShow = ref(true)

// 表单数据
const formData = reactive({
    UserName: '',
    Password: '',
    Code: ''
})

// 表单校验规则
const rules = reactive({
    UserName: [
        { required: true, message: '请输入账号', trigger: 'blur' },
        { min: 3, max: 20, message: '账号长度应在3到20个字符之间', trigger: 'blur' }
    ],
    Password: [
        { required: true, message: '请输入密码', trigger: 'blur' },
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
/* 页面容器 */
.login-container {
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    background-image: url('@/assets/健康.png');
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center;
    background-color: #f6f9f6; /* fallback */
}

/* 登录卡片 */
.login-card {
    background-image: url('@/assets/sport.png');
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center;
    width: 420px;
    background-color: hsl(120, 65%, 61%);
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
    padding: 32px 28px 24px 28px;
}


.login-logo {
    display: block;
    width: 72px;
    height: 72px;
    margin: 0 auto 12px auto;
}

.login-title {
    font-size: 20px;
    color: #443f4e;
    text-align: center;
    margin-bottom: 18px;
    font-weight: 600;
}

.login-form {
    margin-top: 8px;
}

.code-container {
    display: flex;
    align-items: center;
    gap: 10px;
}

.code-image {
    flex-shrink: 0;
}

.login-button {
    width: 100%;
}

.login-options {
    display: flex;
    justify-content: flex-end;
    margin-top: 6px;
    font-size: 14px;
    color: #dcdee2;
}

.link-text {
    color: #409EFF;
    margin-left: 5px;
    cursor: pointer;
    transition: color 0.3s;

    &:hover {
        color: #66b1ff;
    }
}
</style>
