#!/bin/bash

hostname=$(hostname)

IFS='.' read -ra parts <<< "$hostname"

echo "${parts[0]}"
