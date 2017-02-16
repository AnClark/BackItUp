#!/bin/bash

src_path=$1
dest_path=$(echo $1 | sed 's/.zip/.signed.zip/g')

java -jar signapk.jar bdd.pem bdd.pk8 ${src_path} ${dest_path}

