CAS Services Management Overlay
============================

Services management web application Maven overlay for CAS with externalized configuration.


# Versions

```xml
<cas.version>5.2.x</cas.version>
```

# Requirements

* JDK 1.8+

# Build

To see what commands are available to the build script, run:

```bash
./build.sh help
```

To package the final web application, run:

```bash
./build.sh package
```

To update `SNAPSHOT` versions run:

```bash
./build.sh package -U
```

## Windows Build
On Windows you can run build.cmd instead of build.sh. The usage may differ from build.sh, run "build.cmd help" for usage.

## Note

If you are running the management web application on the same machine as the CAS server web application itself, 
you will need to evaluate the build script and make sure the configuration files don't override each other.

## Configuration (`management.properties`)
Note: You **MUST** keep in mind that both applications (the CAS server and the services management webapp) share the **same** service registry configuration for CAS services. The persistence storage for services MUST be the same as that of the CAS server.

````
# server.contextPath=/cas-management

# cas.mgmt.adminRoles[0]=ROLE_ADMIN
# cas.mgmt.adminRoles[1]=ROLE_SUPER_USER

# cas.mgmt.userPropertiesFile=classpath:/user-details.properties
# cas.mgmt.serverName=https://localhost:8443
# cas.mgmt.defaultLocale=en

# cas.mgmt.authzAttributes[0]=memberOf
# cas.mgmt.authzAttributes[1]=groupMembership
````

# Deployment

## Embedded Tomcat

CAS will be available at:

* `http://cas.server.name:8080/cas-management`
* `https://cas.server.name:8443/cas-management`

## External

Deploy resultant `target/cas-management.war`  to a servlet container of choice.
