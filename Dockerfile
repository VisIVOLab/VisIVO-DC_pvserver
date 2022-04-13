FROM nvidia/cuda:11.6.2-base-centos7

WORKDIR /tmp
RUN wget "https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.10&type=binary&os=Linux&downloadFile=ParaView-5.10.0-egl-MPI-Linux-Python3.9-x86_64.tar.gz" \
    mv "downloadFile=ParaView-5.10.0-egl-MPI-Linux-Python3.9-x86_64.tar.gz" ParaView-5.10.0-egl-MPI-Linux-Python3.9-x86_64.tar.gz \
    tar xzf ParaView-5.10.0-egl-MPI-Linux-Python3.9-x86_64.tar.gz \
    mv ParaView-5.10.0-egl-MPI-Linux-Python3.9-x86_64 /opt/ParaView-5.10.0