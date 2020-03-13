
# pull base image
FROM debian:jessie

RUN echo "===> Adding Ansible's PPA..."  && \
    echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" | tee /etc/apt/sources.list.d/ansible.list           && \
    echo "deb-src http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/ansible.list    && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 7BB9C367    && \
    DEBIAN_FRONTEND=noninteractive  apt-get update  && \
    \
    \
    echo "===> Installing Ansible..."  && \
    apt-get install -y ansible  && \
    \
    \
    echo "===> Removing Ansible PPA..."  && \
    rm -rf /var/lib/apt/lists/*  /etc/apt/sources.list.d/ansible.list  && \
    \
    \
    echo "===> Adding hosts for convenience..."  && \
    echo '[local]\nlocalhost\n' > /etc/ansible/hosts
    #  && \
    # apt-get install -y sudo && \
    # echo "===> sudo.."


# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]

# ==> Copying Ansible playbook...
WORKDIR /tmp
COPY  .  /tmp

# ==> Creating inventory file...
RUN echo "[loadbalancer]\nlocalhost\n" > inventory
RUN echo "[webserver]\nweb1" >> inventory

RUN ansible-playbook -i inventory --skip-tags="no-docker" ansible/loadbalancer.yml \
      --connection=local --sudo

EXPOSE  80

CMD ["nginx", "-g", "daemon off;"]


