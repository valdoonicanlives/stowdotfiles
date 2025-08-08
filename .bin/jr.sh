#!/bin/bash
echo "Enter you joural entry"
read name
#echo $date >> test.text
echo "$(date +'%D;%H:%M')" >> ~/jrnl.md
#@echo %time% %date% >>  ~/test.text
#print DATE% TIME% >> ~/test.text
# echo $date  >> ~/.test.text
# echo $@ >> ~/text-files/todo.txt
echo $name >> ~/jrnl.md
exit
