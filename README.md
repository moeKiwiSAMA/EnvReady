# EnvReady

This image contains common utils I use everyday.

## Start

### Cli Only

```bash
docker run -it -w /root moekiwisama/envready:latest
```


### With Xserver

```bash
docker run --rm -it -w /root --net=host -e DISPLAY -v $HOME/.Xauthority:/root/.Xauthority moekiwisama/envready:latest
```
