#!/bin/bash


rm -rf clean-gb

./create-liferay-workspace.sh

./create-liferay-base.sh

./create-liferay-web.sh

./create-liferay-web-ui.sh

