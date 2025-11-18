<template>
    <view class="page-container">
        <!-- 顶部导航栏 -->
        <uni-nav-bar dark :fixed="true" shadow background-color="var(--primary-color)" status-bar title="健康管理" />

        <!-- 页面内容 -->
        <view class="content-wrapper">
            <!-- 欢迎横幅 -->
            <view class="welcome-banner">
                <view class="banner-content">
                    <view class="welcome-info">
                        <text class="welcome-title">您好，欢迎回来！</text>
                        <text class="welcome-subtitle">让我们一起关注您的健康</text>
                    </view>
                    <view class="health-icon">
                        <text class="icon">🏥</text>
                    </view>
                </view>
            </view>

            <!-- 健康数据概览 -->
            <view class="health-overview">
                <view class="section-title">
                    <text class="title-text">今日健康概览</text>
                    <text class="more-text">查看更多 ></text>
                </view>
                <view class="overview-cards">
                    <view class="overview-card">
                        <view class="card-icon heart">💗</view>
                        <text class="card-label">心率</text>
                        <text class="card-value">72</text>
                        <text class="card-unit">次/分</text>
                    </view>
                    <view class="overview-card">
                        <view class="card-icon blood">🩸</view>
                        <text class="card-label">血压</text>
                        <text class="card-value">120/80</text>
                        <text class="card-unit">mmHg</text>
                    </view>
                    <view class="overview-card">
                        <view class="card-icon weight">⚖️</view>
                        <text class="card-label">体重</text>
                        <text class="card-value">65.5</text>
                        <text class="card-unit">kg</text>
                    </view>
                    <view class="overview-card">
                        <view class="card-icon step">👟</view>
                        <text class="card-label">步数</text>
                        <text class="card-value">8,520</text>
                        <text class="card-unit">步</text>
                    </view>
                </view>
            </view>

            <!-- 快捷功能 -->
            <view class="quick-actions">
                <view class="section-title">
                    <text class="title-text">快捷功能</text>
                </view>
                <view class="action-grid">
                    <view class="action-item" @click="ToHealthRecordList()">
                        <view class="action-icon record">📊</view>
                        <text class="action-label">健康记录</text>
                    </view>
                    <view class="action-item" @click="ToDietRecordList()">
                        <view class="action-icon diet">🍎</view>
                        <text class="action-label">饮食记录</text>
                    </view>
                    <view class="action-item" @click="ToSportRecord()">
                        <view class="action-icon sport">🏃‍♂️</view>
                        <text class="action-label">运动记录</text>
                    </view>
                    <view class="action-item">
                        <view class="action-icon reminder">⏰</view>
                        <text class="action-label">健康提醒</text>
                    </view>
                    <view class="action-item" @click="ToHealthArticleList()">
                        <view class="action-icon article">📖</view>
                        <text class="action-label">健康知识</text>
                    </view>
                    <view class="action-item" @click="ToRecipeList()">
                        <view class="action-icon recipe">🥗</view>
                        <text class="action-label">健康食谱</text>
                    </view>
                </view>
            </view>

            <!-- 最新健康资讯 -->
            <view class="health-news">
                <view class="section-title">
                    <text class="title-text">健康资讯</text>
                    <text class="more-text" @click="ToHealthArticleList()">查看更多 ></text>
                </view>
                <view class="news-list">
                    <!-- 显示真实的健康资讯数据 -->
                    <view class="news-item" v-for="article in healthArticleList" :key="article.Id"
                        @click="ToHealthArticleDetail(article.Id)">
                        <view class="news-content">
                            <text class="news-title">{{ article.Title }}</text>
                            <text class="news-desc">{{ getArticleDesc(article.Content) }}</text>
                            <view class="news-meta">
                                <text class="news-time">{{ formatTime(article.CreationTime) }}</text>
                                <text class="news-category">{{ article.HealthArticleTypeDto.Name }}</text>
                                <text class="news-views">{{ article.ViewCount }}阅读</text>
                            </view>
                        </view>
                        <view class="news-image">
                            <image v-if="article.Cover" :src="article.Cover" class="cover-image" mode="aspectFill" />
                            <text v-else class="placeholder-icon">📖</text>
                        </view>
                    </view>

                    <!-- 没有数据时显示占位内容 -->
                    <view v-if="healthArticleList.length === 0" class="no-data">
                        <text class="no-data-text">暂无健康资讯</text>
                    </view>
                </view>
            </view>
        </view>

        <!-- 底部导航栏 -->
        <footer-bar />
    </view>
</template>

<script setup>
import { ref } from 'vue';
import { useCommonStore } from "@/store";
import { Post } from "@/utils/http";
import { onHide, onLoad, onShow, onUnload } from "@dcloudio/uni-app";

const commonStore = useCommonStore();

// 健康资讯数据状态
const healthArticleList = ref([]);

//"pages/Front/RecipeList"
const ToRecipeList = () => {
    uni.navigateTo({
        url: '/pages/Front/RecipeList'
    });
};

const ToDietRecordList = () => {
    uni.navigateTo({
        url: '/pages/Front/DietRecordList'
    });
};

const ToSportRecord = () => {
    uni.navigateTo({
        url: '/pages/Front/SportRecordList'
    });
};

const ToHealthRecordList = () => {
    uni.navigateTo({
        url: '/pages/Front/HealthIndicatorRecordList'
    });
};

const ToHealthArticleList = () => {
    uni.navigateTo({
        url: '/pages/Front/HealthArticleList'
    });
};

// 跳转到健康文章详情
const ToHealthArticleDetail = (articleId) => {
    uni.navigateTo({
        url: `/pages/Front/HealthArticleDetail?HealthArticleId=${articleId}`
    });
};

// 提取文章描述（去除HTML标签，截取前50个字符）
const getArticleDesc = (content) => {
    if (!content) return '暂无描述';
    // 去除HTML标签
    const plainText = content.replace(/<[^>]*>/g, '');
    // 截取前50个字符
    return plainText.length > 50 ? plainText.substring(0, 50) + '...' : plainText;
};

// 格式化时间显示
const formatTime = (timeStr) => {
    if (!timeStr) return '';

    const now = new Date();
    const articleTime = new Date(timeStr);
    const diff = now - articleTime;

    const minutes = Math.floor(diff / (1000 * 60));
    const hours = Math.floor(diff / (1000 * 60 * 60));
    const days = Math.floor(diff / (1000 * 60 * 60 * 24));

    if (minutes < 60) {
        return minutes <= 0 ? '刚刚' : `${minutes}分钟前`;
    } else if (hours < 24) {
        return `${hours}小时前`;
    } else if (days < 7) {
        return `${days}天前`;
    } else {
        // 超过7天显示具体日期
        return articleTime.toLocaleDateString('zh-CN', {
            month: '2-digit',
            day: '2-digit'
        });
    }
};
// 获取健康知识列表
const GetHealthArticleListApi = async () => {
    try {
        const response = await Post('/HealthArticle/List', {
            Page: 1,
            Limit: 10, // 首页只显示2条最新资讯
            AuditStatus: 2,
            SortItem: {
                FieldName: "ViewCount",
                IsAsc: false
            }
        });
        if (response.Success && response.Data && response.Data.Items) {
            healthArticleList.value = response.Data.Items;
        }
    } catch (error) {
        console.error('获取健康知识列表失败:', error);
        uni.showToast({
            title: '获取数据失败',
            icon: 'error'
        });
    }
};
onLoad(() => {

});

onShow(() => {
    if (commonStore.CheckIsLogin()) {
        GetHealthArticleListApi();
    }
});

onHide(() => {

});

onUnload(() => {

});
</script>

<style scoped lang="scss">
/* 页面容器 */
.page-container {
    min-height: 100vh;
    background: linear-gradient(135deg, #f8fffe 0%, #ecfdf5 100%);
}

/* 内容包装器 */
.content-wrapper {
    padding: 20upx;
    padding-bottom: 140upx;
    /* 给底部导航留出空间 */
}

/* 欢迎横幅 */
.welcome-banner {
    background: linear-gradient(135deg, var(--primary-color) 0%, var(--primary-light) 100%);
    border-radius: var(--border-radius-lg);
    margin-bottom: var(--spacing-base);
    box-shadow: var(--box-shadow-base);
}

.banner-content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: var(--spacing-lg);
}

.welcome-info {
    display: flex;
    flex-direction: column;
}

.welcome-title {
    color: white;
    font-size: var(--font-size-lg);
    font-weight: 600;
    margin-bottom: var(--spacing-xs);
}

.welcome-subtitle {
    color: rgba(255, 255, 255, 0.9);
    font-size: var(--font-size-base);
}

.health-icon {
    .icon {
        font-size: 60upx;
    }
}

/* 健康概览 */
.health-overview {
    margin-bottom: var(--spacing-base);
}

.section-title {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: var(--spacing-base);
    padding: 0 var(--spacing-xs);
}

.title-text {
    font-size: var(--font-size-md);
    font-weight: 600;
    color: var(--text-color);
}

.more-text {
    font-size: var(--font-size-sm);
    color: var(--primary-color);
}

.overview-cards {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: var(--spacing-base);
}

.overview-card {
    background: white;
    border-radius: var(--border-radius-base);
    padding: var(--spacing-base);
    display: flex;
    flex-direction: column;
    align-items: center;
    box-shadow: var(--box-shadow-sm);
    transition: var(--transition-base);
}

.overview-card:active {
    transform: scale(0.98);
}

.card-icon {
    font-size: 48upx;
    margin-bottom: var(--spacing-xs);
}

.card-label {
    font-size: var(--font-size-sm);
    color: var(--text-color-light);
    margin-bottom: var(--spacing-xs);
}

.card-value {
    font-size: var(--font-size-lg);
    font-weight: 600;
    color: var(--text-color);
    margin-bottom: 4upx;
}

.card-unit {
    font-size: var(--font-size-xs);
    color: var(--text-color-lighter);
}

/* 快捷功能 */
.quick-actions {
    margin-bottom: var(--spacing-base);
}

.action-grid {
    background: white;
    border-radius: var(--border-radius-base);
    padding: var(--spacing-base);
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: var(--spacing-lg);
    box-shadow: var(--box-shadow-sm);
}

.action-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    transition: var(--transition-base);
}

.action-item:active {
    transform: scale(0.95);
}

.action-icon {
    width: 80upx;
    height: 80upx;
    border-radius: var(--border-radius-circle);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 40upx;
    margin-bottom: var(--spacing-xs);
    background: var(--bg-color-light);
}

.action-label {
    font-size: var(--font-size-sm);
    color: var(--text-color);
    text-align: center;
}

/* 健康资讯 */
.health-news {
    margin-bottom: var(--spacing-base);
}

.news-list {
    background: white;
    border-radius: var(--border-radius-base);
    overflow: hidden;
    box-shadow: var(--box-shadow-sm);
}

.news-item {
    display: flex;
    padding: var(--spacing-base);
    border-bottom: 1upx solid var(--border-color-light);
    transition: var(--transition-base);
}

.news-item:last-child {
    border-bottom: none;
}

.news-item:active {
    background-color: var(--bg-color-hover);
}

.news-content {
    flex: 1;
    display: flex;
    flex-direction: column;
    margin-right: var(--spacing-base);
}

.news-title {
    font-size: var(--font-size-base);
    color: var(--text-color);
    font-weight: 500;
    margin-bottom: var(--spacing-xs);
}

.news-desc {
    font-size: var(--font-size-sm);
    color: var(--text-color-light);
    margin-bottom: var(--spacing-xs);
    line-height: 1.4;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
}

/* 文章元信息容器 */
.news-meta {
    display: flex;
    align-items: center;
    gap: var(--spacing-xs);
}

.news-time {
    font-size: var(--font-size-xs);
    color: var(--text-color-lighter);
}

.news-category {
    font-size: var(--font-size-xs);
    color: var(--primary-color);
    background: var(--primary-color-light);
    padding: 2upx 8upx;
    border-radius: 8upx;
}

.news-views {
    font-size: var(--font-size-xs);
    color: var(--text-color-lighter);
}

.news-image {
    width: 120upx;
    height: 80upx;
    border-radius: var(--border-radius-sm);
    background: var(--bg-color-light);
    display: flex;
    align-items: center;
    justify-content: center;
}

.placeholder-icon {
    font-size: 40upx;
}

/* 封面图片样式 */
.cover-image {
    width: 100%;
    height: 100%;
    border-radius: var(--border-radius-sm);
}

/* 无数据状态样式 */
.no-data {
    padding: var(--spacing-xl);
    text-align: center;
}

.no-data-text {
    font-size: var(--font-size-sm);
    color: var(--text-color-lighter);
}
</style>