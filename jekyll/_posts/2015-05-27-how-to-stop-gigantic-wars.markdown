---
layout: post
title:  How to stop gigantic Tomcat WARs
date:   2015-05-27 16:34:11
author: Johannes Ernst
categories: none
# hot
---

Let's assume that `my-cool-app` is the name of your maven project/artifact that
builds the WAR. It is actually quite simple.

**Step 1:** Don't build gigantic WARs. To stop, add this to `my-cool-app`'s maven `pom.xml`:

<pre>
&lt;build>
    &lt;plugins>
        &lt;plugin>
            &lt;groupId>org.apache.maven.plugins&lt;/groupId>
            &lt;artifactId>maven-war-plugin&lt;/artifactId>
            &lt;version>2.6&lt;/version>
            &lt;configuration>
                &lt;packagingExcludes>WEB-INF/lib/*.jar&lt;/packagingExcludes>
            &lt;/configuration>
        &lt;/plugin>
    &lt;/plugins>
&lt;/build>
</pre>

**Step 2:** Make sure the JARs of the modules are in a place where diet4j can find them.
By default, diet4j looks in maven's `.m2` directory in your home directory, but you can
override that with the `moduledirectory` parameter (see below). You may want to do that
on production machines. `/usr/lib/java` might be a good place.

**Step 3:** Make sure Tomcat can use diet4j. Copy
`diet4j-tomcat.jar` to Tomcat's `lib` directory and restart Tomcat.

**Step 4:** Tell Tomcat to use the diet4j ClassLoader for your app. (Tomcat will keep
running all other apps on the server as it has done before.)

Add the `<Loader..>` line to your app's `context.xml`:

<pre>
&lt;Context path="/your-app">
  &lt;Loader className="org.diet4j.tomcat.TomcatWebAppClassLoader"
          rootmodule="my-cool-app"/>
&lt;/Context>
</pre>

If you like to put your JARs somewhere else, such as `/home/diet4j/jars`, that line
needs to read:
<pre>
  &lt;Loader className="org.diet4j.tomcat.TomcatWebAppClassLoader"
          moduledirectory="/home/diet4j/jars"
          rootmodule="my-cool-app"/>
</pre>
