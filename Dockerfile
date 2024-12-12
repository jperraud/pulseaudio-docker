FROM debian:bookworm

# Update and install alsa-utils
RUN apt-get update \
    && apt-get -y --no-install-recommends install \
    alsa-utils \
    pulseaudio \
    pulseaudio-utils \
    dbus \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user and add to sudo group
RUN useradd -m -s /bin/bash audiouser \
    && usermod -aG audio audiouser \
    && echo 'audiouser ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/audiouser \
    && chmod 0440 /etc/sudoers.d/audiouser

# Switch to the non-root user
USER audiouser

# Set the working directory
WORKDIR /home/audiouser

COPY default.pa /etc/pulse/

COPY setup.sh /usr/local/bin
RUN sudo chmod +x /usr/local/bin/setup.sh

# Default command
ENTRYPOINT ["/bin/bash", "/usr/local/bin/setup.sh"]
