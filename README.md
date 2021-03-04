# Github Actions Runner Image
Code for the blog series [here](https://dev.to/wayofthepie/ephemeral-self-hosted-github-actions-runners-1h5m). To build this image:

```bash
$ docker build -t actions-image .
```

To register an actions runner against your repository:

```bash
$ docker run -ti --rm actions-image ${OWNER} ${REPO} ${TOKEN} ${NAME}
```

