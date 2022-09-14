
# var zone
chain_package="chain_tar_gz/new5.tar.gz" 
name="new5"
sequence="4"

echo '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ chain approve 7051  $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'

export FABRIC_CFG_PATH=${PWD}/config
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=localhost:7051

peer lifecycle chaincode approveformyorg \
  -o localhost:7050 \
  --ordererTLSHostnameOverride orderer.example.com \
  --tls \
  --cafile $ORDERER_CA \
  --channelID mychannel \
  --name $name \
  --version 1 \
  --package-id $PACKAGE_ID \
  --sequence $sequence NA NA NA


echo '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ chain approve 9051  $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'

export ORDERER_CA=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
export FABRIC_CFG_PATH=${PWD}/config
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=localhost:9051


peer lifecycle chaincode approveformyorg \
  -o localhost:7050 \
  --ordererTLSHostnameOverride orderer.example.com \
  --tls \
  --cafile $ORDERER_CA \
  --channelID mychannel \
  --name $name \
  --version 1 \
  --package-id $PACKAGE_ID \
  --sequence $sequence NA NA NA



echo '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ chain approve 10051  $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'

export ORDERER_CA=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
export FABRIC_CFG_PATH=${PWD}/config
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="cauMSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/cau.example.com/peers/peer0.cau.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/cau.example.com/users/Admin@cau.example.com/msp
export CORE_PEER_ADDRESS=localhost:10051

peer lifecycle chaincode approveformyorg \
  -o localhost:7050 \
  --ordererTLSHostnameOverride orderer.example.com \
  --tls \
  --cafile $ORDERER_CA \
  --channelID mychannel \
  --name $name \
  --version 1 \
  --package-id $PACKAGE_ID \
  --sequence $sequence NA NA NA



echo '$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ chain commit  $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'

export ORDERER_CA=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

peer lifecycle chaincode commit \
  -o localhost:7050 \
  --ordererTLSHostnameOverride orderer.example.com \
  --tls \
  --cafile $ORDERER_CA \
  --channelID mychannel \
  --name $name \
  --peerAddresses localhost:7051 \
  --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt \
  --peerAddresses localhost:9051 \
  --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt \
  --peerAddresses localhost:10051 \
  --tlsRootCertFiles ${PWD}/organizations/peerOrganizations/cau.example.com/peers/peer0.cau.example.com/tls/ca.crt \
  --version 1 \
  --sequence $sequence NA NA NA
