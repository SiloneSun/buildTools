#!/bin/bash

source env_setup.sh
make -j8 source/usbcam
aarch64-linux-gnu-strip -s out/arm64/app/prog_usbcam
