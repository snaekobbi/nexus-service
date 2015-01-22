# [nexus-service](https://github.com/snaekobbi/nexus-service)

Docker container running a Nexus service (Maven repository)

## Building and running the service

To build the image:

    make

To test the service:

    make check

To expose the service to the host:

    docker run -d -p 8081:8081 snaekobbi/nexus-service

To expose the service to another container:

    docker run -d -e 8081 --name nexus snaekobbi/nexus-service
    docker run --link nexus:nexus <some-other-image>

## Using the service

For deploying to the repository, add the following to your `distributionManagement` section:

```xml
<snapshotRepository>
  <id>daisy-nexus-snapshots</id>
  <name>DAISY Nexus Snapshots</name>
  <url>http://localhost:8081/nexus/content/repositories/snapshots/</url>
</snapshotRepository>
```

and add the following to your `servers` section in `~/.m2/settings.xml`:

```xml
<server>
  <id>daisy-nexus-snapshots</id>
  <username>deployment</username>
  <password>deployment123</password>
</server>
```

For downloading from the repository, add the following to your `repositories` section:

```xml
<repository>
  <id>daisy-nexus-snapshots</id>
  <name>DAISY Nexus Snapshots</name>
  <url>http://localhost:8081/nexus/content/repositories/snapshots/</url>
  <releases>
    <enabled>false</enabled>
  </releases>
  <snapshots>
    <enabled>true</enabled>
  </snapshots>
</repository>
```

Nexus can be configured through the web interface:
http://localhost:8081/nexus. The login is `admin` and the password is
`admin123`.
