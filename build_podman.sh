#!/bin/bash

set -xe

IMAGE_TAG=cloud_hypervisor_builder

if ! podman image exists $IMAGE_TAG
then
	podman image build -t $IMAGE_TAG -f Dockerfile
fi

podman run \
	--rm -it \
	--security-opt label=disable \
	-v ./:/work_dir \
	-w /work_dir \
	--entrypoint /bin/bash \
	$IMAGE_TAG \
	-c '
source $HOME/.cargo/env
cargo clean
cargo +1.77.0 build --release --locked --all --features dbus_api
#cargo +1.77.0 build --release --locked --all --target=x86_64-unknown-linux-musl --features dbus_api
'
