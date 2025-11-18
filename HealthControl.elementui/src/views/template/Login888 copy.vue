<template>
    <div class="login-container">
        <div class="login-box">
            <div class="login-left">
                <img class="login-image" src="@/assets/loginbg.png" alt="登录背景图">
            </div>
            <div class="login-right">
                <div class="login-form-container">
                    <h2 class="login-title">欢迎您来到个人健康小程序管理端</h2>
                    <el-form ref="loginForm" :model="formData" label-width="70px" label-position="top" :rules="rules"
                        class="login-form">
                        <el-form-item label="账号" prop="UserName">
                            <el-input v-model="formData.UserName" placeholder="请输入账号" />
                        </el-form-item>

                        <el-form-item label="密码" prop="Password">
                            <el-input v-model="formData.Password" type="password" show-password placeholder="请输入密码" />
                        </el-form-item>

                        <!-- <el-form-item label="角色" prop="RoleType">
                            <el-select v-model="formData.RoleType" placeholder="请选择角色" style="width: 100%">
                                <el-option v-for="item in roleOptions" :key="item.Code" :label="item.Label"
                                    :value="item.Code" />
                            </el-select>
                        </el-form-item> -->

                        <el-form-item label="验证码" prop="Code">
                            <div class="code-container">
                                <el-input v-model="formData.Code" placeholder="请输入验证码" />
                                <div class="code-image">
                                    <ImageCode ref="validCodeRef" />
                                </div>
                            </div>
                        </el-form-item>

                        <el-form-item>
                            <el-button type="primary" class="login-button" @click="loginBtn">
                                登 录
                            </el-button>
                        </el-form-item>
                    </el-form>

                    <div class="login-options">
                        <!-- <div class="register-link">
                            <span>如果没有账号可以</span>
                            <router-link :to="{ path: '/Register' }">
                                <span class="link-text">立即注册</span>
                            </router-link>
                        </div> -->
                        <div class="forget-link">
                            <router-link :to="{ path: '/ForgetPassword' }">
                                <span class="link-text">忘记密码</span>
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
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
}

/* 登录框 */
.login-box {
    display: flex;
    width: 1200px;

    background-color: white;
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
    overflow: hidden;
}

/* 左侧图片区域 */
.login-left {
    flex: 1.8;
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: #f5f7fa;
    overflow: hidden;
    position: relative;

}

.login-image {
    width: 100%;
    height: 100%;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
}

/* 右侧表单区域 */
.login-right {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 40px;
}

.login-form-container {
    width: 100%;
}

/* 登录标题 */
.login-title {
    font-size: 24px;
    color: #303133;
    margin-bottom: 30px;
    text-align: center;
    font-weight: 600;
}

/* 登录表单 */
.login-form {
    margin-top: 20px;
}

/* 验证码容器 */
.code-container {
    display: flex;
    align-items: center;
    gap: 10px;
}

.code-image {
    flex-shrink: 0;
}

/* 登录按钮 */
.login-button {
    width: 100%;
    height: 40px;
    font-size: 16px;
    margin-top: 10px;
}

/* 登录选项区域 */
.login-options {
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
    font-size: 14px;
    color: #606266;
}

/* 链接文本 */
.link-text {
    color: #409EFF;
    margin-left: 5px;
    cursor: pointer;
    transition: color 0.3s;

    &:hover {
        color: #66b1ff;
    }
}

/* 响应式调整 */
@media (max-width: 992px) {
    .login-box {
        width: 90%;
        height: auto;
        flex-direction: column;
    }

    .login-left {
        display: none;
    }

    .login-right {
        padding: 20px;
    }
}
</style>
