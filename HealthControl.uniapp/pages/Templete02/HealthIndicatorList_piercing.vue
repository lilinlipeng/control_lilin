<template>
    <view>
        <!-- 导航栏 -->
        <uni-nav-bar dark :fixed="true" shadow background-color="var(--primary-color)" status-bar  title="健康指标" />

        <!-- 页面内容 -->
        <view class="page-content">
            <!-- 顶部入口区域 -->
            <view class="entry-section">
                <!-- 左侧卡片容器 -->
                <view class="left-cards">
                    <!-- 官方选择指标入口 -->
                    <view class="entry-card primary" @click="goToOfficialIndicators">
                        <!-- 卡片图标 -->
                        <view class="entry-icon">
                            <uni-icons type="checkmarkempty" size="22" color="#4CAF50"></uni-icons>
                        </view>
                        <!-- 卡片内容 -->
                        <view class="entry-content">
                            <view class="entry-title">官方选择指标</view>
                            <view class="entry-subtitle">从官方推荐的健康指标中选择</view>
                        </view>
                        <!-- 箭头图标 -->
                        <view class="entry-arrow">
                            <uni-icons type="arrowright" size="14" color="#4CAF50"></uni-icons>
                        </view>
                    </view>

                    <!-- 自主添加指标入口 -->
                    <view class="entry-card secondary" @click="goToCustomIndicators">
                        <!-- 卡片图标 -->
                        <view class="entry-icon">
                            <uni-icons type="plusempty" size="22" color="#2196F3"></uni-icons>
                        </view>
                        <!-- 卡片内容 -->
                        <view class="entry-content">
                            <view class="entry-title">自主添加指标</view>
                            <view class="entry-subtitle">创建个性化的健康指标</view>
                        </view>
                        <!-- 箭头图标 -->
                        <view class="entry-arrow">
                            <uni-icons type="arrowright" size="14" color="#2196F3"></uni-icons>
                        </view>
                    </view>
                </view>

                <!-- 右侧大卡片：我的填写记录 -->
                <view class="entry-card tertiary large-card" @click="goToMyRecords">
                    <!-- 卡片图标 -->
                    <view class="entry-icon">
                        <uni-icons type="list" size="28" color="#FF9800"></uni-icons>
                    </view>
                    <!-- 卡片内容 -->
                    <view class="entry-content">
                        <view class="entry-title">我的填写记录</view>
                        <view class="entry-subtitle">查看历史健康数据记录</view>
                    </view>
                    <!-- 箭头图标 -->
                    <view class="entry-arrow">
                        <uni-icons type="arrowright" size="18" color="#FF9800"></uni-icons>
                    </view>
                </view>
            </view>

            <!-- 健康指标列表区域 -->
            <view v-if="UserHealthIndicatorTypeList.length > 0" class="indicator-section">
                <!-- 标题和操作区域 -->
                <view class="section-header">
                    <view class="section-title">
                        <uni-icons type="bars" size="18" color="#4CAF50"></uni-icons>
                        <text class="title-text">我的健康指标</text>
                    </view>

                    <!-- 操作按钮 -->
                    <view class="section-actions">
                        <button v-if="!isSelectionMode" class="action-btn select-btn" @click="toggleSelectionMode">
                            <uni-icons type="checkmarkempty" size="14" color="#ffffff"></uni-icons>
                            <text class="btn-text">选择指标</text>
                        </button>
                        <button v-else class="action-btn cancel-btn" @click="toggleSelectionMode">
                            <uni-icons type="close" size="14" color="#ffffff"></uni-icons>
                            <text class="btn-text">取消</text>
                        </button>
                    </view>
                </view>

                <!-- 选择状态提示 -->
                <view v-if="isSelectionMode" class="selection-status">
                    <view class="status-info">
                        <uni-icons type="info" size="16" color="#4CAF50"></uni-icons>
                        <text class="status-text">已选择 {{ selectedIndicators.length }} 项指标</text>
                    </view>
                    <button v-if="selectedIndicators.length > 0" class="batch-record-btn" @click="goToBatchRecord">
                        <uni-icons type="compose" size="14" color="#ffffff"></uni-icons>
                        <text class="btn-text">批量录入数据</text>
                    </button>
                </view>

                <!-- 指标分类列表 -->
                <view v-for="(category, categoryIndex) in UserHealthIndicatorTypeList" :key="category.Id"
                    class="category-wrapper">
                    <!-- 分类标题 -->
                    <view class="category-header" @click="toggleCategory(category.Id)">
                        <view class="category-title">{{ category.Name }}</view>
                        <view class="category-right">
                        <view class="category-count">{{ category.HealthIndicatorDtoList.length }}项指标</view>
                            <view class="category-toggle">
                                <uni-icons :type="isCategoryExpanded(category.Id) ? 'arrowup' : 'arrowdown'" size="18" color="#888888"></uni-icons>
                            </view>
                        </view>
                    </view>

                    <!-- 指标列表 -->
                    <view class="indicators-grid" v-show="isCategoryExpanded(category.Id)">
                        <view v-for="(indicator, indicatorIndex) in category.HealthIndicatorDtoList" :key="indicator.Id"
                            class="indicator-card"
                            :class="{ 'selected': isIndicatorSelected(indicator.Id), 'selection-mode': isSelectionMode }"
                            @click="goToIndicatorDetail(indicator)">
                            <!-- 选择状态指示器 -->
                            <view v-if="isSelectionMode" class="selection-indicator">
                                <view class="checkbox" :class="{ 'checked': isIndicatorSelected(indicator.Id) }">
                                    <uni-icons v-if="isIndicatorSelected(indicator.Id)" type="checkmarkempty" size="16"
                                        color="#ffffff"></uni-icons>
                                </view>
                            </view>

                            <!-- 指标图标 -->
                            <view class="indicator-icon">
                                <image v-if="indicator.Cover" :src="indicator.Cover" class="icon-image" mode="aspectFit">
                                </image>
                                <uni-icons v-else type="pulse" size="24" color="#4CAF50"></uni-icons>
                            </view>

                            <!-- 指标信息 -->
                            <view class="indicator-info">
                                <view class="indicator-name">{{ indicator.Name }}</view>
                                <view class="indicator-threshold">正常值: {{ indicator.Threshold }}</view>
                                <view class="indicator-content">{{ indicator.Content }}</view>
                            </view>

                            <!-- 箭头 -->
                            <view v-if="!isSelectionMode" class="indicator-arrow">
                                <uni-icons type="arrowright" size="14" color="#cccccc"></uni-icons>
                            </view>
                        </view>
                    </view>
                </view>
            </view>

            <!-- 空状态 -->
            <view v-else class="empty-state">
                <view class="empty-icon">
                    <uni-icons type="list" size="60" color="#cccccc"></uni-icons>
                </view>
                <view class="empty-text">暂无健康指标</view>
                <view class="empty-subtitle">点击上方按钮添加您的第一个健康指标</view>
            </view>

        </view>

        <footer-bar />
    </view>
</template>

<script setup>

import { useCommonStore } from '@/store';
import { Post } from '@/utils/http';
import { onLoad, onReady, onShow } from "@dcloudio/uni-app";
import { computed, reactive, ref } from 'vue';

// 获取store
const commonStore = useCommonStore();
const Token = computed(() => commonStore.Token)
const UserInfo = computed(() => commonStore.UserInfo)
const RoleType = computed(() => commonStore.RoleType)
const UserId = computed(() => commonStore.UserId)



const TestInfoList = ref([]);

const where = reactive({

});

// 生命周期钩子
onLoad(async (option) => {
});
onShow(async () => {

    GetUserHealthIndicatorTypeListApi();
});

onReady(async () => {


});
const UserHealthIndicatorTypeList = ref([]);
// 清单管理
const selectedIndicators = ref([]); // 已选择的指标清单
const isSelectionMode = ref(false); // 是否在选择模式

// 分类展开/收起状态
const expandedCategoryMap = ref({});

//得到用户的指标分类
const GetUserHealthIndicatorTypeListApi = async () => {
    let {
        Data: {
            Items
        }
    } = await Post('/HealthIndicatorType/UserHealthIndicatorList', {
        BelongUserId: UserId.value
    });
    UserHealthIndicatorTypeList.value = Items;

    // 初始化或合并分类的展开状态，默认展开
    const nextMap = { ...expandedCategoryMap.value };
    Items.forEach(item => {
        if (nextMap[item.Id] === undefined) {
            nextMap[item.Id] = true;
        }
    });
    expandedCategoryMap.value = nextMap;
}

//移除指标
const UserRemoveIndicatorApi = async (Id) => {
    let { Success } = await Post('/HealthIndicator/UserRemoveIndicator', {
        Id: Id
    });
    if (Success) {
        await GetUserHealthIndicatorTypeListApi();
    }
}



// 跳转到健康指标归类页面
const goToHealthCategory = () => {

    uni.navigateTo({
        url: '/pages/Front/HealthIndicatorTypeList'
    });
};

// 跳转到官方选择指标页面
const goToOfficialIndicators = () => {
    uni.navigateTo({
        url: '/pages/Front/CommHealthIndicatorTypeList'
    });
};

// 跳转到自主添加指标页面
const goToCustomIndicators = () => {
    uni.navigateTo({
        url: '/pages/Front/HealthIndicatorForm?Id='
    });
};

// 跳转到我的填写记录页面
const goToMyRecords = () => {
    uni.navigateTo({
        url: '/pages/Front/HealthIndicatorRecordList'
    });
};

// 跳转到指标详情页面
const goToIndicatorDetail = (indicator) => {
    if (isSelectionMode.value) {
        // 在选择模式下，点击切换选择状态
        toggleIndicatorSelection(indicator);
    } else {
        // 正常模式下显示操作选择框
        showActionModal(indicator);
    }
};

// 切换指标选择状态
const toggleIndicatorSelection = (indicator) => {
    const index = selectedIndicators.value.findIndex(item => item.Id === indicator.Id);
    if (index > -1) {
        // 已选择，移除
        selectedIndicators.value.splice(index, 1);
    } else {
        // 未选择，添加
        selectedIndicators.value.push({
            Id: indicator.Id,
            Name: indicator.Name,
            HealthIndicatorTypeId: indicator.HealthIndicatorTypeId,
            HealthIndicatorTypeName: getUserIndicatorTypeName(indicator.HealthIndicatorTypeId),
            Threshold: indicator.Threshold,
            Content: indicator.Content,
            Cover: indicator.Cover
        });
    }
};

// 检查指标是否已选择
const isIndicatorSelected = (indicatorId) => {
    return selectedIndicators.value.some(item => item.Id === indicatorId);
};

// 获取指标分类名称
const getUserIndicatorTypeName = (typeId) => {
    const type = UserHealthIndicatorTypeList.value.find(item => item.Id === typeId);
    return type ? type.Name : '';
};

// 切换选择模式
const toggleSelectionMode = () => {
    isSelectionMode.value = !isSelectionMode.value;
    if (!isSelectionMode.value) {
        // 退出选择模式时清空选择
        selectedIndicators.value = [];
    }
};

// 切换分类展开/收起
const toggleCategory = (categoryId) => {
    const current = expandedCategoryMap.value[categoryId];
    expandedCategoryMap.value = {
        ...expandedCategoryMap.value,
        [categoryId]: !current
    };
};

// 分类是否展开
const isCategoryExpanded = (categoryId) => {
    return !!expandedCategoryMap.value[categoryId];
};

// 跳转到批量录入页面
const goToBatchRecord = () => {
    if (selectedIndicators.value.length === 0) {
        uni.showToast({
            title: '请先选择指标',
            icon: 'none'
        });
        return;
    }

    // 将选择的指标数据传递到录入页面
  uni.setStorageSync('selectedIndicators', JSON.stringify(selectedIndicators.value));
    uni.navigateTo({
    url: `/pages/Front/BatchRecordForm?`
    });
};
// 显示操作选择框
const showActionModal = (indicator) => {
    uni.showActionSheet({
        itemList: ['编辑指标', '删除指标'],
        itemColor: '#333333',
        success: (res) => {
            if (res.tapIndex === 0) {
                // 编辑指标
                editIndicator(indicator);
            } else if (res.tapIndex === 1) {
                // 删除指标
                confirmDeleteIndicator(indicator);
            }
        }
    });
};

// 编辑指标
const editIndicator = (indicator) => {
    uni.navigateTo({
        url: `/pages/Front/HealthIndicatorForm?Id=${indicator.Id}`
    });
};

// 确认删除指标
const confirmDeleteIndicator = (indicator) => {
    uni.showModal({
        title: '确认删除',
        content: `确定要删除指标"${indicator.Name}"吗？此操作不可恢复。`,
        confirmText: '删除',
        confirmColor: '#F44336',
        cancelText: '取消',
        success: async (res) => {
            if (res.confirm) {
                try {
                    await UserRemoveIndicatorApi(indicator.Id);
                    uni.showToast({
                        title: '删除成功',
                        icon: 'success'
                    });
                } catch (error) {
                    uni.showToast({
                        title: '删除失败',
                        icon: 'error'
                    });
                }
            }
        }
    });
};

const GetHealthIndicatorListApi = async () => {
    let {
        Data: {
            Items
        }
    } = await Post('/HealthIndicator/List', where);
    HealthIndicatorList.value = Items;
}
// 删除
const ShowDeleteModal = async (Id) => {
    uni.showModal({
        title: '提示',
        content: '确认删除该测试信息吗？',
        success: async (res) => {
            if (res.confirm) {
                const { Success } = await Post(`/HealthIndicator/Delete`, { Id: Id });
                if (Success) {
                    await GetHealthIndicatorListApi();
                    uni.showToast({
                        title: '删除成功',
                        icon: 'success'
                    });
                }
            }
        }
    })
};

</script>

<style scoped lang="scss">
/* 页面内容区域 */
.page-content {
    padding: 10rpx 24rpx 160px;
    min-height: 50vh;
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    position: relative;

    /* 添加一些光晕效果 */
    &::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 400rpx;
        background: linear-gradient(135deg, rgba(76, 175, 80, 0.05) 0%, rgba(33, 150, 243, 0.05) 100%);
        pointer-events: none;
    }
}

/* 顶部入口区域 */
.entry-section {
    display: flex;
    gap: 16rpx;
    margin-bottom: 32rpx;
}

/* 左侧卡片容器 */
.left-cards {
    display: flex;
    flex-direction: column;
    gap: 16rpx;
    flex: 1;
}

/* 入口卡片通用样式 */
.entry-card {
    display: flex;
    align-items: center;
    border-radius: 20rpx;
    padding: 22rpx 24rpx;
    background: rgba(255, 255, 255, 0.85);
    backdrop-filter: blur(20rpx);
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;

    /* 毛玻璃效果基础层 */
    &::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        backdrop-filter: blur(10rpx);
        z-index: -1;
    }

    /* 点击效果 */
    &:active {
        transform: scale(0.98);
        opacity: 0.9;
    }

    /* 左侧小卡片样式 */
    .left-cards & {
        flex: 1;
        min-height: 110rpx;
    }

    /* 大卡片样式 */
    &.large-card {
        flex: 1;
        min-height: 240rpx;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
    }

    /* 主色调卡片 - 绿色 */
    &.primary {
        border: 2rpx solid rgba(76, 175, 80, 0.4);
        box-shadow: 
            0 4rpx 20rpx rgba(76, 175, 80, 0.2),
            inset 0 1rpx 0 rgba(255, 255, 255, 0.6),
            0 0 0 0 rgba(76, 175, 80, 0);

        &:active {
            box-shadow: 
                0 2rpx 10rpx rgba(76, 175, 80, 0.2),
                inset 0 1rpx 0 rgba(255, 255, 255, 0.4),
                0 0 0 3rpx rgba(76, 175, 80, 0.15);
        }
    }

    /* 副色调卡片 - 蓝色 */
    &.secondary {
        border: 2rpx solid rgba(33, 150, 243, 0.4);
        box-shadow: 
            0 4rpx 20rpx rgba(33, 150, 243, 0.2),
            inset 0 1rpx 0 rgba(255, 255, 255, 0.6),
            0 0 0 0 rgba(33, 150, 243, 0);

        &:active {
            box-shadow: 
                0 2rpx 10rpx rgba(33, 150, 243, 0.2),
                inset 0 1rpx 0 rgba(255, 255, 255, 0.4),
                0 0 0 3rpx rgba(33, 150, 243, 0.15);
        }
    }

    /* 第三色调卡片 - 橙色 */
    &.tertiary {
        border: 2rpx solid rgba(255, 152, 0, 0.4);
        box-shadow: 
            0 4rpx 20rpx rgba(255, 152, 0, 0.2),
            inset 0 1rpx 0 rgba(255, 255, 255, 0.6),
            0 0 0 0 rgba(255, 152, 0, 0);

        &:active {
            box-shadow: 
                0 2rpx 10rpx rgba(255, 152, 0, 0.2),
                inset 0 1rpx 0 rgba(255, 255, 255, 0.4),
                0 0 0 3rpx rgba(255, 152, 0, 0.15);
        }
    }
}

/* 入口图标容器 */
.entry-icon {
    width: 52rpx;
    height: 52rpx;
    background: rgba(255, 255, 255, 0.4);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 16rpx;
    backdrop-filter: blur(10rpx);
    flex-shrink: 0;
    border: 1rpx solid rgba(255, 255, 255, 0.6);
    box-shadow: 0 2rpx 8rpx rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease;

    &:hover {
        transform: scale(1.1);
    }
}

/* 大卡片图标容器 */
.large-card .entry-icon {
    margin-right: 0;
    margin-bottom: 14rpx;
    width: 72rpx;
    height: 72rpx;
    box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.15);
}

/* 入口内容区域 */
.entry-content {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

/* 大卡片内容区域 */
.large-card .entry-content {
    margin: 0;
    text-align: center;
}

/* 入口主标题 */
.entry-title {
    font-size: 28rpx;
    font-weight: 600;
    color: #333333;
    margin-bottom: 4rpx;
    line-height: 1.3;
}

/* 大卡片主标题 */
.large-card .entry-title {
    font-size: 30rpx;
    margin-bottom: 10rpx;
}

/* 入口副标题 */
.entry-subtitle {
    font-size: 22rpx;
    color: #666666;
    line-height: 1.4;
}

/* 大卡片副标题 */
.large-card .entry-subtitle {
    font-size: 24rpx;
}

/* 入口箭头 */
.entry-arrow {
    margin-left: 12rpx;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* 大卡片箭头 */
.large-card .entry-arrow {
    margin-left: 0;
    margin-top: 16rpx;
}



/* 卡片图标容器 */
.card-icon {
    width: 80rpx;
    height: 80rpx;
    background: linear-gradient(135deg, #4CAF50, #45a049);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 24rpx;
    box-shadow: 0 4rpx 8rpx rgba(76, 175, 80, 0.3);
}

/* 卡片内容区域 */
.card-content {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

/* 卡片主标题 */
.card-title {
    font-size: 32rpx;
    font-weight: 600;
    color: #333333;
    margin-bottom: 8rpx;
    line-height: 1.4;
}

/* 卡片副标题 */
.card-subtitle {
    font-size: 26rpx;
    color: #888888;
    line-height: 1.5;
}

/* 卡片箭头 */
.card-arrow {
    margin-left: 16rpx;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* 健康指标区域样式 */
.indicator-section {
    margin-top: 16rpx;
}

/* 标题和操作区域 */
.section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20rpx;
    padding: 0 4rpx;
}

.section-title {
    display: flex;
    align-items: center;
}

.title-text {
    font-size: 32rpx;
    font-weight: 600;
    color: #333333;
    margin-left: 12rpx;
}

.section-actions {
    display: flex;
    gap: 16rpx;
}

/* 选择状态提示 */
.selection-status {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 16rpx 20rpx;
    background-color: #ffffff;
    border-radius: 16rpx;
    box-shadow: 0 2rpx 8rpx rgba(0, 0, 0, 0.1);
    margin: 0 24rpx 16rpx 24rpx;
}

.status-info {
    display: flex;
    align-items: center;
}

.status-text {
    font-size: 28rpx;
    font-weight: 600;
    color: #333333;
    margin-left: 8rpx;
}

.batch-record-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6rpx;
    padding: 8rpx 16rpx;
    border-radius: 24rpx;
    font-size: 24rpx;
    font-weight: 500;
    color: #ffffff;
    background-color: #4CAF50;
    box-shadow: 0 2rpx 8rpx rgba(76, 175, 80, 0.3);
    transition: background-color 0.3s ease;

    &:active {
        background-color: #45a049;
    }
}

/* 操作按钮样式 */
.action-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6rpx;
    padding: 8rpx 16rpx;
    border-radius: 24rpx;
    font-size: 24rpx;
    font-weight: 500;
    color: #ffffff;
    background-color: #4CAF50;
    box-shadow: 0 2rpx 8rpx rgba(76, 175, 80, 0.3);
    transition: background-color 0.3s ease;

    &:active {
        background-color: #45a049;
    }

    &.select-btn {
        background: linear-gradient(135deg, #4CAF50, #45a049);
    }

    &.clear-btn {
        background: linear-gradient(135deg, #FF9800, #F57C00);
    }

    &.cancel-btn {
        background: linear-gradient(135deg, #F44336, #D32F2F);
    }
}

.btn-text {
    font-size: 24rpx;
    font-weight: 500;
}

/* 分类包装器 */
.category-wrapper {
    margin-bottom: 32rpx;
}

/* 分类标题区域 */
.category-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 20rpx 24rpx;
    background: #ffffff;
    border-radius: 16rpx 16rpx 0 0;
    border-bottom: 2rpx solid #f0f0f0;
}

.category-title {
    font-size: 28rpx;
    font-weight: 600;
    color: #333333;
}

.category-count {
    font-size: 26rpx;
    color: #888888;
    font-weight: 500;
}

/* 分类右侧区域（数量 + 箭头） */
.category-right {
    display: flex;
    align-items: center;
    gap: 12rpx;
}

.category-toggle {
    display: flex;
    align-items: center;
}

/* 指标卡片 */
.indicator-card {
    display: flex;
    align-items: center;
    padding: 28rpx 24rpx;
    border-bottom: 2rpx solid #f8f8f8;
    transition: background-color 0.3s ease;

    &:last-child {
        border-bottom: none;
    }

    &:active {
        background-color: #f8f8f8;
    }

    /* 选择模式下的样式 */
    &.selection-mode {
        background-color: #f0f8f0;
        /* 浅绿色背景 */
        border-bottom: 2rpx solid #e0f0e0;
        /* 浅灰色边框 */
    }

    /* 已选择状态 */
    &.selected {
        background-color: #e8f5e9;
        /* 更深的浅绿色背景 */
        border-bottom: 2rpx solid #a5d6a7;
        /* 更深的浅绿色边框 */
    }
}

/* 选择状态指示器 */
.selection-indicator {
    position: absolute;
    top: 24rpx;
    left: 20rpx;
    z-index: 1;
}

.checkbox {
    width: 40rpx;
    height: 40rpx;
    border-radius: 50%;
    border: 2rpx solid #4CAF50;
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: #ffffff;

    &.checked {
        background-color: #4CAF50;
        border-color: #4CAF50;
    }
}

/* 指标图标容器 */
.indicator-icon {
    width: 80rpx;
    height: 80rpx;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #f0f8f0;
    border-radius: 16rpx;
    margin-right: 20rpx;
}

.icon-image {
    width: 60rpx;
    height: 60rpx;
    border-radius: 12rpx;
}

/* 指标信息区域 */
.indicator-info {
    flex: 1;
    display: flex;
    flex-direction: column;
}

.indicator-name {
    font-size: 28rpx;
    font-weight: 600;
    color: #333333;
    margin-bottom: 8rpx;
    line-height: 1.4;
}

.indicator-threshold {
    font-size: 24rpx;
    color: #4CAF50;
    margin-bottom: 6rpx;
    font-weight: 500;
}

.indicator-content {
    font-size: 22rpx;
    color: #666666;
    line-height: 1.5;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

/* 指标箭头 */
.indicator-arrow {
    margin-left: 16rpx;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* 空状态样式 */
.empty-state {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 120rpx 40rpx;
    text-align: center;
}

.empty-icon {
    margin-bottom: 24rpx;
    opacity: 0.6;
}

.empty-text {
    font-size: 32rpx;
    font-weight: 500;
    color: #666666;
    margin-bottom: 12rpx;
}

.empty-subtitle {
    font-size: 26rpx;
    color: #999999;
    line-height: 1.5;
}

/* 指标网格布局 */
.indicators-grid {
    background: #ffffff;
    border-radius: 0 0 16rpx 16rpx;
    
    overflow: hidden;
}
</style>