FROM ubuntu:24.04
RUN export DEBIAN_FRONTEND=noninteractive; apt update; apt install -y build-essential m4 bison flex uuid-dev qemu-utils musl-tools curl
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y

RUN bash -c 'source $HOME/.cargo/env; rustup +1.77.0 target add x86_64-unknown-linux-musl'
RUN bash -c 'source $HOME/.cargo/env; rustup +1.77.0 target add aarch64-unknown-linux-musl'
RUN bash -c 'source $HOME/.cargo/env; rustup install 1.77.0'


