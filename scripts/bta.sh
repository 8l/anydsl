#!/bin/bash -e

filename=$(basename "$1")
name=`echo $filename | cut -f1 -d'.'`

mkdir -p tmp
cd tmp

echo "# Compiling the infrastructure ..."
#clang ../impala/test/infrastructure/call_impala_main.c -O2 -c
clang ../tests/infrastructure/call_impala_main.c -O2 -c

if [ $2 == "-bta" ]; then
	echo "# Running impala (only bta) on file $1 ..."
	impala --emit-llvm -bta ../"$1"
	
	arg_a="$3"
	arg_b="$4"
else
        echo "# Running impala on file $1 ..."
        impala --emit-llvm -Othorin ../"$1"
        
	arg_a="$2"
        arg_b="$3"
fi

echo "# Compiling program with infrastrcuture ..."
clang "$name".bc call_impala_main.o

echo "# Running the compiled program ..."
./a.out "$arg_a" "$arg_b"
echo ""

#echo "-> return code was ($?)"

cd ..
