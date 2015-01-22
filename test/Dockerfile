FROM        ubuntu:trusty
RUN         apt-get update
RUN         apt-get install -y openjdk-7-jdk maven
ADD         settings.xml /root/.m2/settings.xml
ADD         hello-world /tmp/hello-world
