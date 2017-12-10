FROM ubuntu:14.04
MAINTAINER kurtis velarde, "kurtis@kurtisvelarde.com"

# General
RUN echo deb http://archive.ubuntu.com/ubuntu precise universe >> /etc/apt/sources.list
RUN apt-get update && apt-get clean
RUN apt-get install -q -y wget unzip git

# JDK
RUN apt-get install -q -y openjdk-7-jdk && apt-get clean
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

# Gradle
ADD https://services.gradle.org/distributions/gradle-2.2.1-bin.zip /opt/gradle-2.2.1-bin.zip
RUN unzip /opt/gradle-2.2.1-bin.zip -d /opt/
ENV GRADLE_HOME /opt/gradle-2.2.1
ENV PATH $PATH:$GRADLE_HOME/bin

# SBT
RUN wget https://dl.bintray.com/sbt/debian/sbt-0.13.6.deb && \
    dpkg -i sbt-0.13.6.deb && \
    rm sbt-0.13.6.deb

# Jenkins
ADD http://mirrors.jenkins-ci.org/war/latest/jenkins.war /opt/jenkins.war
RUN ln -sf /jenkins /root/.jenkins


ENTRYPOINT ["java", "-jar", "/opt/jenkins.war"]
EXPOSE 8080
VOLUME ["/jenkins"]
CMD [""]
