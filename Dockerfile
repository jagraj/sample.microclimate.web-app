FROM websphere-liberty:webProfile7
COPY src/main/liberty/config/server.xml /opt/ibm/wlp/usr/servers/defaultServer/server.xml
RUN installUtility install --acceptLicense defaultServer
#checks if the sample app is being built on power architecture, pulls a pre-built .war file if so due to missing modules on PPC
RUN if (uname -a | grep -i "PPC\|power"); then wget https://github.com/WASdev/sample.microservicebuilder.web-app/releases/download/1.0/web-application-1.0.0-SNAPSHOT.war -O /opt/ibm/wlp/usr/servers/defaultServer/apps/web-application-1.0.0-SNAPSHOT.war; fi
COPY target /opt/ibm/wlp/usr/servers/defaultServer/apps/
RUN mv /opt/ibm/wlp/usr/servers/defaultServer/apps/conferencewebapp-1.0.0-SNAPSHOT.war /opt/ibm/wlp/usr/servers/defaultServer/apps/web-app.war
