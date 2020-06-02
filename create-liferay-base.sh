#!/bin/bash

source ./guestbook-env.sh

cd clean-gb

cat settings.gradle

./gradlew --version


# create Guestbook Tutorial Service
blade create                        \
    -t service-builder              \
    -p com.liferay.docs.guestbook   \
    -v $TEST_BLADE_LIFERAY_VERSION  \
    guestbook

cp ../patches/step-04/service.xml ./modules/guestbook/guestbook-service/
cp -r ../patches/fix-2/modules ./

./gradlew buildService

cp -r ../patches/step-04/modules ./

./gradlew buildService


./gradlew build



