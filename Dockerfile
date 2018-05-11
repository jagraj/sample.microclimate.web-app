FROM websphere-liberty:webProfile7
COPY /src/main/liberty/config/server.xml /opt/ibm/wlp/usr/servers/defaultServer/server.xml
COPY /target/liberty/wlp/usr/servers/defaultServer /config/
COPY /src/main/liberty/config/jvmbx.options /config/jvm.options
RUN installUtility install --acceptLicense defaultServer
#checks if the sample app is being built on power architecture, pulls a pre-built .war file if so due to missing modules on PPC
RUN if (uname -a | grep -i "PPC\|power"); then wget https://github.com/WASdev/sample.microservicebuilder.web-app/releases/download/1.0/web-application-1.0.0-SNAPSHOT.war -O /opt/ibm/wlp/usr/servers/defaultServer/apps/web-application-1.0.0-SNAPSHOT.war; fi
COPY target /opt/ibm/wlp/usr/servers/defaultServer/apps/
RUN mv /opt/ibm/wlp/usr/servers/defaultServer/apps/conferencewebapp-1.0.0-SNAPSHOT.war /opt/ibm/wlp/usr/servers/defaultServer/apps/web-app.war
RUN installUtility install --acceptLicense defaultServer && installUtility install --acceptLicense apmDataCollector-7.4
RUN /opt/ibm/wlp/usr/extension/liberty_dc/bin/config_liberty_dc.sh -silent /opt/ibm/wlp/usr/extension/liberty_dc/bin/silent_config_liberty_dc.txt
