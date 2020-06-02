#!/bin/bash

cd clean-gb


blade server start &


sleep 10
tail -f bundles/tomcat-9.0.33/logs/catalina.out &

sleep 20
blade deploy
