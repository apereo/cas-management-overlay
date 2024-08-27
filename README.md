Apereo CAS WAR Overlay Template
=====================================

WAR Overlay Type: `cas-management-overlay`

# Versions
   
- CAS Management `7.0.0-SNAPSHOT`
- CAS Server `7.0.0`

                     
# Build

To build the project, use:

```bash
# Use --refresh-dependencies to force-update SNAPSHOT versions
./gradlew[.bat] clean build
```

To see what commands/tasks are available to the build script, run:

```bash
./gradlew[.bat] tasks
```

If you need to, on Linux/Unix systems, you can delete all the existing artifacts
(artifacts and metadata) Gradle has downloaded using:

```bash
# Only do this when absolutely necessary
rm -rf $HOME/.gradle/caches/
```

Same strategy applies to Windows too, provided you switch `$HOME` to its equivalent in the above command.

# Keystore

For the server to run successfully, you might need to create a keystore file.
This can either be done using the JDK's `keytool` utility or via the following command:

```bash
./gradlew[.bat] createKeystore
```

Use the password `changeit` for both the keystore and the key/certificate entries. 
Ensure the keystore is loaded up with keys and certificates of the server.

## Extension Modules

Extension modules may be specified under the `dependencies` block of the [Gradle build script](build.gradle):

```gradle
dependencies {
    implementation "org.apereo.cas:cas-server-some-module"
    ...
}
```

To collect the list of all project modules and dependencies in the overlay:

```bash
./gradlew[.bat] dependencies
```                                                                       

# Deployment

On a successful deployment via the following methods, the server will be available at:

* `https://localhost:8443/cas-management`



## Executable WAR

Run the server web application as an executable WAR. Note that running an executable WAR requires CAS to use an embedded container such as Apache Tomcat, Jetty, etc.

The current servlet container is specified as `-tomcat`.

```bash
java -jar build/libs/cas-management.war
```

Or via:

```bash
./gradlew[.bat] run
```

It is often an advantage to explode the generated web application and run it in unpacked mode.
One way to run an unpacked archive is by starting the appropriate launcher, as follows:

```bash
jar -xf build/libs/cas-management.war
cd build/libs
java org.springframework.boot.loader.launch.JarLauncher
```

This is slightly faster on startup (depending on the size of the WAR file) than
running from an unexploded archive. After startup, you should not expect any differences.

Debug the CAS web application as an executable WAR:

```bash
./gradlew[.bat] debug
```
       
Or via:

```bash
java -Xdebug -Xrunjdwp:transport=dt_socket,address=5000,server=y,suspend=y -jar build/libs/cas-management.war
```

Run the CAS web application as a *standalone* executable WAR:

```bash
./gradlew[.bat] clean executable
```

### CDS Support

CDS is a JVM feature that can help reduce the startup time and memory footprint of Java applications. CAS via Spring Boot
now has support for easy creation of a CDS friendly layout. This layout can be created by extracting the CAS web application file
with the help of the `tools` jarmode:

```bash
# Note:
# You must first build the web application with "executable" turned off
java -Djarmode=tools -jar build/libs/cas-management.war extract

# Perform a training run once
java -XX:ArchiveClassesAtExit=cas.jsa -Dspring.context.exit=onRefresh -jar cas-management/cas-management.war

# Run the CAS web application via CDS
java XX:SharedArchiveFile=cas.jsa -jar cas-management/cas-management.war
```

## External

Deploy the binary web application file in `build/libs` after a successful build to a servlet container of choice.

# Docker

The following strategies outline how to build and deploy CAS Docker images.

## Jib

The overlay embraces the [Jib Gradle Plugin](https://github.com/GoogleContainerTools/jib) to provide easy-to-use out-of-the-box tooling for building CAS docker images. Jib is an open-source Java containerizer from Google that lets Java developers build containers using the tools they know. It is a container image builder that handles all the steps of packaging your application into a container image. It does not require you to write a Dockerfile or have Docker installed, and it is directly integrated into the overlay.

```bash
# Running this task requires that you have Docker installed and running.
./gradlew build jibDockerBuild
```

## Dockerfile

You can also use the Docker tooling and the provided `Dockerfile` to build and run.
There are dedicated Gradle tasks available to build and push Docker images using the supplied `DockerFile`:

```bash
./gradlew build casBuildDockerImage
```

Once ready, you may also push the images:

```bash
./gradlew casPushDockerImage
```

If credentials (username+password) are required for pull and push operations, they may be specified
using system properties via `-DdockerUsername=...` and `-DdockerPassword=...`.

A `docker-compose.yml` is also provided to orchestrate the build:

```bash  
docker-compose build
```

    
## Spring Boot

You can use the Spring Boot build plugin for Gradle to create CAS container images.
The plugins create an OCI image (the same format as one created by docker build)
by using [Cloud Native Buildpacks](https://buildpacks.io/). You do not need a Dockerfile, but you do need a Docker daemon,
either locally (which is what you use when you build with docker) or remotely
through the `DOCKER_HOST` environment variable. The default builder is optimized for
Spring Boot applications such as CAS, and the image is layered efficiently.

```bash
./gradlew bootBuildImage
```

The first build might take a long time because it has to download some container
images and the JDK, but subsequent builds should be fast.


