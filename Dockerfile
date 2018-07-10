FROM alpine:3.8

ENV ANSIBLE_VERSION "2.6.1"
ENV ANSIBLE_LINT_VERSION "3.4.23"
ENV ANSIBLE_REVIEW_VERSION "0.13.7"

ARG RUNTIME_DEPS="python py-pip openssl openssh-client git py-dnspython libintl"
ARG BUILD_DEPS="python-dev libffi-dev openssl-dev build-base gettext"

COPY ./config.ini /root/.config/ansible-review/config.ini

RUN apk update && \
    apk upgrade && \
    apk add --no-cache ${RUNTIME_DEPS} && \
    apk add --no-cache --virtual build-dependencies ${BUILD_DEPS} && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    pip install --no-cache-dir --upgrade pip cffi jinja2 && \
    pip install --no-cache-dir 	ansible==${ANSIBLE_VERSION} \
				ansible-lint==${ANSIBLE_LINT_VERSION} \
				ansible-review==${ANSIBLE_REVIEW_VERSION} && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/* && \
    ansible --version

ENTRYPOINT []
