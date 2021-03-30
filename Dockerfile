FROM ubuntu:18.04
WORKDIR /ardupilot

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get upgrade

RUN apt-get update

RUN apt-get install wget -y

RUN apt-get install -y gnupg2

RUN wget -qO- https://get.docker.com/gpg | apt-key add -

RUN apt-get install -y lsb-release && apt-get clean all

RUN  sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

RUN  apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

RUN  apt-get update

RUN  apt-get install -y ros-melodic-desktop-full

RUN  apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential

RUN  apt install -y python-rosdep

RUN apt-get -y install ros-melodic-mavros ros-melodic-mavros-extras

RUN wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh

RUN chmod a+x install_geographiclib_datasets.sh

RUN ./install_geographiclib_datasets.sh

RUN apt-get install -y python-catkin-tools

RUN apt-get install -y xterm

RUN apt-get install -y x11-apps

RUN mkdir -p ~/catkin_ws/src

RUN useradd -U -m ardupilot && \
    usermod -G users ardupilot

RUN apt-get update && apt-get install --no-install-recommends -y \
    lsb-release \
    sudo \
    software-properties-common

COPY Tools/environment_install/install-prereqs-ubuntu.sh /ardupilot/Tools/environment_install/
COPY Tools/completion /ardupilot/Tools/completion/

RUN apt install -y tmux
# Create non root user for pip
ENV USER=ardupilot

RUN echo "ardupilot ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ardupilot
RUN chmod 0440 /etc/sudoers.d/ardupilot

RUN chown -R ardupilot:ardupilot /ardupilot

USER ardupilot

ENV SKIP_AP_EXT_ENV=1 SKIP_AP_GRAPHIC_ENV=1 SKIP_AP_COV_ENV=1 SKIP_AP_GIT_CHECK=1
RUN Tools/environment_install/install-prereqs-ubuntu.sh -y

# add waf alias to ardupilot waf to .bashrc
RUN echo "alias waf=\"/ardupilot/waf\"" >> ~/.bashrc

# Check that local/bin are in PATH for pip --user installed package
RUN echo "if [ -d \"\$HOME/.local/bin\" ] ; then\nPATH=\"\$HOME/.local/bin:\$PATH\"\nfi" >> ~/.bashrc

# Set the buildlogs directory into /tmp as other directory aren't accessible
ENV BUILDLOGS=/tmp/buildlogs

USER root
RUN rm /bin/sh && ln -s /bin/bash /bin/sh 
USER ardupilot
# Cleanup
RUN sudo apt-get clean \
    && sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV CCACHE_MAXSIZE=1G

# Ros Setup
ENV rossetup="/opt/ros/melodic/setup.bash"
RUN /bin/bash -c "source /opt/ros/melodic/setup.bash"
RUN rosinstall_generator --rosdistro kinetic mavlink | tee /tmp/mavros.rosinstall
RUN sudo rosdep init
RUN rosdep update
RUN rosdep install --from-paths /tmp/mavros.rosinstall --ignore-src -y
USER ardupilot
