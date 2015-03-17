#!/bin/bash -e

filename=$(basename "$1")
name=`echo $filename | cut -f1 -d'.'`

mkdir -p tmp
cd tmp

#echo "# Compiling the infrastructure ..."
#clang ../impala/test/infrastructure/call_impala_main.c -O2 -c
#clang ../tests/infrastructure/call_impala_main.c -O2 -c

if [ $2 == "-opt" ]; then
        echo "# Running impala (opt) on file $1 ..."
        impala -cogen --emit-llvm -Othorin ../"$1" 2> main.cc
        cat main.cc
        echo -e "\n\nint main() {\n\tWorld world;\n\t$3(world$4);\n\treturn 0;\n}" >> main.cc
        mv main.cc /home/tobias/cogen-explicit/test/main.cc
        cd /home/tobias/cogen-explicit/test/
        make
        build/default/loop-gen
else
        echo "# Running impala on file $1 ..."
        impala -cogen --emit-thorin ../"$1" 2> main.cc
	cat main.cc
	echo -e "\n\nint main() {\n\tWorld world;\n\t$2(world$3);\n\treturn 0;\n}" >> main.cc
	mv main.cc /home/tobias/cogen-explicit/test/main.cc
	cd /home/tobias/cogen-explicit/test/
	make
	build/default/loop-gen
fi

#echo "# Compiling program with infrastrcuture ..."
#clang "$name".bc call_impala_main.o

#echo "# Running the compiled program ..."
#./a.out "$arg_a" "$arg_b"
#echo ""

#echo "-> return code was ($?)"

#cd ..
