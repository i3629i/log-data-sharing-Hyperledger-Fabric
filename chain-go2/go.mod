module runner

go 1.14

require (
    github.com/hyperledger/fabric-contract-api-go v1.1.1
    runner.com/chaincode v0.0.0
)

replace (
    runner.com/chaincode v0.0.0 => ./chaincode
)

// replace runner.com/chaincode v0.0.0 => ./chaincode