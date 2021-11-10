#!/bin/bash

# BARCHIVE - The simple archiver
# Coded By: Bryson Forget :^)

clear
echo "Welcome to Bryson's Backup Script (^_^)" && sleep 1
echo "Keep in mind that this program only uses absolute paths" && sleep 1

#functions to create paths and names
func_mypath(){
read -p "What directory are you looking to backup: " mypath 
}
func_myname(){
read -p "What is the file name: " myname
}
#function that checks for $cprog variable and compresses accordingly
func_compress(){
	echo "FUCK"
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
#Checks for cprog variable to compress with func_compress
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
#init function starts the program (check last line)
func_init(){
unset yn
unset yn2
func_mypath
#if the user changes to a directory that doesn't exist, return true
while !(cd $mypath 2>/dev/null) && echo "Invalid Syntax"
do
	func_mypath
done
func_filelocation
while !(cd $filelocation 2>/dev/null) && echo "Invalid Syntax"
do
	func_filelocation
done
func_compressprog
# if cprog doesn't return GZ or BZ, return true
while !([ $cprog == GZ ] 2>&1>/dev/null || [ $cprog == BZ ] 2>&1>/dev/null) && echo "Invalid Syntax"
do
	func_compressprog
done
func_myname
echo -e "ORIGINAL: $mypath     NAME: $myname     REMOTE: $filelocation     COMPRESS:$cprog_long"
read -p ":: Is this correct [Y/N] " yn
#cases allow multiple conditions to obtain a Yes answer
case $yn in
	Y | y | Yes | yes)
	yn="Y"
	;;
	*)
	yn="N"
esac
[ $yn = "Y" ] && echo "Proceeding..." && sleep 1 || echo -e "Aborting...\n" 
#second case statement needs to be added after checking that yn doesn't equal Y
[ ! $yn = "Y" ] && read -p ":: Would you like to restart [Y/N] " yn2 && case $yn2 in
	Y | y | Yes | yes)
	yn2="Y"
	;;
	*)
	yn2="N"
esac
[ $yn2 = "Y" ] && func_init
[ ! $yn2 = "Y" ] && exit
func_compress
}
#function that starts the program
func_init
