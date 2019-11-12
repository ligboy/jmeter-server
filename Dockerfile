FROM ubuntu:18.04
MAINTAINER ligboy <ligboy@gmail.com>

ENV JMETER_VERSION 5.2
ENV RMI_PORT 1099
ENV IP 0.0.0.0
ENV JMETER_HOME /opt/jmeter

RUN apt-get -qq update && \
    apt-get -yqq install openjdk-8-jdk-headless unzip curl wget&& \
    apt-get -q clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd /tmp && wget http://ftp.cuhk.edu.hk/pub/packages/apache.org/jmeter/binaries/apache-jmeter-$JMETER_VERSION.zip \
     && unzip apache-jmeter-$JMETER_VERSION.zip && mv apache-jmeter-$JMETER_VERSION $JMETER_HOME && rm /tmp/apache-jmeter-$JMETER_VERSION.zip

RUN cd $JMETER_HOME && wget https://jmeter-plugins.org/files/packages/jpgc-casutg-2.9.zip -O jpgc-casutg-temp.zip && unzip jpgc-casutg-temp.zip && rm jpgc-casutg-temp.zip
RUN cd $JMETER_HOME && wget https://jmeter-plugins.org/files/packages/jpgc-graphs-basic-2.0.zip -O jpgc-graphs-basic-temp.zip && unzip jpgc-graphs-basic-temp.zip && rm jpgc-graphs-basic-temp.zip
RUN cd $JMETER_HOME && wget https://jmeter-plugins.org/files/packages/jpgc-perfmon-2.1.zip -O jpgc-perfmon-temp.zip && unzip jpgc-perfmon-temp.zip && rm jpgc-perfmon-temp.zip
RUN cd $JMETER_HOME && wget https://jmeter-plugins.org/files/packages/jpgc-ffw-2.0.zip -O jpgc-ffw-temp.zip && unzip jpgc-ffw-temp.zip && rm jpgc-temp.zip

RUN echo server.rmi.ssl.disable=true >> /opt/jmeter/bin/jmeter.properties

ENV PATH /opt/jmeter/bin:$PATH

EXPOSE $RMI_PORT

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]