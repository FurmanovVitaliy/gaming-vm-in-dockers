FROM archlinux:latest
LABEL maintainer="furmanov <furmanov.vitaliy@gmail.com>"

ARG TARGETARCH=amd64
ARG GOSU_VERSION=1.17

ENV \
    PUID=1000 \
    PGID=1000 \
    UMASK=000 \
    UNAME="default" \
    HOME="/home/default" \
    TZ="Poland"

# Update locale
RUN echo "**** Configure locals ****" \
        && echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen \
        && locale-gen

RUN echo "**** Update package manager ****" \
    && sed -i 's/^NoProgressBar/#NoProgressBar/g' /etc/pacman.conf \
    && echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf \
    && pacman -Syu --noconfirm

RUN echo "**** Install certificates ****" \
    && pacman -S --noconfirm --needed ca-certificates \
    && echo "**** Install tools ****" \
    && pacman -S --noconfirm --needed \
    base-devel bash bash-completion git jq man-db nano net-tools wget evtest

RUN echo "**** Install gosu ****" \
    && set -e \
    && wget -O /usr/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$TARGETARCH" \
    && chmod +x /usr/bin/gosu \
    && echo "**** Verify gosu works ****"  \
    && gosu nobody true && echo "Working!"

RUN echo "**** Section cleanup ****" \
    && pacman -Scc --noconfirm \
    && rm -fr /var/lib/pacman/sync/*


# Import overlay
COPY overlay /

# Set entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
