<template>
    <div class="admin-layout">
        <!-- 顶部导航栏 -->
        
        <el-header class="header">
            <div class="header-left">
                <div class="logo">
                    <div class="logo-image">
                        <img src="@/assets/logo.png" alt="系统logo">
                    </div>
                    <div class="logo-content">
                        <h1 class="system-title">个人健康小程序管理端</h1>
                        <p class="system-subtitle">SpringBoot4 + Vue3</p>
                    </div>
                </div>
            </div>
            <div class="header-right">
                <el-dropdown>
                    <div class="user-info">
                        <el-avatar :size="32" :src="UserInfo.ImageUrls || defaultAvatar" />
                        <div class="user-details">
                            <span class="username">{{ UserInfo.UserName }}</span>
                            <span class="role">{{ RoleType }}</span>
                        </div>
                        <el-icon><arrow-down /></el-icon>
                    </div>
                    <template #dropdown>
                        <el-dropdown-menu>
                            <el-dropdown-item @click="handleUserInfo">
                                <el-icon>
                                    <User />
                                </el-icon>个人信息
                            </el-dropdown-item>
                            <el-dropdown-item @click="handlePasswordEdit">
                                <el-icon>
                                    <Lock />
                                </el-icon>修改密码
                            </el-dropdown-item>
                            <el-dropdown-item @click="handleLogout">
                                <el-icon>
                                    <SwitchButton />
                                </el-icon>退出登录
                            </el-dropdown-item>
                        </el-dropdown-menu>
                    </template>
                </el-dropdown>
            </div>
        </el-header>
 			  
        <!-- 主体内容区 -->
        <el-container class="main-container">
            <!-- 侧边栏 -->
            <el-aside width="200px">
                <el-menu default-active="1" :router="true" class="el-menu-vertical" :collapse="isCollapse"
                    background-color="#304156" text-color="#bfcbd9" active-text-color="#409EFF">
                    <el-sub-menu index="UserList">
                        <template #title>
                            <el-icon>
                                <setting />
                            </el-icon>
                            <span>系统管理</span>
                        </template>
                        <el-menu-item index="/Admin/UserList">账号管理</el-menu-item>
                  
                    </el-sub-menu>
							 
 								 <el-menu-item index="/Admin/CollectRecordList">
                               <el-icon>
                           			 <document />
                        			</el-icon>
                            收藏记录
                        </el-menu-item>
 								 <el-menu-item index="/Admin/DietRecordList">
                               <el-icon>
                           			 <document />
                        			</el-icon>
                            饮食记录
                        </el-menu-item>
 								 <el-menu-item index="/Admin/FoodList">
                               <el-icon>
                           			 <document />
                        			</el-icon>
                            食物
                        </el-menu-item>
 								 <el-menu-item index="/Admin/FoodTypeList">
                               <el-icon>
                           			 <document />
                        			</el-icon>
                            食物类型
                        </el-menu-item>
 								 <el-menu-item index="/Admin/FoodUnitList">
                               <el-icon>
                           			 <document />
                        			</el-icon>
                            食物单位
                        </el-menu-item>
 								 <el-menu-item index="/Admin/HealthArticleList">
                               <el-icon>
                           			 <document />
                        			</el-icon>
                            健康知识
                        </el-menu-item>
 								 <el-menu-item index="/Admin/HealthArticleTypeList">
                               <el-icon>
                           			 <document />
                        			</el-icon>
                            健康知识分类
                        </el-menu-item>
 								 <el-menu-item index="/Admin/HealthIndicatorList">
                               <el-icon>
                           			 <document />
                        			</el-icon>
                            健康指标
                        </el-menu-item>
 								 <el-menu-item index="/Admin/HealthIndicatorRecordList">
                               <el-icon>
                           			 <document />
                        			</el-icon>
                            健康指标记录
                        </el-menu-item>
 								 <el-menu-item index="/Admin/HealthIndicatorTypeList">
                               <el-icon>
                           			 <document />
                        			</el-icon>
                            健康指标分类
                        </el-menu-item>
 								 <el-menu-item index="/Admin/HealthNoticeList">
                               <el-icon>
                           			 <document />
                        			</el-icon>
                            健康提醒
                        </el-menu-item>
 								 <el-menu-item index="/Admin/LikeRecordList">
                               <el-icon>
                           			 <document />
                        			</el-icon>
                            点赞记录
                        </el-menu-item>
 								 <el-menu-item index="/Admin/RecipeList">
                               <el-icon>
                           			 <document />
                        			</el-icon>
                            食谱
                        </el-menu-item>
 								 <el-menu-item index="/Admin/SportList">
                               <el-icon>
                           			 <document />
                        			</el-icon>
                            运动参考
                        </el-menu-item>
 								 <el-menu-item index="/Admin/SportRecordList">
                               <el-icon>
                           			 <document />
                        			</el-icon>
                            运动记录
                        </el-menu-item>
 								 <el-menu-item index="/Admin/SportUnitList">
                               <el-icon>
                           			 <document />
                        			</el-icon>
                            运动单位
                        </el-menu-item>
                </el-menu>
            </el-aside>
				 
            <!-- 主要内容区 -->
            <el-main class="main-content">
                <!-- 面包屑导航 -->
                <el-breadcrumb separator-class="el-icon-arrow-right" class="breadcrumb">
                    <el-breadcrumb-item v-for="(item, index) in breadcrumbList" :key="index" :to="item.path">
                        {{ item.title }}
                    </el-breadcrumb-item>
                    <!-- 返回链接 -->
                    <span class="back-link" @click="goBack">
                        <el-icon>
                            <back />
                        </el-icon>返回
                    </span>
                </el-breadcrumb>
                <router-view></router-view>
            </el-main>
             
        </el-container>
    </div>
</template>

<script setup>
import defaultAvatar from '@/assets/默认头像.png'; // 导入默认头像图片
import { useCommonStore } from '@/store';
import { ArrowDown, Back, Document, Lock, Setting, SwitchButton, User } from '@element-plus/icons-vue';
import { computed, ref, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';

const commonStore = useCommonStore();
const router = useRouter();

// 计算属性
const Token = computed(() => commonStore.Token)
const UserInfo = computed(() => commonStore.UserInfo)
const RoleType = computed(() => commonStore.RoleType)
const UserId = computed(() => commonStore.UserId)

// 控制侧边栏折叠状态
const isCollapse = ref(false)

// 面包屑数据
const breadcrumbList = ref([])
const route = useRoute()

// 监听路由变化，更新面包屑
watch(
    () => route.matched,
    (matched) => {
        // 如果不是首页，添加首页到面包屑
        if (!isHome(matched[0])) {
            breadcrumbList.value = [
                { title: '控制台', path: '/' },
                ...matched.map(item => ({
                    title: item.meta.title || item.name,
                    path: item.path
                }))
            ]
        } else {
            breadcrumbList.value = matched.map(item => ({
                title: item.meta.title || item.name,
                path: item.path
            }))
        }
    },
    { immediate: true }
)

function isHome(route) {
    return route.path === "/Admin";
}
function handleLogout() {
    commonStore.Logout();
    router.push("/Login");
}
function goBack() {
    router.back();
}
function handleUserInfo() {
    router.push("/Admin/UserPerson");
}
function handlePasswordEdit() {
    router.push("/Admin/PasswordEdit");
}
</script>

<style scoped lang="scss">
/* 整体布局样式 */
.admin-layout {
    height: 100vh;
    display: flex;
    flex-direction: column;
}

/* 顶部导航栏样式 */
.header {
    background-color: #fff;
    border-bottom: 1px solid #dcdfe6;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 20px;
    height: 60px;
    box-shadow: 0 1px 4px rgba(0, 21, 41, .08);
}

/* 左侧区域样式 */
.header-left {
    display: flex;
    align-items: center;
}

/* Logo样式 */
.logo {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 5px 0;
}

.logo-image {
    height: 40px;
    display: flex;
    align-items: center;
}

.logo-image img {
    height: 100%;
    width: auto;
    object-fit: contain;
}

.logo-content {
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.system-title {
    font-size: 18px;
    font-weight: 600;
    color: #1a1a1a;
    margin: 0;
    line-height: 1.2;
}

.system-subtitle {
    font-size: 12px;
    color: #666;
    margin: 0;
    line-height: 1.2;
}

/* 右侧用户信息样式 */
.header-right {
    display: flex;
    align-items: center;
}

.user-info {
    display: flex;
    align-items: center;
    gap: 12px;
    cursor: pointer;
    padding: 4px 8px;
    border-radius: 4px;
    transition: background-color 0.3s;
}

.user-info:hover {
    background-color: #f5f7fa;
}

.user-details {
    display: flex;
    flex-direction: column;
    line-height: 1.2;
}

.username {
    font-size: 14px;
    color: #303133;
    font-weight: 500;
}

.role {
    font-size: 12px;
    color: #909399;
}

/* 下拉菜单项样式 */
:deep(.el-dropdown-menu__item) {
    display: flex;
    align-items: center;
    gap: 8px;
}

:deep(.el-dropdown-menu__item .el-icon) {
    margin-right: 4px;
}

/* 主体容器样式 */
.main-container {
    flex: 1;
    overflow: hidden;
}

/* 侧边栏样式 */
.el-aside {
    background-color: #304156;
    height: 100%;
}

/* 菜单样式 */
.el-menu-vertical {
    border-right: none;
}

/* 主内容区样式 */
.main-content {
    background-color: #f0f2f5;
    padding: 20px;
    height: calc(100vh - 60px);
    overflow-y: scroll;
    box-sizing: border-box;
}

/* 面包屑样式 */
.breadcrumb {
    margin-bottom: 20px;
    padding: 10px;
    align-items: center;
    display: flex;
    background-color: #fff;
    border-radius: 4px;
}

/* 返回链接样式 */
.back-link {
    margin-left: auto;
    cursor: pointer;
    color: #409EFF;
    display: flex;
    align-items: center;
    gap: 4px;
}

.back-link:hover {
    color: #66b1ff;
}
</style>
