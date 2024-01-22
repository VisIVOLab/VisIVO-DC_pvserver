# VisIVO-pvserver (osmesa version)
To run the container:
```
docker run -p 11111:11111 -v <host_dir>:<container_dir> visivolab/visivo-pvserver:osmesa
```
To include any local data files on the docker server, they must be mounted using the `-v` switch. For example, to include the directory `Data/HI_Images` and mount it to `/home/Data/` on the server, the switch `-v Data/HI_Images:/home/Data/` must be included. In the example, `Data/HI_Images` is the `<host_dir>` and `/home/Data/` is the `<container_dir>`. It is necessary to use absolute paths – relative paths are not allowed. Multiple mount points can be included with multiple `-v` switches. For example, to include the directories fold1, fold2, and fold3 on the docker server, run the server using the following command:
```
docker run -p 11111:11111 -v fold1:/Mount/Data/fold1 -v fold2:/Mount/Data/fold2 -v fold3:/Mount/Data/fold3 visivolab/visivo-pvserver:osmesa
```

Note that no files will be available on the server unless they are included in a path explicitly included through the `-v` switch.

To run with singularity:
```
singularity exec --bind <host_dir>:<container_dir> visivo-pvserver.sif /opt/ParaView-5.11.2/bin/pvserver
```
