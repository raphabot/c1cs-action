#!/bin/bash
echo "Pulling Image..."
crane pull "$IMAGE" image.tar
c1cs scan -e "artifactscan.$REGION.cloudone.trendmicro.com" docker-archive:image.tar
