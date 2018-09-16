FROM debian:stretch

# https://ungoogled-software.github.io/ungoogled-chromium-binaries/releases/debian/stretch_amd64/
ARG VERSION=69.0.3497.92-2
ARG COMMON_DEB_URL=https://github.com/Eloston/ungoogled-chromium-binaries/releases/download/${VERSION}/ungoogled-chromium-common_${VERSION}.stretch_amd64.deb
ARG BROWSER_DEB_URL=https://github.com/Eloston/ungoogled-chromium-binaries/releases/download/${VERSION}/ungoogled-chromium_${VERSION}.stretch_amd64.deb

RUN apt-get update && \
    apt-get install --no-install-recommends --yes ca-certificates lsb-release wget fontconfig dumb-init && \
    wget --no-verbose --output-document /tmp/chromium_common.deb ${COMMON_DEB_URL} && \
    wget --no-verbose --output-document /tmp/chromium_browser.deb ${BROWSER_DEB_URL} && \
    apt-get install --no-install-recommends --yes /tmp/chromium_common.deb /tmp/chromium_browser.deb && \
    apt-get remove --yes ca-certificates wget && \
    apt-get clean && \
    rm -f /tmp/chromium_common.deb /tmp/chromium_browser.deb && \
    groupadd chromium && \
    useradd --create-home --gid chromium chromium && \
    chown --recursive chromium:chromium /home/chromium/

VOLUME ["/home/chromium/.fonts"]

COPY --chown=chromium:chromium entrypoint.sh /home/chromium/

USER chromium

EXPOSE 9222

ENTRYPOINT ["dumb-init", "--", "/bin/sh", "/home/chromium/entrypoint.sh"]