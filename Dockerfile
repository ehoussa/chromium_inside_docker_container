FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8


RUN apt-get update && apt install flatpak -y && flatpak update --appstream \
    && flatpak update --runtime \
    && flatpak update --system \
    && apt install --reinstall ca-certificates -y \
    && flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo \
    && flatpak install flathub org.mozilla.firefox -y \
    && apt install xauth -y

CMD ["flatpak", "run", "org.mozilla.firefox"]
