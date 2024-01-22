# VisIVO-pvserver (EGL version)
Make sure Docker is installed on the host machine.
To run the container:
```
docker run --gpus all -p 11111:11111 -v <host_dir>:<container_dir> visivolab/visivo-pvserver:egl
```
To include any local data files on the docker server, they must be mounted using the `-v` switch. For example, to include the directory `Data/HI_Images` and mount it to `/home/Data/` on the server, the switch `-v Data/HI_Images:/home/Data/` must be included. In the example, `Data/HI_Images` is the `<host_dir>` and `/home/Data/` is the `<container_dir>`. It is necessary to use absolute paths – relative paths are not allowed. Multiple mount points can be included with multiple `-v` switches. For example, to include the directories fold1, fold2, and fold3 on the docker server, run the server using the following command:
```
docker run --gpus all -p 11111:11111 -v fold1:/Mount/Data/fold1 -v fold2:/Mount/Data/fold2 -v fold3:/Mount/Data/fold3 visivolab/visivo-pvserver:egl
```

To run with singularity:
```
singularity exec --nv --bind <host_dir>:<container_dir> visivo-pvserver.sif /opt/ParaView-5.11.2/bin/pvserver
```
### Dependencies:
1. [Docker](https://docs.docker.com/engine/install/)

### Troubleshooting:
If Docker complains about not having gpus or errors out on initialisation, make sure that the [Nvidia container toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) and an appropriate Nvidia driver is installed. Should this still fail, consider using the [osmesa](https://github.com/VisIVOLab/VisIVO-pvserver/tree/osmesa) branch of the docker container.
