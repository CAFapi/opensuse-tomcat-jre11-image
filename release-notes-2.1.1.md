!not-ready-for-release!

#### Version Number
${version-number}

#### New Features

 - **SCMOD-10189** : The new caf-logging-tomcat-juli module added to support standard logging format mentioned in the [caf-logging](https://github.com/CAFapi/caf-logging#example) for access logs 

#### Breaking changes

- **SCMOD-10189** : The new caf-logging-tomcat-juli module added to support standard logging format mentioned in the [caf-logging](https://github.com/CAFapi/caf-logging#example) for access logs.
 To avoid logging related class loading problems due to JRE11 changes in tomcat, the `slf4j-api` dependency scope must be changed to `provided` in a module where healthcheck api is implemented or called. Example slf4j-api scope should be made provided in [common-ui-health](https://github.houston.softwaregrp.net/Verity/common-lib/tree/master/common-ui-health).
This healthcheck api is called from ECA UI, Data management UI, and admin UI.

#### Known Issues

- None
