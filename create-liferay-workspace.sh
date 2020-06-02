#!/bin/bash

source ./guestbook-env.sh

blade init -v $TEST_BLADE_LIFERAY_VERSION clean-gb

cd clean-gb

sed \
   -e "s#{{TEST_LIFERAY_BUNDLE}}#$TEST_LIFERAY_BUNDLE#g" \
   -e "s/{{TEST_LIFERAY_TARGET_VERSION}}/$TEST_LIFERAY_TARGET_VERSION/g" \
   -e "s/{{TEST_LIFERAY_BUNDLE_VERSION}}/$TEST_LIFERAY_BUNDLE_VERSION/g" \
   ../patches/gradle.properties-template \
   > ./gradle.properties

cat settings.gradle

./gradlew --version

./gradlew initBundle


# create Guestbook Tutorial Service
blade create -t service-builder -p com.liferay.docs.guestbook -v $TEST_BLADE_LIFERAY_VERSION guestbook

cp ../patches/step-04/service.xml ./modules/guestbook/guestbook-service/
cp -r ../patches/fix-2/modules ./

./gradlew buildService

cp -r ../patches/step-04/modules ./

./gradlew buildService


./gradlew build



