FROM kitware/paraview:pv-v5.8.0-osmesa-py3

USER root
RUN apt-get update \
 && apt-get install wget build-essential zlib1g-dev libcurl3-dev -y

WORKDIR /tmp
RUN wget --no-check-certificate "https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.11&type=binary&os=Linux&downloadFile=ParaView-5.11.2-osmesa-MPI-Linux-Python3.9-x86_64.tar.gz" && \
    mv "download.php?submit=Download&version=v5.11&type=binary&os=Linux&downloadFile=ParaView-5.11.2-osmesa-MPI-Linux-Python3.9-x86_64.tar.gz" ParaView-5.11.2-osmesa-MPI-Linux-Python3.9-x86_64.tar.gz && \
    tar xzf ParaView-5.11.2-osmesa-MPI-Linux-Python3.9-x86_64.tar.gz && \
    mv ParaView-5.11.2-osmesa-MPI-Linux-Python3.9-x86_64 /opt/ParaView-5.11.2 &&\
    rm -rf ParaView-5.11.2-osmesa-MPI-Linux-Python3.9-x86_64.tar.gz


RUN wget --no-check-certificate "http://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio-4.1.0.tar.gz" && \
    tar xfz cfitsio-4.1.0.tar.gz && \ 
    cd cfitsio-4.1.0 && \
    ./configure --prefix=/opt/cfitsio/ --enable-reentrant && \
    make && \
    make install && \
    echo "/opt/cfitsio/lib" >> /etc/ld.so.conf.d/cfitsio.conf && \
    ldconfig

ENV LD_LIBRARY_PATH /opt/cfitsio/lib:$LD_LIBRARY_PATH

COPY Files/FitsReader.tar.gz /tmp/

COPY Files/PVSliceFilter.tar.gz /tmp/

RUN tar xzf FitsReader.tar.gz  && \
    cp -r FitsReader /opt/ParaView-5.11.2/lib/paraview-5.11/plugins  && \
	tar xzf PVSliceFilter.tar.gz  && \
    cp -r PVSliceFilter /opt/ParaView-5.11.2/lib/paraview-5.11/plugins  && \
    sed -i '3i\\t<Plugin name=\"FitsReader\" auto_load=\"1\" \/>' /opt/ParaView-5.11.2/lib/paraview-5.11/plugins/paraview.plugins.xml  && \
	sed -i '3i\\t<Plugin name=\"PVSliceFilter\" auto_load=\"1\" \/>' /opt/ParaView-5.11.2/lib/paraview-5.11/plugins/paraview.plugins.xml  && \
    rm -rf /tmp/*

USER pv-user