"use strict";
const common_vendor = require("../../common/vendor.js");
const common_assets = require("../../common/assets.js");
const store_index = require("../../store/index.js");
const utils_http = require("../../utils/http.js");
const _sfc_main = {
  __name: "PasswordEdit",
  setup(__props) {
    const commonStore = store_index.useCommonStore();
    const editModalForm = common_vendor.ref(null);
    const formData = common_vendor.reactive({
      OrginPassword: "",
      NewPassword: "",
      TwoPassword: ""
    });
    common_vendor.computed(() => commonStore.Token);
    common_vendor.computed(() => commonStore.UserInfo);
    common_vendor.computed(() => commonStore.RoleType);
    const UserId = common_vendor.computed(() => commonStore.UserId);
    const goBack = () => {
      common_vendor.index.navigateBack();
    };
    const createOrEdit = async () => {
      editModalForm.value.validate().then(async (res) => {
        const updatedUserInfo = {
          Id: UserId.value,
          OrginPassword: formData.OrginPassword,
          Password: formData.TwoPassword
        };
        const { Success } = await utils_http.Post("/User/ChangePassword", updatedUserInfo);
        if (Success) {
          await commonStore.Logout();
        }
      });
    };
    return (_ctx, _cache) => {
      return {
        a: common_assets._imports_0,
        b: formData.OrginPassword,
        c: common_vendor.o(($event) => formData.OrginPassword = $event.detail.value),
        d: formData.NewPassword,
        e: common_vendor.o(($event) => formData.NewPassword = $event.detail.value),
        f: formData.TwoPassword,
        g: common_vendor.o(($event) => formData.TwoPassword = $event.detail.value),
        h: common_vendor.o(createOrEdit),
        i: common_vendor.o(goBack)
      };
    };
  }
};
const MiniProgramPage = /* @__PURE__ */ common_vendor._export_sfc(_sfc_main, [["__scopeId", "data-v-76190189"]]);
wx.createPage(MiniProgramPage);
//# sourceMappingURL=../../../.sourcemap/mp-weixin/pages/Front/PasswordEdit.js.map
