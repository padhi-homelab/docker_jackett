# docker_jackett <a href='https://github.com/padhi-homelab/docker_jackett/actions?query=workflow%3A%22Docker+CI+Release%22'><img align='right' src='https://img.shields.io/github/actions/workflow/status/padhi-homelab/docker_jackett/docker-release.yml?branch=main&logo=github&logoWidth=24&style=flat-square'></img></a>

<a href='https://hub.docker.com/r/padhihomelab/jackett'><img src='https://img.shields.io/docker/image-size/padhihomelab/jackett/latest?label=size%20%5Blatest%5D&logo=docker&logoWidth=24&style=for-the-badge'></img></a>
<a href='https://hub.docker.com/r/padhihomelab/jackett'><img src='https://img.shields.io/docker/image-size/padhihomelab/jackett/testing?label=size%20%5Btesting%5D&logo=docker&logoWidth=24&style=for-the-badge'></img></a>

A multiarch [Jackett] Docker image, based on [Debian Linux].

|           386            |       amd64        |          arm/v6          |       arm/v7       |       arm64        |         ppc64le          |          s390x           |
| :----------------------: | :----------------: | :----------------------: | :----------------: | :----------------: | :----------------------: | :----------------------: |
| :heavy_multiplication_x: | :heavy_check_mark: | :heavy_multiplication_x: | :heavy_check_mark: | :heavy_check_mark: | :heavy_multiplication_x: | :heavy_multiplication_x: |

## Usage

### With Docker

```sh
docker run -p 9117:9117 -it padhihomelab/jackett
```

Runs [Jackett] with WebUI served on port 9117.
<br>
To run it in background, use the `--detach` flag.

Typically, you shouldn't need to directly access the files written by Jackett to disk, but it is still a good idea (e.g., for easier backups) to map the persistent volume to a host directory:

```sh
docker run --detach \
           -p 9117:9117 \
           -e DOCKER_UID=`id -u` \
           -v /path/to/store/configs:/configs \
           -v /path/to/client/downloads:/downloads \
           -it padhihomelab/jackett
```

Usage with [Docker Compose] is similarly straightforward.
<br>
As an example, you can see my configuration in [services/indexarr].

[Debian Linux]:      https://debian.org/
[Docker Compose]:    https://docs.docker.com/compose/
[Jackett]:           https://github.com/Jackett/Jackett
[services/trackarr]: https://github.com/padhi-homelab/services/tree/master/indexarr
