# VisIVO-pvserver (EGL version)
To run the container:
```
docker run --gpus all -p 11111:11111 -v <host_dir>:<container_dir> visivolab/visivo-pvserver:egl
```

To run with singularity:
```
singularity exec --nv --bind <host_dir>:<container_dir> visivo-pvserver.sif /opt/ParaView-5.11.2/bin/pvserver
```
