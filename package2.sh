#!/bin/bash
function git_sparse_clone() {
branch="$1" rurl="$2" localdir="$3" && shift 3
git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
cd $localdir
git sparse-checkout init --cone
git sparse-checkout set $@
mv -n $@ ../
cd ..
rm -rf $localdir
}

function mvdir() {
mv -n `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}

git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config

git clone --depth 1 https://github.com/linkease/istore && mv -n istore/luci/* ./; rm -rf istore
git clone --depth 1 https://github.com/linkease/istore-ui && mv -n istore-ui/app-store-ui ./; rm -rf istore-ui
git clone --depth 1 https://github.com/linkease/nas-packages && mv -n nas-packages/network/services/* ./; rm -rf nas-packages
git clone --depth 1 https://github.com/linkease/nas-packages-luci && mv -n nas-packages-luci/luci/* ./; rm -rf nas-packages-luci

git_sparse_clone master "https://github.com/immortalwrt/luci" "luci" applications/luci-app-eqos \
applications/luci-app-aliddns applications/luci-app-gost applications/luci-app-iptvhelper


rm -rf ./*/.* & rm -rf ./*/LICENSE
find -type f -name '*.md' -print -exec rm -rf {} \;
find luci-theme-*/* -type f -name '*luci-theme-*' -print -exec sed -i '/set luci.main.mediaurlbase/d' {} \;
# find -type f -name Makefile -exec sed -i 's/mosdns[-_]neo/mosdns/g' {} \;

sed -i \
-e 's?\.\./\.\./\(lang\|devel\)?$(TOPDIR)/feeds/packages/\1?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
-e 's?2. Clash For OpenWRT?3. Applications?' \
*/Makefile

# sed -i 's/luci-lib-ipkg/luci-base/g' {luci-app-store,luci-app-bypass}/Makefile
# sed -i 's/"wizard"}/"system", "Statistics"}/g' luci-app-wizard/luasrc/controller/wizard.lua

bash $GITHUB_WORKSPACE/diy/create_acl_for_luci.sh -a >/dev/null 2>&1
bash $GITHUB_WORKSPACE/diy/convert_translation.sh -a >/dev/null 2>&1
rm -rf create_acl_for_luci.*

exit 0
