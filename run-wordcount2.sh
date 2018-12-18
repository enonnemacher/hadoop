#!/bin/bash
# create input directory on HDFS
echo -e "\n Criando díretorio input"
hadoop fs -mkdir -p teste-input

# put input files to HDFS
echo -e "\n Lendo arquivo"
hdfs dfs -put teste.log teste-input

# compile teste
echo -e "\n Compilando arquivo wordcount"
javac teste.java -cp $(hadoop classpath)

# put in a jar
jar cvf teste.jar teste\$Map.class teste\$Reduce.class teste.class

# run teste
hadoop jar teste.jar teste teste-input teste-output

# print the input files
echo -e "\n Listando arquivos de log"
hdfs dfs -ls | grep *.log

# print the output of teste
echo -e "\n Resultado:"
hdfs dfs -cat teste-output/part-00000