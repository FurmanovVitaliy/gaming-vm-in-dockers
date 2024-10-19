FROM arch:base 

ENV UNAME="default" 

RUN echo "**** Install fmpeg and requirements ****" \
	    && pacman -Syu --noconfirm \
        ffmpeg pulseaudio lib32-opus opus opus-tools \
    && echo "**** Section cleanup ****" \
	    && pacman -Scc --noconfirm \
        && rm -fr /var/lib/pacman/sync/* 

COPY  scripts/startup.sh /opt/startup.sh

RUN chmod +x /opt/startup.sh