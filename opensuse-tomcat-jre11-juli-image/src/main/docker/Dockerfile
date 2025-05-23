#
# Copyright 2017-2025 Open Text.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# Preliminary image that downloads Tomcat and makes some modifications
#
FROM ${projectDockerRegistry}/opensuse/leap AS builder
RUN zypper -n install gzip tar xsltproc
WORKDIR /wd

ENV TOMCAT_PARENT_DIR=/wd/root/usr/share \
    TOMCAT_DIR_NAME=tomcat
ENV TOMCAT_ROOT_DIR $TOMCAT_PARENT_DIR/$TOMCAT_DIR_NAME
ENV TOMCAT_CONF_DIR $TOMCAT_ROOT_DIR/conf

# Download, extract Tomcat and remove unwanted web applications
RUN curl -fsSL -o /wd/apache-tomcat-9.0.98.tar.gz https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.98/bin/apache-tomcat-9.0.98.tar.gz && \
    echo 07d87286e8ee84bb291069c596cf36233e56a14e3ecb6d65eea0fa7c7042ce5e75f5db31f210b96b6b25b80b34e626dd26c5a6ed5c052384a8587d62658b5e16 \
        /wd/apache-tomcat-9.0.98.tar.gz | sha512sum -c - && \
    mkdir -p $TOMCAT_PARENT_DIR && \
    cd $TOMCAT_PARENT_DIR && \
    tar xzf /wd/apache-tomcat-9.0.98.tar.gz && \
    mv apache-tomcat-9.0.98 $TOMCAT_DIR_NAME && \
    cd $TOMCAT_ROOT_DIR/webapps && \
    rm -rf docs/ examples/ host-manager/ manager/

# Overwrite the main logging configuration file
# (It is being copied to the working folder first, and then overwritten using cp, in order to retain the original file's permissions.)
COPY logging.properties .
RUN cp logging.properties $TOMCAT_CONF_DIR

# Apply the specified transform to the server.xml file
COPY server.xslt .
RUN cp $TOMCAT_CONF_DIR/server.xml .
RUN xsltproc -o $TOMCAT_CONF_DIR/server.xml server.xslt server.xml

# Add in the startup scripts
COPY startup.d/ root/startup/startup.d/
RUN chmod +x root/startup/startup.d/*

#
# The actual image definition
#
FROM ${projectDockerRegistry}/cafapi/opensuse-jre11

RUN zypper -n refresh && \
    zypper -n update && \
    zypper -n clean --all

ENV CATALINA_HOME /usr/share/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
WORKDIR $CATALINA_HOME

HEALTHCHECK CMD curl --fail http://localhost:8081/healthcheck || exit 1

EXPOSE 8080 8081 8443
CMD ["catalina.sh", "run"]

COPY --from=builder /wd/root/ /
