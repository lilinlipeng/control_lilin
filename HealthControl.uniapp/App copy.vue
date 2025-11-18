<!-- <script setup>
import { useCommonStore } from "@/store";

import { onHide, onLaunch, onShow } from "@dcloudio/uni-app";
const commonStore = useCommonStore();

onLaunch(() => {

    if (commonStore.Token) {
        commonStore.GetInfo();
    }
});
onShow(() => {

});
onHide(() => {

});
</script>

<style lang="scss">
/* 颜色变量 */
page {
    /* 主题色变量 - 系统主题相关 */
    --primary-color: #007AFF;
    --primary-color-light: #4A9EFF;
    --primary-color-dark: #0056CC;
    --success-color: #34C759;
    --success-color-light: #5DD579;
    --success-color-dark: #2A9D47;
    --warning-color: #FF9500;
    --warning-color-light: #FFB84D;
    --warning-color-dark: #CC7700;
    --error-color: #FF3B30;
    --error-color-light: #FF6B61;
    --error-color-dark: #CC2F26;
    --info-color: #8E8E93;
    --info-color-light: #AEAEB2;
    --info-color-dark: #6D6D70;

    /* 文本颜色 - 系统主题相关 */
    --text-color: #1D1D1F;
    --text-color-secondary: #48484A;
    --text-color-tertiary: #8E8E93;
    --text-color-quaternary: #C7C7CC;
    --text-color-placeholder: #AEAEB2;
    --text-color-disabled: #D1D1D6;
    --text-color-inverse: #FFFFFF;
    --text-color-link: var(--primary-color);
    --text-color-link-hover: var(--primary-color-dark);

    /* 背景颜色 - 系统主题相关 */
    --bg-color: #FFFFFF;
    --bg-color-secondary: #F2F2F7;
    --bg-color-tertiary: #FFFFFF;
    --bg-color-grouped: #F2F2F7;
    --bg-color-grouped-secondary: #FFFFFF;
    --bg-color-hover: #E5E5EA;
    --bg-color-selected: #E3F2FD;
    --bg-color-mask: rgba(0, 0, 0, 0.4);
    --bg-color-overlay: rgba(0, 0, 0, 0.5);

    /* 边框颜色 - 系统主题相关 */
    --border-color: #C6C6C8;
    --border-color-light: #D1D1D6;
    --border-color-lighter: #E5E5EA;
    --border-color-focus: var(--primary-color);
    --border-color-error: var(--error-color);
    --border-color-success: var(--success-color);

    /* 字体大小 */
    --font-size-xs: 20upx;
    --font-size-sm: 24upx;
    --font-size-base: 28upx;
    --font-size-md: 32upx;
    --font-size-lg: 36upx;
    --font-size-xl: 40upx;

    /* 圆角 */
    --border-radius-sm: 4upx;
    --border-radius-base: 8upx;
    --border-radius-lg: 16upx;
    --border-radius-circle: 50%;
    --border-radius-pill: 9999upx;

    /* 间距 */
    --spacing-xs: 10upx;
    --spacing-sm: 20upx;
    --spacing-base: 30upx;
    --spacing-md: 40upx;
    --spacing-lg: 50upx;
    --spacing-xl: 60upx;

    /* 阴影 */
    --box-shadow-sm: 0 2upx 8upx rgba(0, 0, 0, 0.1);
    --box-shadow-base: 0 4upx 12upx rgba(0, 0, 0, 0.15);
    --box-shadow-lg: 0 8upx 24upx rgba(0, 0, 0, 0.2);

    /* 过渡动画 */
    --transition-base: all 0.3s ease;
    --transition-fast: all 0.2s ease;
    --transition-slow: all 0.4s ease;


    /* 透明度 */
    --opacity-medium: 0.7;

    /* 图片尺寸 */
    --img-size-sm: 40upx;
    --img-size-base: 60upx;
}

// 添加uni-app的变量
$uni-tabbar-height: 100upx;
$uni-img-size-base: 60upx;
$uni-font-size-base: 28upx;
$uni-font-size-md: 32upx;

/* 全局重置样式 */
view,
text,
navigator,
button,
input,
textarea,
label,
form {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

/* 文本溢出省略 */
.text-ellipsis {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.text-ellipsis-2 {
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    line-clamp: 2;
    -webkit-box-orient: vertical;
}

/* 弹性布局工具类 */
.flex {
    display: flex;
}

.flex-row {
    flex-direction: row;
}

.flex-column {
    flex-direction: column;
}

.flex-wrap {
    flex-wrap: wrap;
}

.flex-nowrap {
    flex-wrap: nowrap;
}

.flex-1 {
    flex: 1;
}

.justify-start {
    justify-content: flex-start;
}

.justify-end {
    justify-content: flex-end;
}

.justify-center {
    justify-content: center;
}

.justify-between {
    justify-content: space-between;
}

.justify-around {
    justify-content: space-around;
}

.align-start {
    align-items: flex-start;
}

.align-end {
    align-items: flex-end;
}

.align-center {
    align-items: center;
}

.align-stretch {
    align-items: stretch;
}

/* 文本对齐 */
.text-left {
    text-align: left;
}

.text-center {
    text-align: center;
}

.text-right {
    text-align: right;
}

/* 文本颜色 */
.text-primary {
    color: var(--primary-color);
}

.text-success {
    color: var(--success-color);
}

.text-warning {
    color: var(--warning-color);
}

.text-error {
    color: var(--error-color);
}

.text-info {
    color: var(--info-color);
}

.text-secondary {
    color: var(--text-color-secondary);
}

.text-tertiary {
    color: var(--text-color-tertiary);
}

.text-quaternary {
    color: var(--text-color-quaternary);
}

.text-link {
    color: var(--text-color-link);
}

.text-link:hover {
    color: var(--text-color-link-hover);
}

/* 背景颜色 */
.bg-primary {
    background-color: var(--primary-color);
}

.bg-success {
    background-color: var(--success-color);
}

.bg-warning {
    background-color: var(--warning-color);
}

.bg-error {
    background-color: var(--error-color);
}

.bg-info {
    background-color: var(--info-color);
}

.bg-white {
    background-color: #ffffff;
}

.bg-transparent {
    background-color: transparent;
}

.bg-light {
    background-color: var(--bg-color-secondary);
}

.bg-secondary {
    background-color: var(--bg-color-secondary);
}

.bg-tertiary {
    background-color: var(--bg-color-tertiary);
}

.bg-grouped {
    background-color: var(--bg-color-grouped);
}

.bg-grouped-secondary {
    background-color: var(--bg-color-grouped-secondary);
}

.bg-hover {
    background-color: var(--bg-color-hover);
}

.bg-selected {
    background-color: var(--bg-color-selected);
}

/* 边距 */
.m-0 {
    margin: 0;
}

.m-xs {
    margin: var(--spacing-xs);
}

.m-sm {
    margin: var(--spacing-sm);
}

.m-base {
    margin: var(--spacing-base);
}

.m-md {
    margin: var(--spacing-md);
}

.m-lg {
    margin: var(--spacing-lg);
}

.mt-0 {
    margin-top: 0;
}

.mt-xs {
    margin-top: var(--spacing-xs);
}

.mt-sm {
    margin-top: var(--spacing-sm);
}

.mt-base {
    margin-top: var(--spacing-base);
}

.mt-md {
    margin-top: var(--spacing-md);
}

.mt-lg {
    margin-top: var(--spacing-lg);
}

.mr-0 {
    margin-right: 0;
}

.mr-xs {
    margin-right: var(--spacing-xs);
}

.mr-sm {
    margin-right: var(--spacing-sm);
}

.mr-base {
    margin-right: var(--spacing-base);
}

.mr-md {
    margin-right: var(--spacing-md);
}

.mr-lg {
    margin-right: var(--spacing-lg);
}

.mb-0 {
    margin-bottom: 0;
}

.mb-xs {
    margin-bottom: var(--spacing-xs);
}

.mb-sm {
    margin-bottom: var(--spacing-sm);
}

.mb-base {
    margin-bottom: var(--spacing-base);
}

.mb-md {
    margin-bottom: var(--spacing-md);
}

.mb-lg {
    margin-bottom: var(--spacing-lg);
}

.ml-0 {
    margin-left: 0;
}

.ml-xs {
    margin-left: var(--spacing-xs);
}

.ml-sm {
    margin-left: var(--spacing-sm);
}

.ml-base {
    margin-left: var(--spacing-base);
}

.ml-md {
    margin-left: var(--spacing-md);
}

.ml-lg {
    margin-left: var(--spacing-lg);
}

.p-0 {
    padding: 0;
}

.p-xs {
    padding: var(--spacing-xs);
}

.p-sm {
    padding: var(--spacing-sm);
}

.p-base {
    padding: var(--spacing-base);
}

.p-md {
    padding: var(--spacing-md);
}

.p-lg {
    padding: var(--spacing-lg);
}

.pt-0 {
    padding-top: 0;
}

.pt-xs {
    padding-top: var(--spacing-xs);
}

.pt-sm {
    padding-top: var(--spacing-sm);
}

.pt-base {
    padding-top: var(--spacing-base);
}

.pt-md {
    padding-top: var(--spacing-md);
}

.pt-lg {
    padding-top: var(--spacing-lg);
}

.pr-0 {
    padding-right: 0;
}

.pr-xs {
    padding-right: var(--spacing-xs);
}

.pr-sm {
    padding-right: var(--spacing-sm);
}

.pr-base {
    padding-right: var(--spacing-base);
}

.pr-md {
    padding-right: var(--spacing-md);
}

.pr-lg {
    padding-right: var(--spacing-lg);
}

.pb-0 {
    padding-bottom: 0;
}

.pb-xs {
    padding-bottom: var(--spacing-xs);
}

.pb-sm {
    padding-bottom: var(--spacing-sm);
}

.pb-base {
    padding-bottom: var(--spacing-base);
}

.pb-md {
    padding-bottom: var(--spacing-md);
}

.pb-lg {
    padding-bottom: var(--spacing-lg);
}

.pl-0 {
    padding-left: 0;
}

.pl-xs {
    padding-left: var(--spacing-xs);
}

.pl-sm {
    padding-left: var(--spacing-sm);
}

.pl-base {
    padding-left: var(--spacing-base);
}

.pl-md {
    padding-left: var(--spacing-md);
}

.pl-lg {
    padding-left: var(--spacing-lg);
}

/* 边框 */
.border {
    border: 1upx solid var(--border-color);
}

.border-top {
    border-top: 1upx solid var(--border-color);
}

.border-right {
    border-right: 1upx solid var(--border-color);
}

.border-bottom {
    border-bottom: 1upx solid var(--border-color);
}

.border-left {
    border-left: 1upx solid var(--border-color);
}

/* 圆角 */
.rounded-sm {
    border-radius: var(--border-radius-sm);
}

.rounded {
    border-radius: var(--border-radius-base);
}

.rounded-lg {
    border-radius: var(--border-radius-lg);
}

.rounded-circle {
    border-radius: var(--border-radius-circle);
}

.rounded-pill {
    border-radius: var(--border-radius-pill);
}

/* 阴影 */
.shadow-sm {
    box-shadow: var(--box-shadow-sm);
}

.shadow {
    box-shadow: var(--box-shadow-base);
}

.shadow-lg {
    box-shadow: var(--box-shadow-lg);
}

/* 定位 */
.position-relative {
    position: relative;
}

.position-absolute {
    position: absolute;
}

.position-fixed {
    position: fixed;
}

/* 宽高 */
.w-100 {
    width: 100%;
}

.h-100 {
    height: 100%;
}

/* 安全区域适配 */
.safe-area-inset-bottom {
    padding-bottom: env(safe-area-inset-bottom);
}

.safe-area-inset-top {
    padding-top: env(safe-area-inset-top);
}

/* 页面通用样式 */
.page-container {
    min-height: 100vh;
    background-color: var(--bg-color-grouped);
}

/* 内容区域 */
.content-container {
    padding: var(--spacing-base);
}

/* 卡片样式 */
.card {
    background-color: #ffffff;
    border-radius: var(--border-radius-base);
    padding: var(--spacing-base);
    margin-bottom: var(--spacing-base);
    box-shadow: var(--box-shadow-sm);
}

/* 按钮基础样式 */
.btn {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20upx 30upx;
    font-size: var(--font-size-base);
    border-radius: var(--border-radius-base);
    transition: var(--transition-base);
}

.btn-primary {
    background-color: var(--primary-color);
    color: #ffffff;
}

.btn-success {
    background-color: var(--success-color);
    color: #ffffff;
}

.btn-warning {
    background-color: var(--warning-color);
    color: #ffffff;
}

.btn-error {
    background-color: var(--error-color);
    color: #ffffff;
}


.form-container {
    padding: 10upx 30upx 20upx;
}
</style> -->
