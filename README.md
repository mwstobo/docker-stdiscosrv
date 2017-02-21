# docker-stdiscosrv
Dockerfile for the Syncthing Discovery Server

## Building
There are three build arguments: `buildhost`, `version`, and `tar_filename`. Use these to to customize where the stdiscosrv source is downloaded from. Note you should only need to touch the `version` argument.

## Usage
* Run the basic server
```shell
$ docker run -d -p 8443:8443 stdiscosrv
```

* Run the server with a persistent cert and key
```shell
$ DATA_DIR=/path/to/data/dir
$ docker run -d -v $DATA_DIR:/opt/stdiscosrv/data -p 8443:8443 stdiscosrv
$ ls $DATA_DIR
client.pem key.pem
```
