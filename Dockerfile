FROM archlinux:base-devel

ARG repo_name
ENV repo_name=${repo_name}

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm git

RUN useradd --uid 1000 --shell /usr/bin/false dockeruser
RUN echo "dockeruser ALL=(ALL) NOPASSWD: ALL" >>/etc/sudoers

COPY ./entrypoint.sh /home/dockeruser/entrypoint.sh
RUN chmod +x /home/dockeruser/entrypoint.sh
COPY . /home/dockeruser/${repo_name}

RUN touch /home/dockeruser/${repo_name}/packages_file.txt
RUN mkdir -p /home/dockeruser/${repo_name}/packages
RUN mkdir -p /home/dockeruser/${repo_name}/x86_64

WORKDIR /home/dockeruser/${repo_name}
RUN chown -R dockeruser:dockeruser ./

USER dockeruser

ENTRYPOINT ["/home/dockeruser/entrypoint.sh"]