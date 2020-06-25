# Fluentd Boilerplate
Docker -> Fluentd -> System File

## Resources
[Configuration](https://docs.fluentd.org/configuration/config-file)
[Plugins](https://www.fluentd.org/plugins)

# Run
```
make image
docker run -it -p 24224:24224 custom-fluentd-1.11:latest
```  
# Local Development
- Install Ruby > 2.1
- Bundler
    - `gem install bundler`
    - `bundle install`
- Run Fluentd
    - `fluentd -c <config_file>(conf/fluent.conf) -p <plugin_directory> -vv`

# Test payloads
```
echo '{"event":{"hostname":"macOS","level":30,"msg":"This is a test","stream":"stdout"}, "payload":"{\"hello\": \"world\"}"}' | fluent-cat docker.test
```
Causes ArgumentError due to missing `payment` key
```
echo '{"event":{"hostname":"macOS","level":30,"msg":"This is a test","stream":"stdout"}' | fluent-cat docker.test
```
Test anonymizer conf file
`docker run -it -p 24224:24224 -e FLUENTD_CONF=fluent-anonymizer.conf custom-fluentd-1.11:latest`