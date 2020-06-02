
TEST_LIFERAY_TARGET_VERSION=7.3.2
TEST_BLADE_LIFERAY_VERSION=7.3
TEST_LIFERAY_BUNDLE_VERSION=7.3.2-ga3
#TEST_LIFERAY_BUNDLE_VERSION=7.3.1-ga2


if [[ $TEST_LIFERAY_BUNDLE_VERSION == '7.3.2-ga3' ]]; then
  TEST_LIFERAY_BUNDLE=https://releases-cdn.liferay.com/portal/7.3.2-ga3/liferay-ce-portal-tomcat-7.3.2-ga3-20200519164024819.tar.gz
elif [[ $TEST_LIFERAY_BUNDLE_VERSION == '7.3.1-ga2' ]]; then
  TEST_LIFERAY_BUNDLE=https://releases-cdn.liferay.com/portal/7.3.1-ga2/liferay-ce-portal-tomcat-7.3.1-ga2-20200327090859603.tar.gz
else
  # default to 7.3.1 ga2
  TEST_LIFERAY_BUNDLE=https://releases-cdn.liferay.com/portal/7.3.1-ga2/liferay-ce-portal-tomcat-7.3.1-ga2-20200327090859603.tar.gz
fi

echo TEST_LIFERAY_TARGET_VERSION=$TEST_LIFERAY_TARGET_VERSION
echo TEST_LIFERAY_BUNDLE_VERSION=$TEST_LIFERAY_BUNDLE_VERSION
blade version





