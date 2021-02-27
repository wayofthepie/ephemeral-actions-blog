# Github Actions Runner Image
Code for the blog series [here](https://wayofthepie.github.io/series/tdd-and-rust-a-cli-for-decoding-certs/). To build this image:

```bash
$ docker build -t actions-image .
```

To register an actions runner against your repository:

```bash
$ docker run -ti --rm actions-image ${OWNER} ${REPO} ${TOKEN} ${NAME}
```

