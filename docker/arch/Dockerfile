FROM archlinux:latest

ARG PUB_KEY

RUN pacman -Sqyu --noconfirm --needed \
        openssh \
        python3 \
        sudo \
    && systemctl enable sshd

#RUN sed -i \
#    -e 's/^#*\(PermitRootLogin\) .*/\1 yes/' \
#    /etc/ssh/sshd_config


# Create new ssh host keys
RUN  /usr/bin/ssh-keygen -A


RUN useradd -m -s /bin/bash -G wheel sysadmin

RUN mkdir -p /home/sysadmin/.ssh/
RUN echo $PUB_KEY > /home/sysadmin/.ssh/authorized_keys

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
