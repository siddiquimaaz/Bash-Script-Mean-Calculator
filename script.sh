#!/bin/bash

usage() {
  echo "Usage: $0 [-m] [-h] <filename>"
  echo "  -m  Calculate the mean of numbers in the file (default if no flag specified)"
  echo "  -h  Display this help message"
  exit 1
}

# Set default operation
operation="mean"

while getopts ":mh" opt; do
  case $opt in
    m)
      operation="mean"
      ;;
    h)
      usage
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      ;;
  esac
done

shift $((OPTIND - 1))

if [ $# -eq 0 ]; then
  echo "Error: Filename not provided."
  usage
fi

filename=$1

if [ ! -f "$filename" ]; then
  echo "Error: File '$filename' not found."
  usage
fi

case $operation in
  mean)
    awk '{ sum += $1; count++ } END { if (count > 0) print sum / count }' "$filename"
    ;;
  *)
    echo "Error: Invalid operation '$operation'."
    usage
    ;;
esac
