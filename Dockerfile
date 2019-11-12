FROM ubuntu:18.04
MAINTAINER ligboy <ligboy@gmail.com>

ENV JMETER_VERSION 5.2
ENV RMI_PORT 1099

RUN apt-get -qq update && \
    apt-get -yqq install openjdk-7-jre-headless unzip curl wget&& \
    apt-get -q clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd /tmp && wget http://ftp.cuhk.edu.hk/pub/packages/apache.org/jmeter/binaries/apache-jmeter-$JMETER_VERSION.zip \
     && unzip apache-jmeter-$JMETER_VERSION.zip && mv apache-jmeter-$JMETER_VERSION /opt/jmeter && rm /tmp/apache-jmeter-$JMETER_VERSION.zip

ENV PATH $JMETER_HOME/bin:$PATH

EXPOSE $RMI_PORT

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]