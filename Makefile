#!/usr/bin/env make -f

DOCKER := docker
TAG := snaekobbi/nexus-service

all : image

.PHONY: image check

image : Dockerfile
	$(DOCKER) build -t $(TAG) .

check : image test/Dockerfile
	rm -rf test/sonatype-work test/logs
	$(DOCKER) run -d \
	              -e 8081 \
	              -v $(CURDIR)/test/logs:/srv/nexus/nexus-2.5.0-04/logs \
	              -v $(CURDIR)/test/sonatype-work:/srv/nexus/sonatype-work \
	              --name nexus \
	              $(TAG)	
	sleep 10
	id=$$(uuidgen|tr A-Z a-z) && \
	    $(DOCKER) build -t $${id} test && \
	    $(DOCKER) run -v $(CURDIR)/test/repository:/root/.m2/repository \
	                  --rm \
	                  --link nexus:nexus \
	                  $${id} \
	                  /bin/bash -c "mvn deploy -f /tmp/hello-world/pom.xml"
	$(DOCKER) stop nexus
	$(DOCKER) rm nexus
	test -d test/sonatype-work/nexus/storage/snapshots/org/example/hello-world/1.0.0-SNAPSHOT
