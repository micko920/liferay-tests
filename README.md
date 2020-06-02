
# Liferay Fixes
This is the list of fixes that were applied to Liferay Version 7.3 to get it to
build the guestbook tutorial.

This has been tracked through the various minor releases from 7.3.0 to 7.3.2 ga3.

The version tracking tags are:

    TEST_LIFERAY_TARGET_VERSION     - The version string used in gradle.properties
    TEST_BLADE_LIFERAY_VERSION      - The version used to pass to the 'blade' command
    TEST_LIFERAY_BUNDLE_VERSION     - The version of the Liferay download bundle to test against

These are stored in the guestbook-env.sh file.


To run the scripts clone the git and run the guestbook-tut.sh script.
This will remove the clean-gb directory and rebuild it as though your are running
through the guestbook tutorial.


All the fixes are stored in the patches directory. These files are used to
update the source after the blade templates have been run.



## Fix 1 - gradle.properties mismatch with bundle
    TEST_LIFERAY_TARGET_VERSION     - 7.3.0
    TEST_BLADE_LIFERAY_VERSION      - 7.3
    TEST_LIFERAY_BUNDLE_VERSION     - 7.3.2-ga2

This is the default setup for the workspace generated by blade and the Liferay IDE.

As this is the default for the Liferay IDE and Blade workspace it causes a lot
of errors which others who do not use the IDE or have already overridden
the Liferay Target version will not have.

The following are the errors produced. It relates to the mismatch in version
requirements pulled in by the guestbook.exception requiring a particular
version of the liferay.portal.kernel.model.

This can at other stages of the build cause errors for cssBuilder.

### Solution
Move to Liferay target 7.3.2
This can not be done in the Liferay IDE. It is currently limited to only allow 7.3, not 7.3.X.
So this has to be changed in the gradle.properties.


    liferay.workspace.target.platform.version = 7.3.2

### Error

     2020-06-02 03:44:58.213 ERROR [fileinstall-/home-ext/michael-ext/eas-code/lrds/ws/clean-gb/bundles/osgi/modules][LogService:93] Error while starting bundle: file:/home-ext/michael-ext/eas-code/lrds/ws/clean-gb/bundles/osgi/modules/com.liferay.docs.guestbook.api.jar
    org.osgi.framework.BundleException: Could not resolve module: com.liferay.docs.guestbook.api [1147]_  Unresolved requirement: Import-Package: com.liferay.portal.kernel.model; version="[4.1.0,5.0.0)"_ [Sanitized]
            at org.eclipse.osgi.container.Module.start(Module.java:444)
            at org.eclipse.osgi.internal.framework.EquinoxBundle.start(EquinoxBundle.java:428)
            at org.apache.felix.fileinstall.internal.DirectoryWatcher.startBundle(DirectoryWatcher.java:1297)
            at org.apache.felix.fileinstall.internal.DirectoryWatcher.startBundles(DirectoryWatcher.java:1270)
            at org.apache.felix.fileinstall.internal.DirectoryWatcher.doProcess(DirectoryWatcher.java:524)
            at org.apache.felix.fileinstall.internal.DirectoryWatcher.process(DirectoryWatcher.java:369)
            at org.apache.felix.fileinstall.internal.DirectoryWatcher.run(DirectoryWatcher.java:320)
    2020-06-02 03:44:58.221 ERROR [fileinstall-/home-ext/michael-ext/eas-code/lrds/ws/clean-gb/bundles/osgi/modules][LogService:93] Error while starting bundle: file:/home-ext/michael-ext/eas-code/lrds/ws/clean-gb/bundles/osgi/modules/com.liferay.docs.guestbook.service.jar
    org.osgi.framework.BundleException: Could not resolve module: com.liferay.docs.guestbook.service [1148]_  Unresolved requirement: Import-Package: com.liferay.docs.guestbook.exception; version="[1.0.0,2.0.0)"_    -> Export-Package: com.liferay.docs.guestbook.exception; bundle-symbolic-name="com.liferay.docs.guestbook.api"; bundle-version="1.0.0"; version="1.0.0"; uses:="com.liferay.portal.kernel.exception"_       com.liferay.docs.guestbook.api [1147]_         Unresolved requirement: Import-Package: com.liferay.portal.kernel.model; version="[4.1.0,5.0.0)"_  Unresolved requirement: Import-Package: com.liferay.docs.guestbook.model; version="[1.0.0,1.1.0)"_    -> Export-Package: com.liferay.docs.guestbook.model; bundle-symbolic-name="com.liferay.docs.guestbook.api"; bundle-version="1.0.0"; version="1.0.0"; uses:="com.liferay.exportimport.kernel.lar,com.liferay.portal.kernel.annotation,com.liferay.portal.kernel.bean,com.liferay.portal.kernel.model,com.liferay.portal.kernel.model.wrapper,com.liferay.portal.kernel.util"_ [Sanitized]
            at org.eclipse.osgi.container.Module.start(Module.java:444)
            at org.eclipse.osgi.internal.framework.EquinoxBundle.start(EquinoxBundle.java:428)
            at org.apache.felix.fileinstall.internal.DirectoryWatcher.startBundle(DirectoryWatcher.java:1297)
            at org.apache.felix.fileinstall.internal.DirectoryWatcher.startBundles(DirectoryWatcher.java:1270)
            at org.apache.felix.fileinstall.internal.DirectoryWatcher.doProcess(DirectoryWatcher.java:524)
            at org.apache.felix.fileinstall.internal.DirectoryWatcher.process(DirectoryWatcher.java:369)
            at org.apache.felix.fileinstall.internal.DirectoryWatcher.run(DirectoryWatcher.java:320)



## Fix 2 - class file for com.liferay.petra.sql.dsl.query.sort.OrderByInfo not found
    TEST_LIFERAY_TARGET_VERSION     - 7.3.2
    TEST_BLADE_LIFERAY_VERSION      - 7.3
    TEST_LIFERAY_BUNDLE_VERSION     - 7.3.2-ga2

This is a compile error from GuestBookPersistenceImpl.

### Solution

Add the missing dependency to the build.gradle file in the guestbook-service.

    compileOnly group: 'com.liferay', name: "com.liferay.petra.sql.dsl.api"

### Error

    > Task :modules:guestbook:guestbook-service:compileJava FAILED
    /home-ext/michael-ext/eas-code/lrds/ws/clean-gb/modules/guestbook/guestbook-service/src/main/java/com/liferay/docs/guestbook/service/persistence/impl/GuestbookPersistenceImpl.java:75: error: cannot access Table
    public class GuestbookPersistenceImpl
           ^
      class file for com.liferay.petra.sql.dsl.Table not found
    /home-ext/michael-ext/eas-code/lrds/ws/clean-gb/modules/guestbook/guestbook-service/src/main/java/com/liferay/docs/guestbook/service/persistence/impl/GuestbookEntryPersistenceImpl.java:209: error: cannot access OrderByInfo
                                            3 + (orderByComparator.getOrderByFields().length * 2));
                                                                  ^
      class file for com.liferay.petra.sql.dsl.query.sort.OrderByInfo not found


## Fix 3 - Various missing compileOnly errors fixes
    TEST_LIFERAY_TARGET_VERSION     - 7.3.2
    TEST_BLADE_LIFERAY_VERSION      - 7.3
    TEST_LIFERAY_BUNDLE_VERSION     - 7.3.2-ga2

There seems to be some missing dependencies for the mvc-portlet in the guestbook tutorial.
The 2 main errors and solutions are list below.

### Solution

    compileOnly group: "com.liferay", name: "com.liferay.petra.lang"

### Error

    > Task :modules:guestbook:guestbook-web:generateJSPJava FAILED

    FAILURE: Build failed with an exception.

    * What went wrong:
    Execution failed for task ':modules:guestbook:guestbook-web:generateJSPJava'.
    > com/liferay/petra/lang/CentralizedThreadLocal

### Solution

    compileOnly group: 'com.liferay', name: "com.liferay.petra.sql.dsl.api"

### Error

    > Task :modules:guestbook:guestbook-web:generateJSPJava FAILED

    FAILURE: Build failed with an exception.

    * What went wrong:
    Execution failed for task ':modules:guestbook:guestbook-web:generateJSPJava'.
    > com/liferay/petra/sql/dsl/query/sort/OrderByInfo

### Solution

    compileOnly group: 'com.liferay', name: "com.liferay.petra.string"

### Error

    > Task :modules:guestbook:guestbook-web:compileJSP FAILED
    /home-ext/michael-ext/eas-code/lrds/ws/clean-gb/modules/guestbook/guestbook-web/build/jspc/org/apache/jsp/guestbook/entry_005factions_jsp.java:10: error: package com.liferay.petra.string does not exist
    import com.liferay.petra.string.StringPool;
                                   ^
    /home-ext/michael-ext/eas-code/lrds/ws/clean-gb/modules/guestbook/guestbook-web/build/jspc/org/apache/jsp/guestbook/view_jsp.java:10: error: package com.liferay.petra.string does not exist
    import com.liferay.petra.string.StringPool;
                                   ^
    /home-ext/michael-ext/eas-code/lrds/ws/clean-gb/modules/guestbook/guestbook-web/build/jspc/org/apache/jsp/guestbook/edit_005fentry_jsp.java:10: error: package com.liferay.petra.string does not exist
    import com.liferay.petra.string.StringPool;
                                   ^
    /home-ext/michael-ext/eas-code/lrds/ws/clean-gb/modules/guestbook/guestbook-web/build/jspc/org/apache/jsp/init_jsp.java:10: error: package com.liferay.petra.string does not exist
    import com.liferay.petra.string.StringPool;
                                   ^

## Notes

### Tool versions

    Liferay Developer Studio Version: 3.8.1.202004240132-ga2

    blade version 3.9.2.202004101340

    group: "com.liferay", name: "com.liferay.gradle.plugins.workspace", version: "2.2.11"
    group: "net.saliman", name: "gradle-properties-plugin", version: "1.4.6"

    ------------------------------------------------------------
    Gradle 5.6.4
    ------------------------------------------------------------

    Build time:   2019-11-01 20:42:00 UTC
    Revision:     dd870424f9bd8e195d614dc14bb140f43c22da98

    Kotlin:       1.3.41
    Groovy:       2.5.4
    Ant:          Apache Ant(TM) version 1.9.14 compiled on March 12 2019
    JVM:          11.0.2 (Oracle Corporation 11.0.2+9-Debian-3bpo91)
    OS:           Linux 4.9.0-8-amd64 amd64

    $ java --version
    openjdk 11.0.2 2019-01-15
    OpenJDK Runtime Environment (build 11.0.2+9-Debian-3bpo91)
    OpenJDK 64-Bit Server VM (build 11.0.2+9-Debian-3bpo91, mixed mode, sharing)
