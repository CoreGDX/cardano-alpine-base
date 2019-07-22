# Alpine edge supports RUST 1.35, the minimum version
# required for compiling input-output-hk/jormungandr
FROM coregdx/jormungandr:release-0.3.1-rc0
WORKDIR /usr/cardano/jormungandr/bootstrap