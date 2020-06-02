#!/bin/bash

source ./guestbook-env.sh

cd clean-gb

cat settings.gradle

./gradlew --version


rm ./modules/guestbook/guestbook-web/src/main/resources/META-INF/resources/view.jsp
cp -r ../patches/step-04-webfrontend/modules ./


./gradlew build buildCSS compileJSP

cp -r ../patches/fix-3/build.gradle ./modules/guestbook/guestbook-web

./gradlew build buildCSS compileJSP

blade deploy



