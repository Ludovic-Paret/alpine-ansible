FROM alpine:3.7

ENV ANSIBLE_VERSION "2.5.0"
ENV ANSIBLE_LINT_VERSION "3.4.21"
ENV ANSIBLE_REVIEW_VERSION "v0.13.5"

ARG RUNTIME_DEPS="python py-pip openssl openssh-client git"
ARG BUILD_DEPS="python-dev libffi-dev openssl-dev build-base"

RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${RUNTIME_DEPS} && \
    apk add --no-cache --virtual build-dependencies ${BUILD_DEPS} && \
    pip install --no-cache-dir --upgrade pip cffi && \
    pip install --no-cache-dir 	ansible==${ANSIBLE_VERSION} \
				ansible-lint==${ANSIBLE_LINT_VERSION} \
				ansible-review==${ANSIBLE_REVIEW_VERSION} && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/* && \
    ansible --version

ENTRYPOINT []
