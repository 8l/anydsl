#!/bin/sh

filename=$(basename "$1")
name=`echo $filename | cut -f1 -d'.'`

mkdir -p tmp
cd tmp

echo "# Compiling the infrastructure ..."
clang ../impala/test/infrastructure/call_impala_main.c -O2 -c

echo "# Running impala on file $1 ..."
impala --emit-llvm -bta ../"$1"

echo "# Compiling program with infrastrcuture ..."
clang "$name".bc call_impala_main.o
