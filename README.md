# docker_jackett <a href='https://github.com/padhi-homelab/docker_jackett/actions?query=workflow%3A%22Docker+CI+Release%22'><img align='right' src='https://img.shields.io/github/workflow/status/padhi-homelab/docker_jackett/Docker%20CI%20Release?logo=github&logoWidth=24&style=flat-square'></img></a>

<a href='https://microbadger.com/images/padhihomelab/jackett'><img src='https://img.shields.io/microbadger/layers/padhihomelab/jackett/latest?logo=docker&logoWidth=24&style=for-the-badge'></img></a>
<a href='https://hub.docker.com/r/padhihomelab/jackett'><img src='https://img.shields.io/docker/image-size/padhihomelab/jackett/latest?label=size%20%5Blatest%5D&logo=docker&logoWidth=24&style=for-the-badge'></img></a>

A multiarch [Jackett] Docker image, based on [Debian Linux].

|        386         |       amd64        |       arm/v6       |       arm/v7       |       arm64        |      ppc64le       |          s390x           |
| :----------------: | :----------------: | :----------------: | :----------------: | :----------------: | :----------------: | :----------------------: |
| :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_multiplication_x: |

## Usage

```
docker run --detach \
           -p 9117:9117 \
           -e DOCKER_UID=`id -u` \
           -v /path/to/store/configs:/configs \
           -v /path/to/client/downloads:/downloads \
           -it padhihomelab/jackett
```

Runs `Jackett` with WebUI served on port 9117.

_<More details to be added soon>_


[Debian Linux]: https://debian.org/
[Jackett]:      https://github.com/Jackett/Jackett
