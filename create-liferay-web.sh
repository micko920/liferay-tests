#!/bin/bash

source ./guestbook-env.sh

cd clean-gb

cat settings.gradle

./gradlew --version


# create Guestbook Web
blade create -t mvc-portlet  			     		\
             -p com.liferay.docs.guestbook          \
			 -c Guestbook 							\
			 -v $TEST_BLADE_LIFERAY_VERSION 		\
			 -d modules/guestbook 					\
			 guestbook-web


./gradlew build buildCSS compileJSP


blade deploy



