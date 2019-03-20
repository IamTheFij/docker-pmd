FROM openjdk:13-alpine
LABEL author="ian@iamthefij.com"

ENV VERSION=6.12.0

RUN apk add bash curl unzip

RUN curl -L -o pmd.zip https://github.com/pmd/pmd/releases/download/pmd_releases%2F${VERSION}/pmd-bin-${VERSION}.zip && \
        unzip pmd.zip && \
        rm pmd.zip

RUN mv /pmd-bin-${VERSION} /pmd
WORKDIR /pmd

USER nobody

ENTRYPOINT ["./bin/run.sh", "pmd"]
