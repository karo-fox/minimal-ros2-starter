FROM ros:foxy


RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    git \
    cmake \
    python3-pip \
    python3-catkin-tools \
    && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos '' docker && \
    adduser docker sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER docker

WORKDIR /home/docker 
RUN mkdir -p ws/src
WORKDIR /home/docker/ws/src
ENV ROS_WORKSPACE=/home/docker/ws
RUN catkin init

WORKDIR $ROS_WORKSPACE

ENTRYPOINT [ "/ros_entrypoint.sh" ]
CMD ["/bin/bash"]