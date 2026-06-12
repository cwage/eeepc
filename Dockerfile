FROM debian:12-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ansible \
        ca-certificates \
        make \
        openssh-client \
        python3 \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd --gid 1000 ansible \
    && useradd --uid 1000 --gid 1000 --create-home --shell /bin/bash ansible

WORKDIR /workspace
USER ansible

ENV ANSIBLE_CONFIG=/workspace/ansible/ansible.cfg
ENV HOME=/home/ansible

CMD ["ansible-playbook", "--version"]

