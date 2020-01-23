# Ensure to use a version of alpine that supports
# RUST 1.35 as a minimum
FROM alpine:3.11
LABEL MAINTAINER CoreGDX-(DavidArayan)

# The URL to clone the repository from
ENV REPO https://github.com/input-output-hk/jormungandr

# The Commit hash to use (specific commit) to pull
ENV REPO_VERSION 0.8.7

# Genesis config information
ENV GENESIS_HASH 8e4d2a343f3dcf9330ad9035b3e8d168e6728904262f2c434a4f8f934ec7b676
ENV CONFIG_YAML_URL https://hydra.iohk.io/build/1561591/download/1/itn_rewards_v1-config.yaml
ENV GENESIS_YAML_URL https://hydra.iohk.io/build/1561591/download/1/itn_rewards_v1-genesis.yaml

# Path to the protoc (protobuf) compiler - see https://github.com/protocolbuffers/protobuf
# required by jormungandr_src/chain-deps/network-grpc 
ENV PROTOC /usr/bin/protoc

# Path to the base directory that we will work with
ENV BASEDIR /usr/cardano/jormungandr

WORKDIR ${BASEDIR}

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
	mkdir config && \
	# download and save the config information needed to run the node
	curl -o config/config.yaml ${CONFIG_YAML_URL} && \
	curl -o config/genesis.yaml ${GENESIS_YAML_URL} && \
	echo ${GENESIS_HASH} > config/genesis_hash.txt && \
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
ENV JORMUNGANDR_PATH ${BASEDIR}/bin/jormungandr
ENV JCLI_PATH ${BASEDIR}/bin/jcli

# Easy access to the config information from environment variables
ENV CONFIG_YAML_PATH ${BASEDIR}/config/config.yaml
ENV GENESIS_YAML_PATH ${BASEDIR}/config/genesis.yaml
ENV GENESIS_HASH_PATH ${BASEDIR}/config/genesis_hash.txt