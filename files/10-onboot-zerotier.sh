#!/usr/bin/env sh

DEBUG=${DEBUG:--d}
CONTAINER_NAME="zerotier"


if podman container exists ${CONTAINER_NAME}; then
  podman start ${CONTAINER_NAME}
  exit 0
fi

podman run --mount="type=bind,source=/mnt/data/$CONTAINER_NAME,destination=/var/lib/zerotier-one/" \
            --name "$CONTAINER_NAME" \
            --network=host \
            -v /dev/net/tun:/dev/net/tun \
            --name $CONTAINER_NAME \
            --cap-add=NET_ADMIN \
            --cap-add=SYS_ADMIN \
            --restart always \
            $DEBUG \
            docker.io/bltavares/zerotier
