#!/bin/bash -e

s3cmd -v put public/*.js s3://schepp-is/kor-gallery/
s3cmd -v put public/index.html s3://schepp-is/kor-gallery/