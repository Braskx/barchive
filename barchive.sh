#!/bin/bash

# BARCHIVE - The simple archiver
# Coded By: Bryson Forget :^)

#TODO 
# barchive [-gz/-bz] [local] [remote]
# create simple man page

clear
echo "Welcome to Bryson's Backup Script (^_^)" && sleep 1
echo "Keep in mind that this program only uses absolute paths" && sleep 1

#functions (look at the right to see the variables they create)
func_mypath(){
read -p "What directory are you looking to backup: " mypath 
}
func_myname(){
read -p "What is the file name: " myname
}
func_compress(){
if [ $cprog == "GZ" ]
	then
	tar -zcvf $myname $mypath
fi

if [ $cprog == "BZ" ]
	then
	tar -jcvf $myname $mypath
fi
mv $myname $filelocation
}
func_filelocation(){
read -p "Where will the backup be stored: " filelocation
}
func_compressprog(){
cprog_long="Default"
read -p "What compression program will be used (GZ or BZ): " cprog
if [ $cprog == "GZ" ]
	then
	cprog_long="GZIP"
fi
if [ $cprog == "BZ" ]
	then
	cprog_long="BZIP2"
fi
}
#init function (it starts the program after clear, and echo commands)
func_init(){
unset yn
unset yn2
func_mypath
while $(! cd $mypath 2>/dev/null) && echo "Invalid Syntax"
do
	func_mypath
done
func_filelocation
while !(cd $filelocation 2>/dev/null) && echo "Invalid Syntax"
do
	func_filelocation
done
func_compressprog
while !([ $cprog == GZ ] 2>&1>/dev/null || [ $cprog == BZ ] 2>&1>/dev/null) && echo "Invalid Syntax"
do
	func_compressprog
done
func_myname
echo -e "ORIGINAL: $mypath     NAME: $myname     REMOTE: $filelocation     COMPRESS:$cprog_long"
read -p ":: Is this correct [Y/N] " yn
[ $yn = "Y" ] && echo "Proceeding..." && sleep 1 || echo -e "Aborting...\n" 
[ ! $yn = "Y" ] && read -p ":: Would you like to restart [Y/N]" yn2
[ $yn2 = "Y" ] && func_init
[ ! $yn2 = "Y" ] && exit
func_compress
}
func_init
