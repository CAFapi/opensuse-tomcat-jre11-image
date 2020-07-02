#### Version Number
${version-number}

#### New Features

- **SCMOD-8516**: Extend the security hardening of Java base images by disabling TLS algorithms mentioned [here](https://github.com/CAFapi/opensuse-java11-images/blob/develop/src/main/docker/disableWeakTlsAlgorithms.patch)
- **SCMOD-9768**: Updated Tomcat to version 9.0.35

#### Known Issues
- None

#### Breaking Changes

- **SCMOD-8516**: Extend the security hardening of Java base images by disabling TLS algorithms mentioned [here](https://github.com/CAFapi/opensuse-java11-images/blob/develop/src/main/docker/disableWeakTlsAlgorithms.patch)
- **SCMOD-7700**:  Stops the docker container if the execution of any of the startup scripts fail instead of ignoring it.
