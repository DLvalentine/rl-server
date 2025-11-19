############################# Base Setup ############################################

# Base image Debian and workdir for server-wide scripts
FROM debian:stable-slim
WORKDIR /rl-server
RUN chmod 755 /rl-server

# Setup the users file -> rw for root, write only for everyone else.
RUN touch /rl-server/users
RUN chmod 622 /rl-server/users

# Install general updates and common packages
RUN apt-get update && \
apt-get install -y \
dos2unix \
e2fsprogs \
locales \
locales-all \
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

# Setup an alias for the play.sh script once copied (all users)
COPY scripts/play.sh /rl-server/play.sh
RUN dos2unix /rl-server/play.sh
RUN chmod +x /rl-server/play.sh

RUN echo "alias play='/rl-server/play.sh'" >> /etc/profile.d/play_alias.sh
RUN echo "alias p='play'" >> /etc/profile.d/play_alias.sh

# Setup an alias for the register.sh script once copied (all users)
COPY scripts/register.sh /rl-server/register.sh
RUN dos2unix /rl-server/register.sh
RUN chmod +x /rl-server/register.sh

RUN echo "alias register='/rl-server/register.sh'" >> /etc/profile.d/register_alias.sh
RUN echo "alias r='register'" >> /etc/profile.d/register_alias.sh

# Copy over add-user script for admin use
COPY scripts/add-user.sh /rl-server/add-user.sh
RUN dos2unix /rl-server/add-user.sh
RUN chmod +x /rl-server/add-user.sh

# Set MOTD (all users)
COPY etc/motd.txt /etc/motd

############################# Games Setup ############################################

# Install curses, used by various games
RUN apt-get update && \
    apt-get install -y \
    libncurses5-dev \
    libncursesw5-dev

# Install angband
RUN echo "deb http://deb.debian.org/debian stable main" > /etc/apt/sources.list.d/stable.list && \
    apt-get update && \
    apt-get install -y \
    angband

# Install crawl
RUN apt-get install -y crawl

# Install cdda, create startup script for it
RUN apt-get install -y cataclysm-dda-curses

############################# User Setup ############################################

# Setup default player account, ssh settings, and login scripts
RUN useradd -m -s /bin/bash player

RUN echo "player:player" | chpasswd

RUN sed -i "s/#PasswordAuthentication yes/PasswordAuthentication yes/" /etc/ssh/sshd_config && \
sed -i "s/PermitRootLogin prohibit-password/PermitRootLogin no/" /etc/ssh/sshd_config

RUN echo "source /etc/profile.d/lang_export.sh" >> /etc/profile
RUN echo "source /etc/profile.d/play_alias.sh" >> /etc/profile
RUN echo "source /etc/profile.d/register_alias.sh" >> /etc/profile

# Copy motd into each user's home dir as a README file, just in case they need it!
RUN for dir in /home/*; do \
        cp /etc/motd "$dir/README.txt"; \
    done

############################# CMDs ############################################

# Expose ssh port
EXPOSE 22

# When the container starts, startup sshd and then make the users file append-only (can only be done during run)
CMD ["sh", "-c", "exec /usr/sbin/sshd -D && chattr +a /rl-server/users"]