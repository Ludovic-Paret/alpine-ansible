FROM alpine:3.10

ARG ANSIBLE_VERSION="2.8.3"
ARG ANSIBLE_LINT_VERSION="4.1.0"
ARG ANSIBLE_REVIEW_VERSION="0.13.9"

ENV ANSIBLE_VERSION "${ANSIBLE_VERSION}"
ENV ANSIBLE_LINT_VERSION "${ANSIBLE_LINT_VERSION}"
ENV ANSIBLE_REVIEW_VERSION "${ANSIBLE_REVIEW_VERSION}"

ARG RUNTIME_DEPS="openssl openssh-client git py-dnspython libintl py-pip python3"
ARG BUILD_DEPS="python3-dev libffi-dev openssl-dev build-base gettext"

COPY ./config.ini /root/.config/ansible-review/config.ini

RUN apk update --quiet && \
    apk upgrade --quiet && \
    apk add --quiet --no-cache ${RUNTIME_DEPS} && \
    apk add --quiet --no-cache --virtual build-dependencies ${BUILD_DEPS} && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    pip3 install --no-cache-dir --quiet --upgrade pip && \
    pip3 install --no-cache-dir --quiet cffi jinja2 \
					ansible==${ANSIBLE_VERSION} \
					ansible-lint==${ANSIBLE_LINT_VERSION} \
					ansible-review==${ANSIBLE_REVIEW_VERSION} && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*

ENTRYPOINT []
