Notes from the Docker workshop

## Dockerfile

```
docker build -t lunch .
```


```
docker run  -d --name web   lunch:v0.2
```

start webserver detached, "jump in"
``` 
docker run -d --name web lunch:v0.3
docker exec -it   web curl localhost
```

## Expose to localhost

```
docker run -d --name web -p 8088:80  lunch:v0.3
```

expose to random free port
```
docker run -d --name web -p 80  lunch:v0.3
```

### lazy

```
docker build -t lunch:v1 https://github.com/lalyos/docker-nova.git
```

```
docker run -d  \
  -p 80 \
  -e TITLE="Lunchtime for lalyos" \
  -e COLOR=hotpink \
  lunch:v1
```

## BODY env var

```
docker run -d \
  -p 80 \
  -e TITLE=Tuesday \
  -e COLOR=cyan \
  -e BODY='<div class="tenor-gif-embed" data-postid="13233624726346414257" data-share-method="host" data-aspect-ratio="1" data-width="300px"><a href="https://tenor.com/view/coffee-time-coffee-coffee-break-morning-coffee-cafe-gif-13233624726346414257">Coffee Time Coffee Break GIF</a>from <a href="https://tenor.com/search/coffee+time-gifs">Coffee Time GIFs</a></div> <script type="text/javascript" async src="https://tenor.com/embed.js"></script>' \
  lunch:v1.1
```

## Image repos

```
docker build -t ttl.sh/$USER/lunch:v1.1 .
docker push ttl.sh/$USER/lunch:v1.1
```

## Multi arch image build

```
docker buildx build \
  --push \
  --platform linux/arm64/v8,linux/amd64 \
  --tag ttl.sh/$USER/lunch:v1.1 \
  .
```


## Non-root containers

todo for lalyos....


## Volume


```
docker run -d \
  --name db \
  -e POSTGRES_PASSWORD=s3cr3t \
  postgres:17

# inside
psql -U postgres postgres
## inside psql cli 
create table ...

# outside
alias vip="docker exec -it db psql -U postgres postgres -c 'SELECT * from vip'"
```

kill all containers, but still
```
docker run -d --rm  \
  --name db \
  -e POSTGRES_PASSWORD=s3cr3t \
  -v vipdb:/var/lib/postgresql/data \
  postgres:17
```

## postgress from scratch

steel from here: https://github.com/lalyos/docker-nova/blob/master/sql/init.sql

```
docker run -d  \
  --name db \
  -e POSTGRES_PASSWORD=s3cr3t \
  -v $PWD/sql:/docker-entrypoint-initdb.d \
  -v vipdb:/var/lib/postgresql/data \
  postgres:17
```

## Vip project (db + frontend)


```
docker build \
  -t vip \
  --file Dockerfile.vip  \
  https://github.com/lalyos/docker-nova.git

docker run -d \
  --name vip \
  -p 80 \
  vip

```


# Networks

## Links

an `/etc/hosts` entry will pount to the actual IP of the container `db`.
```
docker run -d \
  --name vip \
  --link db:db \
  -p 80 \
  vip
```

## Custom Networks

```
docker network create blue

docker run -d  \
  --name db \
  --net blue \
  -e POSTGRES_PASSWORD=s3cr3t \
  -v $PWD/sql:/docker-entrypoint-initdb.d \
  -v vipdb:/var/lib/postgresql/data \
  postgres:17

docker run -d \
  --name vip \
  --net blue \
  -p 80 \
  vip
```









## Troubleshoot

If you local image doesn't work, you can build directly from a git repo:

```
docker build -t lunch:v1.1 https://github.com/lalyos/docker-nova.git
```

