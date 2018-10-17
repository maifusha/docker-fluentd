> Docker image for Fluentd with UI

#### Badages
```
[![build status](https://git.yoursite.com/docker/fluentd/badges/master/build.svg)](https://git.yoursite.com/docker/fluentd/commits/master)
```

#### Quick Start
* start the service
```bash
    docker run -d -p 9292:9292 -e FLUENTD_UI_PORT=9292 git.yoursite.com:5005/docker/fluentd:latest
```
* install basic plugins over ui `fluent-plugin-elasticsearch、fluent-plugin-record-modifier、fluent-plugin-rewrite-tag-filter` and some other plugins as you need
* set the configration over ui, example:
```
<source>
  @type http
  port 9880
  format default
</source>

<match **.**>
  @type stdout
</match>
```

#### Note
* The fluentd-ui initial account is admin:changeme, you can change it in dashboad

