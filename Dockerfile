FROM        ubuntu:trusty
RUN         apt-get update
RUN         apt-get install -y curl openjdk-7-jre
RUN         mkdir -p /srv/nexus
RUN         curl -sSL http://download.sonatype.com/nexus/oss/nexus-2.5-bundle.tar.gz | tar -xzf- -C /srv/nexus/
ADD         src/run /srv/nexus/run
RUN         chmod +x /srv/nexus/run
ENTRYPOINT  ["/srv/nexus/run"]
