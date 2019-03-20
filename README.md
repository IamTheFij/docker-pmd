# docker-pmd

OpenJDK based Docker image for running PMD

## Usage

To run, create a rules.xml file, or download one from the [git repo](https://github.com/pmd/pmd).

After that, you can run using the following command:

    docker run -v $(pwd):/src:ro --rm iamthefij/pmd -d /src -f textcolor -R /src/quickstart.xml

## Building
Clone this repo and then run

    docker build -f Dockerfile . -t pmd-test

