#!/bin/bash
IMAGE_TARBALL="image.tar"

# Pulls the image
echo "Pulling Image..."
crane pull "$IMAGE" "$IMAGE_TARBALL"

# Scans the image
c1cs scan -e "artifactscan.$REGION.cloudone.trendmicro.com" docker-archive:"$IMAGE_TARBALL" > "$SCAN_RESULT_ARTIFACT"

# print the result
cat "$SCAN_RESULT_ARTIFACT"

# Evaluates the result
 if [ "$(jq '.totalVulnCount' "$SCAN_RESULT_ARTIFACT")" -ge "$MAX_TOTAL" ]; then exit 1; fi
 if [ "$(jq '.criticalCount' "$SCAN_RESULT_ARTIFACT")" -ge "$MAX_CRITICAL" ]; then exit 1; fi
 if [ "$(jq '.highCount' "$SCAN_RESULT_ARTIFACT")" -ge "$MAX_HIGH" ]; then exit 1; fi
 if [ "$(jq '.mediumCount' "$SCAN_RESULT_ARTIFACT")" -ge "$MAX_MEDIUM" ]; then exit 1; fi
 if [ "$(jq '.lowCount' "$SCAN_RESULT_ARTIFACT")" -ge "$MAX_LOW" ]; then exit 1; fi
 if [ "$(jq '.negligibleCount' "$SCAN_RESULT_ARTIFACT")" -ge "$MAX_NEGLIGIBLE" ]; then exit 1; fi
 if [ "$(jq '.unknownCount' "$SCAN_RESULT_ARTIFACT")" -ge "$MAX_UNKNOWN" ]; then exit 1; fi

 exit 0