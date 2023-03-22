FROM ubuntu:22.04@sha256:a8fe6fd30333dc60fc5306982a7c51385c2091af1e0ee887166b40a905691fd0

ARG KUBECTL_VERSION=1.22.15
ARG GITHUB_RUNNER_VERSION=2.298.2
ARG GITHUB_RUNNER_VERSION_SHA="0bfd792196ce0ec6f1c65d2a9ad00215b2926ef2c416b8d97615265194477117"

RUN apt-get update && apt-get install -y \
    curl=7.81.0-1ubuntu1.10 \
    lzip=1.23-1 \
    unzip=6.0-26ubuntu3.1 \
    jq=1.6-2.1ubuntu3 \
    ca-certificates=20211016ubuntu0.22.04.1 \
    wget=1.21.2-2ubuntu1 \
    apt-transport-https=2.4.8 \
    lsb-release=11.1.0ubuntu4 \
    gnupg=2.2.27-3ubuntu2.1 \
    git=1:2.34.1-1ubuntu1.8

# GitHub Runner installation
RUN mkdir actions-runner
WORKDIR /actions-runner

RUN curl -o actions-runner-linux-x64-${GITHUB_RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${GITHUB_RUNNER_VERSION}/actions-runner-linux-x64-${GITHUB_RUNNER_VERSION}.tar.gz && \
    echo "${GITHUB_RUNNER_VERSION_SHA}  actions-runner-linux-x64-${GITHUB_RUNNER_VERSION}.tar.gz" | sha256sum -c && \
    tar xzf ./actions-runner-linux-x64-${GITHUB_RUNNER_VERSION}.tar.gz && \
    rm actions-runner-linux-x64-${GITHUB_RUNNER_VERSION}.tar.gz

RUN	bash bin/installdependencies.sh

# AWS CLI Installation
WORKDIR /tmp

RUN echo -n > awscli-pgp "-----BEGIN PGP PUBLIC KEY BLOCK-----\n\
\n\
mQINBF2Cr7UBEADJZHcgusOJl7ENSyumXh85z0TRV0xJorM2B/JL0kHOyigQluUG\n\
ZMLhENaG0bYatdrKP+3H91lvK050pXwnO/R7fB/FSTouki4ciIx5OuLlnJZIxSzx\n\
PqGl0mkxImLNbGWoi6Lto0LYxqHN2iQtzlwTVmq9733zd3XfcXrZ3+LblHAgEt5G\n\
TfNxEKJ8soPLyWmwDH6HWCnjZ/aIQRBTIQ05uVeEoYxSh6wOai7ss/KveoSNBbYz\n\
gbdzoqI2Y8cgH2nbfgp3DSasaLZEdCSsIsK1u05CinE7k2qZ7KgKAUIcT/cR/grk\n\
C6VwsnDU0OUCideXcQ8WeHutqvgZH1JgKDbznoIzeQHJD238GEu+eKhRHcz8/jeG\n\
94zkcgJOz3KbZGYMiTh277Fvj9zzvZsbMBCedV1BTg3TqgvdX4bdkhf5cH+7NtWO\n\
lrFj6UwAsGukBTAOxC0l/dnSmZhJ7Z1KmEWilro/gOrjtOxqRQutlIqG22TaqoPG\n\
fYVN+en3Zwbt97kcgZDwqbuykNt64oZWc4XKCa3mprEGC3IbJTBFqglXmZ7l9ywG\n\
EEUJYOlb2XrSuPWml39beWdKM8kzr1OjnlOm6+lpTRCBfo0wa9F8YZRhHPAkwKkX\n\
XDeOGpWRj4ohOx0d2GWkyV5xyN14p2tQOCdOODmz80yUTgRpPVQUtOEhXQARAQAB\n\
tCFBV1MgQ0xJIFRlYW0gPGF3cy1jbGlAYW1hem9uLmNvbT6JAlQEEwEIAD4WIQT7\n\
Xbd/1cEYuAURraimMQrMRnJHXAUCXYKvtQIbAwUJB4TOAAULCQgHAgYVCgkICwIE\n\
FgIDAQIeAQIXgAAKCRCmMQrMRnJHXJIXEAChLUIkg80uPUkGjE3jejvQSA1aWuAM\n\
yzy6fdpdlRUz6M6nmsUhOExjVIvibEJpzK5mhuSZ4lb0vJ2ZUPgCv4zs2nBd7BGJ\n\
MxKiWgBReGvTdqZ0SzyYH4PYCJSE732x/Fw9hfnh1dMTXNcrQXzwOmmFNNegG0Ox\n\
au+VnpcR5Kz3smiTrIwZbRudo1ijhCYPQ7t5CMp9kjC6bObvy1hSIg2xNbMAN/Do\n\
ikebAl36uA6Y/Uczjj3GxZW4ZWeFirMidKbtqvUz2y0UFszobjiBSqZZHCreC34B\n\
hw9bFNpuWC/0SrXgohdsc6vK50pDGdV5kM2qo9tMQ/izsAwTh/d/GzZv8H4lV9eO\n\
tEis+EpR497PaxKKh9tJf0N6Q1YLRHof5xePZtOIlS3gfvsH5hXA3HJ9yIxb8T0H\n\
QYmVr3aIUes20i6meI3fuV36VFupwfrTKaL7VXnsrK2fq5cRvyJLNzXucg0WAjPF\n\
RrAGLzY7nP1xeg1a0aeP+pdsqjqlPJom8OCWc1+6DWbg0jsC74WoesAqgBItODMB\n\
rsal1y/q+bPzpsnWjzHV8+1/EtZmSc8ZUGSJOPkfC7hObnfkl18h+1QtKTjZme4d\n\
H17gsBJr+opwJw/Zio2LMjQBOqlm3K1A4zFTh7wBC7He6KPQea1p2XAMgtvATtNe\n\
YLZATHZKTJyiqA==\n\
=vYOk\n\
-----END PGP PUBLIC KEY BLOCK--- --"

RUN gpg --import awscli-pgp && \
    curl -o awscliv2.zip "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" && \ 
    curl -o awscliv2.sig "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip.sig" && \
    gpg --verify awscliv2.sig awscliv2.zip && \
    unzip -q awscliv2.zip && ./aws/install && \
    rm -rf "aws*"

# Kubectl Installation
RUN curl -LO https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl
RUN curl -LO https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl.sha256
RUN echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
RUN mv kubectl /usr/local/bin/ && chmod +x /usr/local/bin/kubectl

# Helm Installation
RUN curl https://baltocdn.com/helm/signing.asc | apt-key add
RUN echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
RUN apt-get update && apt-get -y install helm=3.11.2-1

# Java Installation
RUN apt-get install -y \
    openjdk-17-jdk=17.0.6+10-0ubuntu1~22.04 \
    openjdk-17-jre=17.0.6+10-0ubuntu1~22.04 \
    maven=3.6.3-5

# GitHub user configuration
RUN useradd github && \
    mkdir -p /home/github && \
    chown -R github:github /home/github && \
    chown -R github:github /actions-runner

WORKDIR /home/github

COPY entrypoint.sh ./entrypoint.sh
RUN chmod +x ./entrypoint.sh

USER github
ENTRYPOINT ["/home/github/entrypoint.sh"]