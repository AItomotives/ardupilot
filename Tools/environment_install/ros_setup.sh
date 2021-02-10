rm /bin/sh && ln -s /bin/bash /bin/sh
apt-get upgrade

 apt-get update

 apt-get install wget -y

 apt-get install -y gnupg2

 wget -qO- https://get.docker.com/gpg | apt-key add -

 apt-get install -y lsb-release && apt-get clean all

 sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

 apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

  apt-get update

  apt-get install -y ros-melodic-desktop-full
echo "source /opt/ros/melodic/setup.bash" >> /root/.bashrc

 source /root/.bashrc

  apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential

  apt install -y python-rosdep

 apt-get -y install ros-melodic-mavros ros-melodic-mavros-extras

 wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh
chmod a+x install_geographiclib_datasets.sh

 ./install_geographiclib_datasets.sh

 apt-get install -y python-catkin-tools

  rosdep init

 rosdep update

 mkdir -p ~/catkin_ws/src
