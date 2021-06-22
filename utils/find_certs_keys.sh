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
echo "Searching for all non-system .pem files"

find / -name "*.pem"
found=$(find / -name "*.pem" | grep -v -E 'docker|snap|python|Root|grep|Certification_Authority|CA|ssl|crda|ubuntu')

echo "Checking only non-system .pem files"

for file in ${found}
do
	((pemcount=pemcount+1))
	spin
	echo "Found a non system ${file} ..."
	openssl x509 -in ${file} -noout --text 
	#| grep -si -E 'airbox|keyless'
done
#endspin

echo "------------------------"
echo "Checking all .crt files"
echo "------------------------"
find / -name "*.crt"
found=$(find / -name "*.crt" | grep -v -E 'docker|mozilla|snap|grub|doc')

for file in ${found}
do
	((crtcount=crtcount+1))
	spin
	echo "Found a non system ${file} ..."
	openssl x509 -in ${file} --text -noout
done
#endspin


echo "------------------------"
echo "checking for all .key files"
echo "------------------------"
find / -name "*.key"
found=$(find / -name "*.key" | grep -v -E 'docker|google')
for file in ${found}
do
	((keycount=keycount+1))
	spin
	echo "Found a non system ${file} ..."
	openssl rsa -in ${file} --check
done
endspin


echo "------------------------"
echo "Found ${pemcount} .pem files"
echo "Found ${crtcount} .crt files"
echo "Found ${keycount} .key files"
echo "------------------------"

