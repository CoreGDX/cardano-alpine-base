# Alpine edge supports RUST 1.35, the minimum version
# required for compiling input-output-hk/jormungandr
FROM alpine:edge
LABEL MAINTAINER CoreGDX-(DavidArayan)
WORKDIR /usr/cardano/jormungandr

# The port we will be using for the node
ENV REST_PORT 8448

# The URL to clone the repository from
ENV REPO https://github.com/input-output-hk/jormungandr
# The Commit hash to use (specific commit) to pull
ENV REPO_VERSION 0.2.3
# Path to the protoc (protobuf) compiler - see https://github.com/protocolbuffers/protobuf
# required by jormungandr_src/chain-deps/network-grpc 
ENV PROTOC /usr/bin/protoc

# Install required tools and packages
# Ensure to update the versions of the packages
# if Alpine updates. Get the latest version details from
# https://pkgs.alpinelinux.org/packages
RUN apk add --update --no-cache \
	git=2.22.0-r0 \
	curl=7.65.1-r0 \
	rust=1.35.0-r0 \
	cargo=1.35.0-r0 \
	openssl=1.1.1c-r0 \
	openssl-dev=1.1.1c-r0 \
	protobuf=3.6.1-r1 \
	protobuf-dev=3.6.1-r1 

# Pull the cardano-node repository, checkout the specific commit and build
RUN git clone --recurse-submodules ${REPO} src && \
	cd src && \
	git checkout tags/v${REPO_VERSION} && \
	cargo build --release && \
	cargo install --path jormungandr && \
	cargo install --path jcli && \
	cd ../

# copy scripts, run bootstrap and delete source files that are no longer needed
RUN export PATH=$HOME/.cargo/bin:$PATH && \
	cd src/scripts && \
	chmod +x bootstrap && \
	./bootstrap -p ${REST_PORT} && \
	cd ../../ && \
	mkdir bootstrap && \
	cp -pR src/scripts/block-0.bin bootstrap/block-0.bin && \
	cp -pR src/scripts/config.yaml bootstrap/config.yaml && \
	cp -pR src/scripts/pool-secret1.yaml bootstrap/pool-secret1.yaml && \
	mkdir bin && \
	cp -pR $HOME/.cargo/bin/jormungandr bin/jormungandr && \
	cp -pR $HOME/.cargo/bin/jcli bin/jcli && \
	rm -rf src $HOME/.cargo

# Update the environment path
ENV PATH "$PATH:/usr/cardano/jormungandr/bin"

# cleanup caches and stuff used to compile the source
# so we can make the image as small as possible.
# containers extending can re-add them if needed
RUN apk del git \
	curl \
	rust \
	cargo \
	openssl-dev \
	protobuf-dev

EXPOSE ${REST_PORT}