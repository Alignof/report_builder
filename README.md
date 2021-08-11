# report_builder
A docker image for building report by markdown

## build
```zsh
$ docker build . -t report_builder
```

## run
```zsh
$ sudo docker run --rm --volume "$(pwd):/data" report_builder
```
