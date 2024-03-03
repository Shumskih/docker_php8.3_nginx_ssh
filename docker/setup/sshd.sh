#!/bin/bash

# Start sshd with custom options
/usr/sbin/sshd -D -o ListenAddress=0.0.0.0
