FROM ubuntu

RUN useradd -m actions \
    && apt-get update \
    && apt-get install -y \
    curl \
    jq \
    uuid-runtime 

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.17.0/bin/linux/amd64/kubectl \
    && mv kubectl /usr/local/bin \
    && chmod +x /usr/local/bin/kubectl

WORKDIR /home/actions

ADD job.yaml .

USER actions

COPY orc.sh .
ENTRYPOINT ["./orc.sh"]
