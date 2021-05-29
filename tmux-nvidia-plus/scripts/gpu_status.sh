#!/usr/bin/env bash

print_gpu_status() {
	nvidia-smi | awk '$13 ~ /%$/ {printf "%.2f", $13/100}' | xargs printf 
}

main () {
	print_gpu_status
}

main
