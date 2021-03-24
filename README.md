# signals

Experiment with container signal handling.

## Overview

This repository illustrates some nuances of a Docker entrypoint. The main problem it illustrates is a scenario where a Bash startup script blocks signals from reaaching the `app.py` Python application.

## Example 1

You can see in example 1 the `entrypoint.sh` script does not use the `exec`  builtin comand so `bash` is the first process. Docker does forward the signals to the `bash` process; however, `bash` doesn't forward the signals on to the `python` process. When we try to stop the container, the `SIGTERM` signal never makes it to the `python` process. Docker eventually forcefully kills the container.

```
$ docker build -t signals -f docker/Dockerfile.ex1 .
$ docker run -it --rm --name signals signals
pid 8
args []
$

$ docker exec signals ps -ef --forest
UID        PID  PPID  C STIME TTY          TIME CMD
root         9     0  0 17:26 ?        00:00:00 ps -ef --forest
root         1     0  0 17:26 pts/0    00:00:00 /bin/bash /app/entrypoint.sh
root         8     1  1 17:26 pts/0    00:00:00 python3 -u app.py
$ docker kill -s SIGUSR2 signals
signals
$ docker kill -s SIGUSR1 signals
signals
$ docker stop signals
signals
$
```

## Example 2

You can see in example 2 the `entrypoint2.sh` script does use the `exec`  builtin comand so `python` is the first process. Docker does forward the signals to the `python` process which handles them using Python signal handlers. When we try to stop the container, the `SIGTERM` signal does make it to the `python` process and the contianer cleanly shuts down.

```
$ docker build -t signals -f docker/Dockerfile.ex2 .
$ docker run -it --rm --name signals signals
pid 1
args []
received signal 10
received signal 12
received signal 15
exiting
$


$ docker exec signals ps -ef --forest
UID        PID  PPID  C STIME TTY          TIME CMD
root         8     0  0 17:29 ?        00:00:00 ps -ef --forest
root         1     0  1 17:29 pts/0    00:00:00 python3 -u app.py
$ docker kill -s SIGUSR1 signals
signals
$ docker kill -s SIGUSR2 signals
signals
$ docker stop signals
signals
$
```

## Research


* https://hynek.me/articles/docker-signals/
* https://aws.amazon.com/blogs/opensource/demystifying-entrypoint-cmd-docker/
* https://docs.docker.com/engine/reference/builder/#entrypoint
