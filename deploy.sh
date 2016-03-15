#!/bin/bash -e

s3cmd -v put --recursive public/* s3://schepp-is/kor-gallery/