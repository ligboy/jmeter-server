FROM ubuntu:18.04
MAINTAINER ligboy <ligboy@gmail.com>

ENV JMETER_VERSION 5.2
ENV RMI_PORT 1099
ENV IP 0.0.0.0

RUN apt-get -qq update && \
    apt-get -yqq install openjdk-8-jdk-headless unzip curl wget&& \
    apt-get -q clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd /tmp && wget http://ftp.cuhk.edu.hk/pub/packages/apache.org/jmeter/binaries/apache-jmeter-$JMETER_VERSION.zip \
     && unzip apache-jmeter-$JMETER_VERSION.zip && mv apache-jmeter-$JMETER_VERSION /opt/jmeter && rm /tmp/apache-jmeter-$JMETER_VERSION.zip

RUN echo server.rmi.ssl.disable=true >> /opt/jmeter/bin/jmeter.properties

ENV PATH /opt/jmeter/bin:$PATH

EXPOSE $RMI_PORT

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]