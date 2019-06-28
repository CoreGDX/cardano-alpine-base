# Alpine edge supports RUST 1.35, the minimum version
# required for compiling input-output-hk/jormungandr
FROM alpine:edge
WORKDIR /usr

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
	protobuf-dev=3.6.1-r1 \
	g++=8.3.0-r0

# Pull the cardano-node repository, checkout the specific commit and build
RUN git clone --recurse-submodules ${REPO} src && \
	cd src && \
	git checkout tags/v${REPO_VERSION} && \
	cargo install --path jormungandr && \
	cargo install --path jcli