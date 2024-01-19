# VisIVO-pvserver (osmesa version)
To run the container:
```
docker run -p 11111:11111 -v <host_dir>:<container_dir> visivolab/visivo-pvserver:osmesa
```

To run with singularity:
```
singularity exec --bind <host_dir>:<container_dir> visivo-pvserver.sif /opt/ParaView-5.11.2/bin/pvserver
```
