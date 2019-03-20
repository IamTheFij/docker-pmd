FROM openjdk:13-alpine
LABEL author="ian@iamthefij.com"

ARG VERSION=6.12.0

RUN apk add bash curl unzip

COPY ./pmd-bin-${VERSION}.zip.sha256 /

RUN curl -L -o pmd-bin-${VERSION}.zip https://github.com/pmd/pmd/releases/download/pmd_releases%2F${VERSION}/pmd-bin-${VERSION}.zip && \
        sha256sum -c pmd-bin-${VERSION}.zip.sha256 && \
        unzip pmd-bin-${VERSION}.zip && \
        rm pmd-bin-${VERSION}.zip

RUN mv /pmd-bin-${VERSION} /pmd
WORKDIR /pmd

USER nobody

ENTRYPOINT ["./bin/run.sh", "pmd"]
