FROM arch:base
LABEL maintainer="furmanov <furmanov.vitaliy@gmail.com>"

ENV UNAME=default
ENV GOCACHE=/home/yay/.cache/go-build
ENV GOPATH=/home/yay/go

RUN echo "**** Install mesa, vulkan and PortProtone requirements ****" \
	    && pacman -Syu --noconfirm --needed \
            mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-mesa-layers \
            lib32-vulkan-mesa-layers libva-mesa-driver lib32-libva-mesa-driver \
            mesa-utils vulkan-tools nvidia-prime libva-utils lib32-mesa-utils \
            xf86-video-amdgpu vulkan-radeon libva-mesa-driver mesa-vdpau \
            xf86-video-amdgpu xf86-video-vesa vulkan-radeon libva-mesa-driver mesa-vdpau \
        && pacman -Syu --noconfirm --needed \
            bash bubblewrap zstd cabextract tar openssl desktop-file-utils curl dbus \
            freetype2 gdk-pixbuf2 ttf-font gzip nss xorg-xrandr vulkan-driver vulkan-icd-loader \
            lsof lib32-freetype2 lib32-libgl lib32-gcc-libs lib32-libx11 lib32-libxss lib32-alsa-plugins \
            lib32-libgpg-error lib32-nss lib32-vulkan-driver lib32-vulkan-icd-loader lib32-openssl \
        && pacman -Syu --noconfirm --needed \
            gamescope 


RUN echo "**** Configure yay user ****" && \
    mkdir /home/yay && \
    useradd -d /home/yay -s /bin/bash yay && \
    chown -R yay /home/yay && \
    echo "yay ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER yay 
WORKDIR /home/yay
RUN echo "**** Install yay ****" \
     && git clone https://aur.archlinux.org/yay.git \
     && cd yay \
     && makepkg -si --noconfirm
RUN echo "**** Install PortProtone from AUR ****" \
    && yay -S portproton --noconfirm
USER root
RUN echo "**** Clean up ****" \
    && rm -rf /var/cache/pacman/pkg/* \
    && rm -rf /home/yay/yay \
    && userdel -r yay 
WORKDIR /

COPY overlay /
COPY  scripts/startup.sh /opt/startup.sh

RUN chmod +x /opt/startup.sh
