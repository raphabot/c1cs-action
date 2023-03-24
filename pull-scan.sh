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
MESSAGE=""
TOTAL_VULNERABILITIES="$(jq '.totalVulnCount' "$SCAN_RESULT_ARTIFACT")"
if [ "$TOTAL_VULNERABILITIES" -gt "$MAX_TOTAL" ]; then MESSAGE+="Your total vulnerabilities is $TOTAL_VULNERABILITIES, which is higher than $MAX_TOTAL\n"; fi
TOTAL_CRITICAL="$(jq '.criticalCount' "$SCAN_RESULT_ARTIFACT")"
if [ "$TOTAL_CRITICAL" -gt "$MAX_CRITICAL" ]; then MESSAGE+="Your total of Critical vulnerabilities is $TOTAL_CRITICAL, which is higher than $MAX_CRITICAL\n"; fi
TOTAL_HIGH="$(jq '.highCount' "$SCAN_RESULT_ARTIFACT")"
if [ "$TOTAL_HIGH" -gt "$MAX_HIGH" ]; then MESSAGE+="Your total of High vulnerabilities is $TOTAL_HIGH, which is higher than $MAX_HIGH\n"; fi
TOTAL_MEDIUM="$(jq '.mediumCount' "$SCAN_RESULT_ARTIFACT")"
if [ "$TOTAL_MEDIUM" -gt "$MAX_MEDIUM" ]; then MESSAGE+="Your total of Medium vulnerabilities is $TOTAL_MEDIUM, which is higher than $MAX_MEDIUM\n"; fi
TOTAL_LOW="$(jq '.lowCount' "$SCAN_RESULT_ARTIFACT")"
if [ "$TOTAL_LOW" -gt "$MAX_LOW" ]; then MESSAGE+="Your total of Low vulnerabilities is $TOTAL_LOW, which is higher than $MAX_LOW\n"; fi
TOTAL_NEGLIGIBLE="$(jq '.negligibleCount' "$SCAN_RESULT_ARTIFACT")"
if [ "$TOTAL_NEGLIGIBLE" -gt "$MAX_NEGLIGIBLE" ]; then MESSAGE+="Your total of Negligible vulnerabilities is $TOTAL_NEGLIGIBLE, which is higher than $MAX_NEGLIGIBLE\n"; fi
TOTAL_UNKNOWN="$(jq '.unknownCount' "$SCAN_RESULT_ARTIFACT")"
if [ "$TOTAL_UNKNOWN" -gt "$MAX_UNKNOWN" ]; then MESSAGE+="Your total of Unknown vulnerabilities is $TOTAL_UNKNOWN, which is higher than $MAX_UNKNOWN"; fi

# Issue found
if [ "$MESSAGE" = "" ]; then printf "$MESSAGE"; exit 1; fi

# No issues found
echo "Evaluation found no issues against the provided policy."
exit 0