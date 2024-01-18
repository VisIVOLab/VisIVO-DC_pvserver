FROM nvidia/cudagl:11.4.2-base-centos7

RUN yum -y install wget libgomp gcc-c++ zlib-devel make && \
    yum clean all && \
    rm -rf /var/cache/yum

WORKDIR /tmp

RUN wget --no-check-certificate "https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.11&type=binary&os=Linux&downloadFile=ParaView-5.11.2-egl-MPI-Linux-Python3.9-x86_64.tar.gz" && \
    mv "download.php?submit=Download&version=v5.11&type=binary&os=Linux&downloadFile=ParaView-5.11.2-egl-MPI-Linux-Python3.9-x86_64.tar.gz" ParaView-5.11.2-egl-MPI-Linux-Python3.9-x86_64.tar.gz && \
    tar xzf ParaView-5.11.2-egl-MPI-Linux-Python3.9-x86_64.tar.gz && \
    mv ParaView-5.11.2-egl-MPI-Linux-Python3.9-x86_64 /opt/ParaView-5.11.2 && \
    rm -rf ParaView-5.11.2-egl-MPI-Linux-Python3.9-x86_64.tar.gz

RUN wget --no-check-certificate "http://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio-4.1.0.tar.gz" && \
    tar xfz cfitsio-4.1.0.tar.gz && \ 
    cd cfitsio-4.1.0 && \
    ./configure --prefix=/opt/cfitsio/ --enable-reentrant && \
    make && \
    make install && \
    echo "/opt/cfitsio/lib" >> /etc/ld.so.conf.d/cfitsio.conf && \
    ldconfig

COPY Files/FitsReader.tar.gz /tmp/
COPY Files/PVSliceFilter.tar.gz /tmp/

RUN tar xzf FitsReader.tar.gz -C /opt/ParaView-5.11.2/lib/paraview-5.11/plugins && \
    tar xzf PVSliceFilter.tar.gz -C /opt/ParaView-5.11.2/lib/paraview-5.11/plugins && \
    sed -i '3i\\t<Plugin name=\"FitsReader\" auto_load=\"1\" \/>' /opt/ParaView-5.11.2/lib/paraview-5.11/plugins/paraview.plugins.xml  && \
    sed -i '3i\\t<Plugin name=\"PVSliceFilter\" auto_load=\"1\" \/>' /opt/ParaView-5.11.2/lib/paraview-5.11/plugins/paraview.plugins.xml  && \
    rm -rf /tmp/*

ENTRYPOINT ["/opt/ParaView-5.11.2/bin/pvserver"]
      
