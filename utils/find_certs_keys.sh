#!/bin/bash

sp="/-\|"
sc=0

spin() {
   printf "\b${sp:sc++:1}"
   ((sc==${#sp})) && sc=0
}

endspin() {
   printf "\r%s\n" "$@"
}

pemcount=0
crtcount=0
keycount=0

echo "------------------------"
echo "Checking all .pem files"
echo "------------------------"
found_raw=$(find / -name *.pem) 
echo "Total .pen files found:" 
#wc -l ${found_raw}

found = $(find / -name *.pem | grep -v -E 'docker|snap|python|Root|grep|Certification_Authority|CA|ssl|crda|ubuntu'
echo "Checking only non-system .pem files"
wc -l found

for file in ${found}
do
	((pemcount=pemcount+1))
	spin
	echo ${file}
	openssl x509 -in ${file} -noout --text 
	#| grep -si -E 'airbox|keyless'
done
#endspin


echo "------------------------"
echo "Checking all .crt files"
echo "------------------------"
found=$(find / -name *.crt | grep -v -E 'docker|mozilla|snap|grub|doc')
for file in ${found}
do
	((crtcount=crtcount+1))
	spin
	echo ${file}
	openssl x509 -in ${file} --text -noout
done
#endspin


echo "------------------------"
echo "checking for all keys"
echo "------------------------"
found=$(find / -name *.key | grep -v -E 'docker|google')
for file in ${found}
do
	((keycount=keycount+1))
	spin
	echo ${file}
	openssl rsa -in ${file} --check
done
endspin

