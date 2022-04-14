FROM nvidia/cudagl:11.3.1-base-centos7


RUN yum -y install wget libgomp && \
    yum clean all && \
    rm -rf /var/cache/yum

WORKDIR /tmp

RUN wget --no-check-certificate "https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.10&type=binary&os=Linux&downloadFile=ParaView-5.10.0-egl-MPI-Linux-Python3.9-x86_64.tar.gz" && \
    mv "download.php?submit=Download&version=v5.10&type=binary&os=Linux&downloadFile=ParaView-5.10.0-egl-MPI-Linux-Python3.9-x86_64.tar.gz" ParaView-5.10.0-egl-MPI-Linux-Python3.9-x86_64.tar.gz && \
    tar xzf ParaView-5.10.0-egl-MPI-Linux-Python3.9-x86_64.tar.gz && \
    mv ParaView-5.10.0-egl-MPI-Linux-Python3.9-x86_64 /opt/ParaView-5.10.0 &&\
    rm -rf ParaView-5.10.0-egl-MPI-Linux-Python3.9-x86_64.tar.gz

COPY Files/FitsReader.tar.gz /tmp/

RUN tar xzf FitsReader.tar.gz  && \
    cp -r FitsReader /opt/ParaView-5.10.0/lib/paraview-5.10/plugins/  && \
    sed '3 <Plugin name="FitsReader" auto_load="1"/>' /opt/ParaView-5.10.0-egl-MPI/lib/paraview-5.10/plugins/paraview.plugins.xml  && \
    rm -rf /tmp/*

      
