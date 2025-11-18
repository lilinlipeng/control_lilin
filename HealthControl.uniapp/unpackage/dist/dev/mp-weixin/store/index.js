"use strict";
const common_vendor = require("../common/vendor.js");
const utils_http = require("../utils/http.js");
const utils_cache = require("../utils/cache.js");
const common_assets = require("../common/assets.js");
if (!Array) {
  const _easycom_uni_nav_bar2 = common_vendor.resolveComponent("uni-nav-bar");
  const _easycom_uni_icons2 = common_vendor.resolveComponent("uni-icons");
  const _easycom_footer_bar2 = common_vendor.resolveComponent("footer-bar");
  (_easycom_uni_nav_bar2 + _easycom_uni_icons2 + _easycom_footer_bar2)();
}
const _easycom_uni_nav_bar = () => "../uni_modules/uni-nav-bar/components/uni-nav-bar/uni-nav-bar.js";
const _easycom_uni_icons = () => "../uni_modules/uni-icons/components/uni-icons/uni-icons.js";
const _easycom_footer_bar = () => "../components/footer-bar/footer-bar.js";
if (!Math) {
  (_easycom_uni_nav_bar + _easycom_uni_icons + _easycom_footer_bar)();
}
const _sfc_main = {
  __name: "HealthIndicatorList",
  setup(__props) {
    const commonStore = useCommonStore();
    common_vendor.computed(() => commonStore.Token);
    common_vendor.computed(() => commonStore.UserInfo);
    common_vendor.computed(() => commonStore.RoleType);
    const UserId = common_vendor.computed(() => commonStore.UserId);
    const themeColor = common_vendor.ref("var(--primary-color)");
    common_vendor.ref([]);
    common_vendor.reactive({});
    common_vendor.onLoad(async (option) => {
    });
    common_vendor.onShow(async () => {
      GetUserHealthIndicatorTypeListApi();
    });
    common_vendor.onReady(async () => {
    });
    const UserHealthIndicatorTypeList = common_vendor.ref([]);
    const selectedIndicators = common_vendor.ref([]);
    const isSelectionMode = common_vendor.ref(false);
    const expandedCategoryMap = common_vendor.ref({});
    const GetUserHealthIndicatorTypeListApi = async () => {
      let {
        Data: {
          Items
        }
      } = await utils_http.Post("/HealthIndicatorType/UserHealthIndicatorList", {
        BelongUserId: UserId.value
      });
      UserHealthIndicatorTypeList.value = Items;
      const nextMap = { ...expandedCategoryMap.value };
      Items.forEach((item) => {
        if (nextMap[item.Id] === void 0) {
          nextMap[item.Id] = true;
        }
      });
      expandedCategoryMap.value = nextMap;
    };
    const UserRemoveIndicatorApi = async (Id) => {
      let { Success } = await utils_http.Post("/HealthIndicator/UserRemoveIndicator", {
        Id
      });
      if (Success) {
        await GetUserHealthIndicatorTypeListApi();
      }
    };
    const goToOfficialIndicators = () => {
      common_vendor.index.navigateTo({
        url: "/pages/Front/CommHealthIndicatorTypeList"
      });
    };
    const goToCustomIndicators = () => {
      common_vendor.index.navigateTo({
        url: "/pages/Front/HealthIndicatorForm?Id="
      });
    };
    const goToMyRecords = () => {
      common_vendor.index.navigateTo({
        url: "/pages/Front/HealthIndicatorRecordList"
      });
    };
    const goToIndicatorDetail = (indicator) => {
      if (isSelectionMode.value) {
        toggleIndicatorSelection(indicator);
      } else {
        showActionModal(indicator);
      }
    };
    const toggleIndicatorSelection = (indicator) => {
      const index = selectedIndicators.value.findIndex((item) => item.Id === indicator.Id);
      if (index > -1) {
        selectedIndicators.value.splice(index, 1);
      } else {
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
    const isIndicatorSelected = (indicatorId) => {
      return selectedIndicators.value.some((item) => item.Id === indicatorId);
    };
    const getUserIndicatorTypeName = (typeId) => {
      const type = UserHealthIndicatorTypeList.value.find((item) => item.Id === typeId);
      return type ? type.Name : "";
    };
    const toggleSelectionMode = () => {
      isSelectionMode.value = !isSelectionMode.value;
      if (!isSelectionMode.value) {
        selectedIndicators.value = [];
      }
    };
    const toggleCategory = (categoryId) => {
      const current = expandedCategoryMap.value[categoryId];
      expandedCategoryMap.value = {
        ...expandedCategoryMap.value,
        [categoryId]: !current
      };
    };
    const isCategoryExpanded = (categoryId) => {
      return !!expandedCategoryMap.value[categoryId];
    };
    const goToBatchRecord = () => {
      if (selectedIndicators.value.length === 0) {
        common_vendor.index.showToast({
          title: "请先选择指标",
          icon: "none"
        });
        return;
      }
      common_vendor.index.setStorageSync("selectedIndicators", JSON.stringify(selectedIndicators.value));
      common_vendor.index.navigateTo({
        url: `/pages/Front/BatchRecordForm?`
      });
    };
    const showActionModal = (indicator) => {
      common_vendor.index.showActionSheet({
        itemList: ["编辑指标", "删除指标"],
        itemColor: "#333333",
        success: (res) => {
          if (res.tapIndex === 0) {
            editIndicator(indicator);
          } else if (res.tapIndex === 1) {
            confirmDeleteIndicator(indicator);
          }
        }
      });
    };
    const editIndicator = (indicator) => {
      common_vendor.index.navigateTo({
        url: `/pages/Front/HealthIndicatorForm?Id=${indicator.Id}`
      });
    };
    const confirmDeleteIndicator = (indicator) => {
      common_vendor.index.showModal({
        title: "确认删除",
        content: `确定要删除指标"${indicator.Name}"吗？此操作不可恢复。`,
        confirmText: "删除",
        confirmColor: "#F44336",
        cancelText: "取消",
        success: async (res) => {
          if (res.confirm) {
            try {
              await UserRemoveIndicatorApi(indicator.Id);
              common_vendor.index.showToast({
                title: "删除成功",
                icon: "success"
              });
            } catch (error) {
              common_vendor.index.showToast({
                title: "删除失败",
                icon: "error"
              });
            }
          }
        }
      });
    };
    return (_ctx, _cache) => {
      return common_vendor.e({
        a: common_vendor.p({
          dark: true,
          fixed: true,
          shadow: true,
          ["background-color"]: "var(--primary-color)",
          ["status-bar"]: true,
          title: "健康指标"
        }),
        b: common_vendor.unref(common_assets.selectIcon),
        c: common_vendor.o(goToOfficialIndicators),
        d: common_vendor.unref(common_assets.addIcon),
        e: common_vendor.o(goToCustomIndicators),
        f: common_vendor.unref(common_assets.recordIcon),
        g: common_vendor.o(goToMyRecords),
        h: UserHealthIndicatorTypeList.value.length > 0
      }, UserHealthIndicatorTypeList.value.length > 0 ? common_vendor.e({
        i: common_vendor.p({
          type: "bars",
          size: "18",
          color: themeColor.value
        }),
        j: !isSelectionMode.value
      }, !isSelectionMode.value ? {
        k: common_vendor.p({
          type: "checkmarkempty",
          size: "14",
          color: "#ffffff"
        }),
        l: common_vendor.o(toggleSelectionMode)
      } : {
        m: common_vendor.p({
          type: "close",
          size: "14",
          color: "#ffffff"
        }),
        n: common_vendor.o(toggleSelectionMode)
      }, {
        o: isSelectionMode.value
      }, isSelectionMode.value ? common_vendor.e({
        p: common_vendor.p({
          type: "info",
          size: "16",
          color: themeColor.value
        }),
        q: common_vendor.t(selectedIndicators.value.length),
        r: selectedIndicators.value.length > 0
      }, selectedIndicators.value.length > 0 ? {
        s: common_vendor.p({
          type: "compose",
          size: "14",
          color: "#ffffff"
        }),
        t: common_vendor.o(goToBatchRecord)
      } : {}) : {}, {
        v: common_vendor.f(UserHealthIndicatorTypeList.value, (category, categoryIndex, i0) => {
          return {
            a: common_vendor.t(category.Name),
            b: common_vendor.t(category.HealthIndicatorDtoList.length),
            c: "920f6292-6-" + i0,
            d: common_vendor.p({
              type: isCategoryExpanded(category.Id) ? "arrowup" : "arrowdown",
              size: "18",
              color: "#888888"
            }),
            e: common_vendor.o(($event) => toggleCategory(category.Id), category.Id),
            f: common_vendor.f(category.HealthIndicatorDtoList, (indicator, indicatorIndex, i1) => {
              return common_vendor.e(isSelectionMode.value ? common_vendor.e({
                a: isIndicatorSelected(indicator.Id)
              }, isIndicatorSelected(indicator.Id) ? {
                b: "920f6292-7-" + i0 + "-" + i1,
                c: common_vendor.p({
                  type: "checkmarkempty",
                  size: "16",
                  color: "#ffffff"
                })
              } : {}, {
                d: isIndicatorSelected(indicator.Id) ? 1 : ""
              }) : {}, {
                e: indicator.Cover
              }, indicator.Cover ? {
                f: indicator.Cover
              } : {
                g: "920f6292-8-" + i0 + "-" + i1,
                h: common_vendor.p({
                  type: "pulse",
                  size: "24",
                  color: themeColor.value
                })
              }, {
                i: common_vendor.t(indicator.Name),
                j: common_vendor.t(indicator.Threshold),
                k: common_vendor.t(indicator.Content)
              }, !isSelectionMode.value ? {
                l: "920f6292-9-" + i0 + "-" + i1,
                m: common_vendor.p({
                  type: "arrowright",
                  size: "14",
                  color: "#cccccc"
                })
              } : {}, {
                n: indicator.Id,
                o: isIndicatorSelected(indicator.Id) ? 1 : "",
                p: common_vendor.o(($event) => goToIndicatorDetail(indicator), indicator.Id)
              });
            }),
            g: isCategoryExpanded(category.Id),
            h: category.Id
          };
        }),
        w: isSelectionMode.value,
        x: !isSelectionMode.value,
        y: isSelectionMode.value ? 1 : ""
      }) : {
        z: common_vendor.p({
          type: "list",
          size: "60",
          color: "#cccccc"
        })
      });
    };
  }
};
const MiniProgramPage = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__scopeId", "data-v-920f6292"]]);
const useCommonStore = common_vendor.defineStore("common", {
  state: () => ({
    // 初始状态
    Token: utils_cache.GetLoginToken(),
    UserInfo: null,
    RoleType: void 0,
    HasUserInfo: false,
    FooterBarList: [
      {
        url: "/pages/Front/Index",
        label: "首 页",
        icon: common_assets.HomeIcon
      },
      {
        url: "/pages/Front/HealthIndicatorList",
        label: "健康指标",
        icon: common_assets.HealthIndicatorIcon
      },
      {
        url: "/pages/Front/UserCenter",
        label: "个人中心",
        icon: common_assets.UserIcon
      }
    ]
  }),
  getters: {
    UserId: (state) => state.UserInfo && state.UserInfo.Id
  },
  actions: {
    async Login(UserInfo) {
      let res = await utils_http.Post("/User/SignIn", UserInfo);
      if (res.Success) {
        this.$patch({
          Token: res.Data
        });
        utils_cache.SetLoginToken(res.Data);
      }
      return res;
    },
    async GetInfo() {
      let res = await utils_http.Post("/User/GetByToken", {});
      this.$patch({
        UserInfo: res.Data,
        HasUserInfo: res.Data != null,
        RoleType: res.Data.RoleTypeFormat
      });
      return res;
    },
    /**
     * 退出登录
     */
    async Logout() {
      utils_cache.RemoveLoginToken();
      common_vendor.index.reLaunch({ url: "/pages/Front/Login" });
      this.$patch({
        Token: null,
        UserInfo: null,
        RoleType: null,
        HasUserInfo: false
      });
    },
    resetState() {
      this.$patch({
        Token: null,
        UserInfo: null,
        RoleType: void 0,
        HasUserInfo: false
      });
      utils_cache.RemoveLoginToken();
    },
    /**
     * 检查是否登录
     * @returns {boolean}
     */
    CheckIsLogin() {
      if (!this.Token) {
        common_vendor.index.reLaunch({ url: "/pages/Front/Login" });
      }
      return true;
    }
  }
});
exports.MiniProgramPage = MiniProgramPage;
exports.useCommonStore = useCommonStore;
//# sourceMappingURL=../../.sourcemap/mp-weixin/store/index.js.map
