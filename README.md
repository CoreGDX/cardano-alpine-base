<h3 align="center">
  <img src="graphics/icon.png?raw=true" alt="EzySlice Logo" width="700">
</h3>

[![Twitter: @DavidArayan](https://img.shields.io/badge/contact-DavidArayan-blue.svg?style=flat)](https://twitter.com/DavidArayan)
[![License](https://img.shields.io/badge/license-MIT-orange.svg?style=flat)](LICENSE)

Run a [Cardano Jormungandr (Rust) Node](https://testnet.iohkdev.io/cardano/) using a lightweight [Docker Alpine Linux Image](https://hub.docker.com/_/alpine). Prebuilt images are hosted in [Docker Hub](https://hub.docker.com/r/coregdx/jormungandr) and available under the permissive [MIT](LICENSE) License.

---

#### Required Tools

* Install [Docker](https://www.docker.com/) for Mac, Win or Linux

#### Local Build

* Pull/Clone this Repository
* Navigate to `jormungandr-alpine` 
* Run `docker-compose -f live.yml build` 

#### Cleanup

* Run `sh nuke.sh` 

#### Extending the Base Image

Prebuilt Images are hosted in [Docker Hub](https://hub.docker.com/r/coregdx/jormungandr) and can be used as a base for more advanced functionality. Grab the latest version and use the following in your Dockerfile.

`FROM coregdx/jormungandr:release-[VERSION]` 

#### Executable Paths

This image has the compiled [IOHK Jormungandr Code](https://github.com/input-output-hk/jormungandr) in the following paths.

* Access jormungandr `JORMUNGANDR_PATH` executable in `usr/cardano/jormungandr/bin/jormungandr` 
* Access jcli `JCLI_PATH` executable in `usr/cardano/jormungandr/bin/jcli` 

#### Acknowledgements

This tool relies on the following open source projects.

* [IOHK Jormungandr Project](https://github.com/input-output-hk/jormungandr)

