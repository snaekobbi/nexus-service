FROM        ubuntu:trusty
RUN         apt-get update
RUN         apt-get install -y curl openjdk-7-jre
RUN         mkdir -p /srv/nexus
RUN         curl -sSL http://download.sonatype.com/nexus/oss/nexus-2.5-bundle.tar.gz | tar -xzf- -C /srv/nexus/
ENTRYPOINT  ["/bin/bash", "-c", "RUN_AS_USER=root /srv/nexus/nexus-2.5.0-04/bin/nexus start && tail -f /srv/nexus/nexus-2.5.0-04/logs/wrapper.log"]
