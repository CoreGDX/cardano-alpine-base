# Alpine edge supports RUST 1.35, the minimum version
# required for compiling input-output-hk/jormungandr
FROM coregdx/jormungandr:release-0.0.0-rc0
WORKDIR /usr

# Run the bootstrap script
RUN cd src/scripts && \
	chmod +x bootstrap && \
	./bootstrap && \
	cd ../../

# Run the local blockchain
# CMD ["cd src && jormungandr", "--genesis-block", "./block-0.bin", "--config", "./config.yaml", "--secret", "./pool-secret1.yaml"]