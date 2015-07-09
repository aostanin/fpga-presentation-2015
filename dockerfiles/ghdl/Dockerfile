FROM gentoo/stage3-amd64

ENV LANG en_US.UTF-8

RUN echo "$LANG UTF-8" > /etc/locale.gen && \
    locale-gen

RUN emerge-webrsync && \
    echo "sci-electronics/ghdl ~amd64" >> /etc/portage/package.accept_keywords && \
    emerge --quiet-build sci-electronics/ghdl && \
    rm -rf /usr/portage

