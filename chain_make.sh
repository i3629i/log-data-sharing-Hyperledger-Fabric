
# var zone
chain_package="chain_tar_gz/new5.tar.gz" 
label="new_5"

echo '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ Make Package $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'

echo $label
echo $chian_package

peer lifecycle chaincode package $chain_package \
  --path ./chain-go2/ \
  --lang golang \
  --label $label


echo '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ chaincode install $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'

export FABRIC_CFG_PATH=${PWD}/config
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=localhost:7051

peer lifecycle chaincode install $chain_package

echo '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ chaincode install $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'


export ORDERER_CA=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
export FABRIC_CFG_PATH=${PWD}/config
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=localhost:9051

peer lifecycle chaincode install $chain_package

echo '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ chaincode install $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'


export ORDERER_CA=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
export FABRIC_CFG_PATH=${PWD}/config
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="cauMSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/cau.example.com/peers/peer0.cau.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/cau.example.com/users/Admin@cau.example.com/msp
export CORE_PEER_ADDRESS=localhost:10051

peer lifecycle chaincode install $chain_package

