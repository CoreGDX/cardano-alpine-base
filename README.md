[![Twitter: @DavidArayan](https://img.shields.io/badge/contact-DavidArayan-blue.svg?style=flat)](https://twitter.com/DavidArayan)
[![License](https://img.shields.io/badge/license-MIT-orange.svg?style=flat)](LICENSE)

Run the [Cardano Testnet](https://testnet.iohkdev.io/cardano/) using a lightweight [Docker](https://www.docker.com/) [Alpine Image](https://hub.docker.com/_/alpine). Prebuilt images are hosted in [Docker Hub](https://hub.docker.com/r/coregdx/jormungandr).

---

#### Required Tools

- Install [Docker](https://www.docker.com/) for Mac, Win or Linux

#### Run the local testnet

- Pull/Clone this Repository
- Run `docker-compose -f live.yml up`

#### Cleanup

- Run `sh nuke.sh`

#### Using Base Image 

Prebuilt Alpine Images are hosted in [Docker Hub](https://hub.docker.com/r/coregdx/jormungandr) and can be used as a base for more advanced functionality. Grab the latest version and use the following in your Dockerfile.

`FROM coregdx/jormungandr:release-0.2.3-rc0`

#### Acknowledgements

This tool relies on the following open source projects.

- [IOHK Jormungandr Project](https://github.com/input-output-hk/jormungandr)
