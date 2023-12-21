FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN apt-get update && apt install flatpak -y && flatpak update --appstream \
    && flatpak update --runtime \
    && flatpak update --system \
    && flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo \
    && flatpak install flathub org.mozilla.firefox -y

CMD ["flatpak", "run", "org.mozilla.firefox"]
