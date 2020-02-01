# Github Actions Runner Image
To build this image:

```bash
$ docker build -t actions-image .
```

To register an actions runner against your repository:

```bash
$ docker run -ti --rm actions-image ${OWNER} ${REPO} ${TOKEN} ${NAME}
```

