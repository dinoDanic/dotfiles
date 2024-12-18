# build

```docker
docker build -t <image_name> .
```

# clear memory

### You can use the docker system prune command, which combines the cleanup of stopped containers, unused volumes, networks, and dangling images:

```docker
docker system prune
```

### For a more aggressive approach (removing all unused containers, images, networks, and volumes), use:

```docker

docker system prune -a
```
