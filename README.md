# EnvReady

This image contains common utils I use everyday.

## Start

### Cli Only

```bash
docker run -it moekiwisama/envready:latest
```


### With Xserver

```bash
docker run --rm -it --net=host -e DISPLAY -v $HOME/.Xauthority:/root/.Xauthority moekiwisama/envready:latest
```
