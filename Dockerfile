FROM ubuntu

ENV RUNNER_VERSION=2.164.0

RUN useradd -m actions \
    && apt-get update && apt-get install -y wget 

RUN cd /home/actions && mkdir actions-runner && cd actions-runner \
    && wget https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz 
WORKDIR /home/actions/actions-runner

RUN chown -R actions ~actions && /home/actions/actions-runner/bin/installdependencies.sh 

USER actions

# Add the script and make it the entrypoint
COPY entrypoint.sh .
ENTRYPOINT ["./entrypoint.sh"]
