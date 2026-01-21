
# Use Red Hat UBI 9 as a lightweight, redistributable base
FROM registry.access.redhat.com/ubi9/ubi

# Build-time args for user configuration (optional)
ARG USERNAME=ansible
ARG UID=1000
ARG GID=1000

# Install OpenSSH server, sudo, and Python 3; create user; configure sshd
RUN dnf -y update && \
    dnf -y install openssh-server sudo shadow-utils python3 && \
    dnf clean all && rm -rf /var/cache/dnf/* && \
    # Create group and user
    groupadd -g ${GID} ${USERNAME} && \
    useradd -m -u ${UID} -g ${GID} -s /bin/bash ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME} && \
    # Generate SSH host keys
    ssh-keygen -A && \
    # Harden SSH: disable password auth, disallow root login, enable pubkey
    sed -ri 's/^#?PasswordAuthentication .*/PasswordAuthentication no/g' /etc/ssh/sshd_config && \
    sed -ri 's/^#?PermitRootLogin .*/PermitRootLogin no/g' /etc/ssh/sshd_config && \
    sed -ri 's/^#?PubkeyAuthentication .*/PubkeyAuthentication yes/g' /etc/ssh/sshd_config && \
    # Make sshd work smoothly in a container without PAM
    sed -ri 's/^#?UsePAM .*/UsePAM no/g' /etc/ssh/sshd_config

# Copy your public key (rename your file to docker_key.pub or change this line)
COPY docker_key.pub /tmp/docker_key.pub

# Place key into authorized_keys with correct ownership and permissions
RUN install -d -m 700 -o ${USERNAME} -g ${GID} /home/${USERNAME}/.ssh && \
    cat /tmp/docker_key.pub >> /home/${USERNAME}/.ssh/authorized_keys && \
    chown ${USERNAME}:${GID} /home/${USERNAME}/.ssh/authorized_keys && \
    chmod 600 /home/${USERNAME}/.ssh/authorized_keys && \
    rm -f /tmp/docker_key.pub

# Expose SSH port
EXPOSE 22

# Start sshd in the foreground (no systemd required)
CMD ["/usr/sbin/sshd", "-D", "-e"]

