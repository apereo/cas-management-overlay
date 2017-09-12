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

### LDAP Authorization
````
# cas.mgmt.ldap.ldapAuthz.groupAttribute=
# cas.mgmt.ldap.ldapAuthz.groupPrefix=
# cas.mgmt.ldap.ldapAuthz.groupFilter=
# cas.mgmt.ldap.ldapAuthz.groupBaseDn=
# cas.mgmt.ldap.ldapAuthz.rolePrefix=ROLE_
# cas.mgmt.ldap.ldapAuthz.roleAttribute=uugid
# cas.mgmt.ldap.ldapAuthz.searchFilter=cn={user}
# cas.mgmt.ldap.ldapAuthz.baseDn=

# cas.mgmt.ldap.allowMultipleResults=false
# cas.mgmt.ldap.baseDn=dc=example,dc=org
# cas.mgmt.ldap.ldapUrl=ldaps://ldap1.example.edu ldaps://ldap2.example.edu
# cas.mgmt.ldap.connectionStrategy=
# cas.mgmt.ldap.baseDn=dc=example,dc=org
# cas.mgmt.ldap.userFilter=cn={user}
# cas.mgmt.ldap.bindDn=cn=Directory Manager,dc=example,dc=org
# cas.mgmt.ldap.bindCredential=Password
# cas.mgmt.ldap.providerClass=org.ldaptive.provider.unboundid.UnboundIDProvider
# cas.mgmt.ldap.connectTimeout=5000
# cas.mgmt.ldap.trustCertificates=
# cas.mgmt.ldap.keystore=
# cas.mgmt.ldap.keystorePassword=
# cas.mgmt.ldap.keystoreType=JKS|JCEKS|PKCS12
# cas.mgmt.ldap.poolPassivator=NONE|CLOSE|BIND
# cas.mgmt.ldap.minPoolSize=3
# cas.mgmt.ldap.maxPoolSize=10
# cas.mgmt.ldap.validateOnCheckout=true
# cas.mgmt.ldap.validatePeriodically=true
# cas.mgmt.ldap.validatePeriod=600
# cas.mgmt.ldap.validateTimeout=5000
# cas.mgmt.ldap.failFast=true
# cas.mgmt.ldap.idleTime=500
# cas.mgmt.ldap.prunePeriod=600
# cas.mgmt.ldap.blockWaitTime=5000
# cas.mgmt.ldap.subtreeSearch=true
# cas.mgmt.ldap.useSsl=true
# cas.mgmt.ldap.useStartTls=false
````

# Deployment

## Embedded Tomcat

CAS will be available at:

* `http://cas.server.name:8080/cas-management`
* `https://cas.server.name:8443/cas-management`

## External

Deploy resultant `target/cas-management.war`  to a servlet container of choice.
