# odysseus-server-configs

Contains the configuration files for hosting all Odysseus apps. Database, backend, OpenMCT and Geoserver run in Docker containers. The static frontend apps are served by nginx.

| App                                                                                    | URL                                                                                    | Type   |
| -------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- | ------ |
| [odysseus-admin-story-tool](https://github.com/OdysseusLarp/odysseus-admin-story-tool) | [https://live.odysseuslarp.dev/storyadmin/](https://live.odysseuslarp.dev/storyadmin/) | Static |
| [odysseus-admin](https://github.com/OdysseusLarp/odysseus-admin)                       | [https://live.odysseuslarp.dev/adminui/#/](https://live.odysseuslarp.dev/adminui/#/)   | Static |
| [odysseus-backend](https://github.com/OdysseusLarp/odysseus-backend)                   | [https://live.odysseuslarp.dev/](https://live.odysseuslarp.dev/)                       | Docker |
| [odysseus-data-hub](https://github.com/OdysseusLarp/odysseus-data-hub)                 | [https://live.odysseuslarp.dev/social/](https://live.odysseuslarp.dev/social/)         | Static |
| [odysseus-geoserver](https://github.com/OdysseusLarp/odysseus-geoserver)               | [https://live.odysseuslarp.dev/geoserver/](https://live.odysseuslarp.dev/geoserver/)   | Docker |
| [odysseus-HANSCA](https://github.com/OdysseusLarp/odysseus-HANSCA)                     | [https://live.odysseuslarp.dev/hansca/](https://live.odysseuslarp.dev/hansca/)         | Static |
| [odysseus-jump-ui](https://github.com/OdysseusLarp/hansca)                             | [https://live.odysseuslarp.dev/jumpui/](https://live.odysseuslarp.dev/jumpui/)         | Static |
| [odysseus-mct](https://github.com/OdysseusLarp/odysseus-mct)                           | [https://live.odysseuslarp.dev/mct/](https://live.odysseuslarp.dev/mct/)               | Docker |
| [odysseus-misc-ui](https://github.com/OdysseusLarp/odysseus-misc-ui)                   | [https://live.odysseuslarp.dev/misc/#/](https://live.odysseuslarp.dev/misc/#/)         | Static |

## Deployment

This section contains instructions on how to build and deploy the different apps on the server.

### odysseus-admin-story-tool
Build and deploy the new version:
```bash
cd ~/git/odysseus-admin-story-tool
git pull
./deploy.sh
```

### odysseus-admin
Build and deploy the new version:
```bash
cd ~/git/odysseus-admin
git pull
./deploy.sh
```

### odysseus-backend
Build a new version of the Docker image::
```bash
cd ~/git/odysseus-backend
git pull
docker build -t odysseus-backend .
```

Deploy the new version:
```bash
cd ~/git/odysseus-server-configs/home/odysseus
docker compose up -d
```

Note that this will also restart the database container if its image has changed. This will not affect the data in the database because the data is stored in a volume.

#### DMX
The USB DMX thingy is volume mapped from the host to the docker container. If the USB device configuration changes for some reason, make sure that it's mapped correctly. Make sure that it shows up in `lsusb`:
```bash
➜  ~ lsusb
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 004: ID 0403:6001 Future Technology Devices International, Ltd FT232 Serial (UART) IC
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

The device we are interested in is the `Future Technology Devices International, Ltd FT232 Serial (UART) IC`. Unfortunately `lsusb` does not show the device path, but in this case, we can access the device from `/dev/ttyUSB0` on the host.

Make sure that the device is correctly mapped in the `docker-compose.yml` file:
```yaml
services:
  backend:
    ...
    devices:
      - /dev/ttyUSB0:/dev/ttyUSB0
```

Also make sure that it's correctly configured in the `~/git/odysseus-server-configs/home/odysseus/.backend.env.prod` file:
```bash
DMX_DRIVER=enttec-usb-dmx-pro
DMX_DEVICE_PATH=/dev/ttyUSB0
```

### odysseus-data-hub
Build and deploy the new version:
```bash
cd ~/git/odysseus-data-hub
git pull
./deploy.sh
```

### odysseus-geoserver
Build and deploy a new version of the Docker image:
```bash
cd ~/git/odysseus-geoserver
git pull
docker build -t odysseus-geoserver .
./run-container.sh
```

### odysseus-HANSCA
Build and deploy the new version:
```bash
cd ~/git/odysseus-HANSCA
git pull
./deploy.sh
```

### odysseus-jump-ui
Build and deploy the new version:
```bash
cd ~/git/odysseus-jump-ui
git pull
./deploy.sh
```

### odysseus-mct
Build a new version of the Docker image:
```bash
cd ~/git/odysseus-mct
git pull
./build.sh
```

Deploy the new version:
```bash
cd ~/git/odysseus-server-configs/home/odysseus
./run-openmct.sh
```

### odysseus-misc-ui
Build and deploy the new version:
```bash
cd ~/git/odysseus-misc-ui
git pull
./deploy.sh
```
