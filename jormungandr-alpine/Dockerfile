# Ensure to use a version of alpine that supports
# RUST 1.35 as a minimum
FROM alpine:3.11
LABEL MAINTAINER CoreGDX-(DavidArayan)

# The URL to clone the repository from
ENV REPO="https://github.com/input-output-hk/jormungandr"

# The Commit hash to use (specific commit) to pull
ENV REPO_VERSION="0.8.9"

# Genesis config information
# see https://hydra.iohk.io/job/Cardano/iohk-nix/jormungandr-deployment/latest-finished/download/1/index.html
ENV BASE_URL="https://hydra.iohk.io/job/Cardano/iohk-nix/jormungandr-deployment/latest-finished/download/1"
ENV CONFIG_YAML_URL="${BASE_URL}/itn_rewards_v1-config.yaml"
ENV GENESIS_YAML_URL="${BASE_URL}/itn_rewards_v1-genesis.yaml"

# Path to the protoc (protobuf) compiler - see https://github.com/protocolbuffers/protobuf
# required by jormungandr_src/chain-deps/network-grpc 
ENV PROTOC="/usr/bin/protoc"

# Path to the base directory that we will work with
ENV BASEDIR="/usr/cardano/jormungandr"

# Update the environment path, this allows executing jormungandr and jcli directly
ENV PATH="$PATH:${BASEDIR}/bin"

# Easy access to the compiled executables from environment variables
ENV JORMUNGANDR_PATH="${BASEDIR}/bin/jormungandr"
ENV JCLI_PATH="${BASEDIR}/bin/jcli"

# Easy access to the config information from environment variables
ENV CONFIG_YAML_PATH="${BASEDIR}/config/config.yaml"
ENV GENESIS_YAML_PATH="${BASEDIR}/config/genesis.yaml"
ENV GENESIS_HASH_PATH="${BASEDIR}/config/genesis_hash.txt"
ENV GENESIS_BLOCK_PATH="${BASEDIR}/config/block-0.bin"

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
	cp -pR $HOME/.cargo/bin/jormungandr ${JORMUNGANDR_PATH} && \
	cp -pR $HOME/.cargo/bin/jcli ${JCLI_PATH} && \
	rm -rf src $HOME/.cargo && \
	mkdir config && \
	# download and save the config information needed to run the node
	# ensure curl follows redirects with the -L flag
	curl -L -o ${CONFIG_YAML_PATH} ${CONFIG_YAML_URL} && \
	curl -L -o ${GENESIS_YAML_PATH} ${GENESIS_YAML_URL} && \
	# generate the genesis hash needed to launch jormungandr
	jcli genesis encode --input ${GENESIS_YAML_PATH} --output ${GENESIS_BLOCK_PATH} && \
	jcli genesis hash --input ${GENESIS_BLOCK_PATH} > ${GENESIS_HASH_PATH} && \
	# cleanup caches and stuff used to compile the source
	# so we can make the image as small as possible.
	# containers extending can re-add them if needed
	apk del git \
	curl \
	rust \
	cargo \
	openssl-dev \
	protobuf-dev && \
	# prints the genesis hash to confirm that its correct (check manually)
	echo "**** CONFIG URL ****" && \
	echo "${BASE_URL}/index.html" && \
	echo "**** GENESIS HASH ****" && \
	cat ${GENESIS_HASH_PATH}