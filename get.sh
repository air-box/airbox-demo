echo "Creating directory structure ..."
mkdir -p ~/air-box
cd ~/air-box

echo "Getting keyvisor ..."
git clone https://github.com/air-box/keyvisor.git


echo "Building keyvisor ..."
cd keyvisor
apt-get install -y build-essential libssl-dev
make
if [[ -f "keyvisor.so" ]]; then
       echo "keyvisor library generated"
fi       

cd ~/air-box

echo "Getting keycentral ..."
#https://github.com/air-box/keycentral.git
#cd keycentral
#make
#check

cd ~/air-box
