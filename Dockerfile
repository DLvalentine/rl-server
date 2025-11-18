############################# Base Setup ############################################

# Base image Debian and workdir for server-wide scripts
FROM debian:stable-slim
WORKDIR /rl-server

# Install general updates and common packages
RUN apt-get update && \
    apt-get install -y \
    locales \
    locales-all \
    man-db \
    less \
    nano \
    cron \
    systemd-sysv \
    openssh-server

# Set UTF-8 as default locale (system/root)
RUN sed -i "s/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/" /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Set UTF-8 as default locale (all users)
RUN echo "export LANG=en_US.UTF-8" > /etc/profile.d/lang_export.sh && \
    echo "export LC_ALL=en_US.UTF-8" >> /etc/profile.d/lang_export.sh

# Setup an alias for the play.sh script (all users)
RUN echo "alias play='/home/player/play.sh'" >> /etc/profile.d/play_alias.sh
RUN echo "alias p='play'" >> /etc/profile.d/play_alias.sh

# Set MOTD (all users)
COPY etc/motd.txt /etc/motd

############################# Games Setup ############################################

# Install curses, used by various games
RUN apt-get update && \
    apt-get install -y \
    libncurses5-dev \
    libncursesw5-dev

# Install angband, create startup script for it
RUN echo "deb http://deb.debian.org/debian stable main" > /etc/apt/sources.list.d/stable.list && \
    apt-get update && \
    apt-get install -y \
    angband

RUN echo "#!/bin/bash\n /usr/games/angband -mgcu" > /rl-server/start-angband.sh && \
    chmod +x /rl-server/start-angband.sh

# Install crawl, create startup script for it
RUN apt-get install -y crawl

RUN echo "#!/bin/bash\n /usr/games/crawl" > /rl-server/start-crawl.sh && \
    chmod +x /rl-server/start-crawl.sh

# Install cdda, create startup script for it
RUN apt-get install -y cataclysm-dda-curses

RUN echo "#!/bin/bash\n /usr/games/cataclysm" > /rl-server/start-cataclysm.sh && \
    chmod +x /rl-server/start-cataclysm.sh

############################# User Setup ############################################

# Setup default player account, ssh settings, and login scripts
RUN useradd -m -s /bin/bash player

RUN echo "player:player" | chpasswd

RUN sed -i "s/#PasswordAuthentication yes/PasswordAuthentication yes/" /etc/ssh/sshd_config && \
sed -i "s/PermitRootLogin prohibit-password/PermitRootLogin no/" /etc/ssh/sshd_config

COPY scripts/play.sh /home/player/play.sh
RUN chmod +x /home/player/play.sh

RUN echo "source /etc/profile.d/lang_export.sh" >> /etc/profile
RUN echo "source /etc/profile.d/play_alias.sh" >> /etc/profile

############################# CMDs ############################################

# Expose ssh port
EXPOSE 22
    
# When the container starts, startup sshd
CMD ["/usr/sbin/sshd", "-D"]
