# Alpine edge supports RUST 1.35, the minimum version
# required for compiling input-output-hk/jormungandr
FROM alpine:edge

WORKDIR /usr

# Install required tools and packages
RUN apk add --update --no-cache \
	git=2.22.0-r0 \
	curl=7.65.1-r0 \
	rust=1.35.0-r0

