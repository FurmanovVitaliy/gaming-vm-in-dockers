FROM arch:base

ARG REQUIRED_PACKAGES=" \
    alsa-utils \
    pavucontrol \
    pulseaudio \
    pulseaudio-alsa \
    "

ENV UNAME="default" 
    
RUN echo "**** Install PulseAudio requirements ****" \
	&& pacman -Syu --noconfirm \
    && pacman -S --noconfirm $REQUIRED_PACKAGES \
    && echo "**** Section cleanup ****" \
	&& pacman -Scc --noconfirm \
    && rm -fr /var/lib/pacman/sync/* 

COPY overlay /
COPY  scripts/startup.sh /opt/startup.sh
RUN chmod +x /opt/startup.sh

EXPOSE 4713
