# Trend Micro Cloud One Container Security Scan Action

![TM Logo](tm-logo.jpg)

## Scan your containers with [Trend Micro Cloud One Container Security](https://www.trendmicro.com/en_us/business/products/hybrid-cloud/cloud-one-container-image-security.html)

This tool is meant to be used as a [GitHub Action](https://github.com/features/actions).

## Requirements

* Have an [Cloud One Account](https://cloudone.trendmicro.com). [Sign up for free trial now](https://cloudone.trendmicro.com/trial) if it's not already the case!
* [A Cloud One API Key](https://cloudone.trendmicro.com/docs/identity-and-account-management/c1-api-key/#new-api-key) with `Full Access` role
* A container image to be scan.

## Usage

Add an Action in your `.github/workflow` yml file to scan your image with Trend Micro Cloud One Container Security.

```yml
- name: Cloud One Container Security Scan Action
  uses: felipecosta09/cloud-one-container-security-scan-action@version*
   with:
      # Mandatory
      CLOUD_ONE_API_KEY: ${{ secrets.API_KEY }}
      IMAGE: alpine
      REGION: us-1

      # Optional
      TOTAL: 0
      MAX_CRITICAL: 0
      MAX_HIGH: 0
      MAX_MEDIUM: 0
      MAX_LOW: 0
      MAX_NEGLIGIBLE: 0
      MAX_UNKNOWN: 0
      SCAN_RESULT_ARTIFACT: result.json   
```
