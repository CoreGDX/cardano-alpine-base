# Alpine edge supports RUST 1.35, the minimum version
# required for compiling input-output-hk/jormungandr
FROM coregdx/jormungandr:release-0.0.0-rc4
WORKDIR /usr/cardano/jormungandr/bin

# Run the local blockchain
CMD ["jormungandr", "--genesis-block", "./block-0.bin", "--config", "./config.yaml", "--secret", "./pool-secret1.yaml"]