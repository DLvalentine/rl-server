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
RUN sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Install curses
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

# Setup default player account, ssh settings, and login script
RUN useradd -m -s /bin/bash player

RUN echo "player:player" | chpasswd

RUN sed -i "s/#PasswordAuthentication yes/PasswordAuthentication yes/" /etc/ssh/sshd_config && \
sed -i "s/PermitRootLogin prohibit-password/PermitRootLogin no/" /etc/ssh/sshd_config

RUN mkdir -p /home/player/.ssh
RUN touch /home/player/.ssh/rc
RUN echo "export LANG=en_US.UTF-8" >> /home/player/.ssh/rc
RUN echo "export LC_ALL=en_US.UTF-8" >> /home/player/.ssh/rc
RUN echo "#!bin/bash\n /rl-server/start-angband.sh" >> /home/player/.ssh/rc

# Expose ssh port
EXPOSE 22
    
# Startup commands -> startup with docker run -d --name cname -p 2222:22 image then ssh player@localhost -p 2222
CMD ["/usr/sbin/sshd", "-D"]