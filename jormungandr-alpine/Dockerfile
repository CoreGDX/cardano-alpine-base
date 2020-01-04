# Alpine edge supports RUST 1.35, the minimum version
# required for compiling input-output-hk/jormungandr
FROM alpine:3.11
LABEL MAINTAINER CoreGDX-(DavidArayan)
WORKDIR /usr/cardano/jormungandr

# The URL to clone the repository from
ENV REPO https://github.com/input-output-hk/jormungandr

# The Commit hash to use (specific commit) to pull
ENV REPO_VERSION 0.8.5

# Path to the protoc (protobuf) compiler - see https://github.com/protocolbuffers/protobuf
# required by jormungandr_src/chain-deps/network-grpc 
ENV PROTOC /usr/bin/protoc

# Install required tools and packages
# Ensure to update the versions of the packages
# if Alpine updates. Get the latest version details from
# https://pkgs.alpinelinux.org/packages
RUN apk add --update --no-cache \
	git=2.24.1-r0 \
	curl=7.67.0-r0 \
	rust=1.39.0-r0 \
	cargo=1.39.0-r0 \
	openssl=1.1.1d-r3 \
	openssl-dev=1.1.1d-r3 \
	protobuf=3.11.2-r0 \
	protobuf-dev=3.11.2-r0 && \
	# Pull the cardano-node repository, checkout the specific commit and build
	git clone --depth 1 ${REPO} src && \
	cd src && \
	git fetch --depth 1 --tags && \
	git checkout tags/v${REPO_VERSION} && \
	git submodule sync && \
	git submodule update --init && \
	cargo build --release && \ 
	cargo install --path jormungandr && \
	cargo install --path jcli && \
	cd ../ && \
	mkdir bin && \
	# copy the compiled binaries since we will purge the .cargo folder
	cp -pR $HOME/.cargo/bin/jormungandr bin/jormungandr && \
	cp -pR $HOME/.cargo/bin/jcli bin/jcli && \
	rm -rf src $HOME/.cargo && \
	# cleanup caches and stuff used to compile the source
	# so we can make the image as small as possible.
	# containers extending can re-add them if needed
	apk del git \
	curl \
	rust \
	cargo \
	openssl-dev \
	protobuf-dev

# Update the environment path
ENV PATH "$PATH:/usr/cardano/jormungandr/bin"
# Easy access to the compiled executables from environment variables
ENV JORMUNGANDR_PATH "/usr/cardano/jormungandr/bin/jormungandr"
ENV JCLI_PATH "/usr/cardano/jormungandr/bin/jcli"