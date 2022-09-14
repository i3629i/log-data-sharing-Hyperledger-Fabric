package chaincode

import (
	"encoding/json"
	"fmt"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
	
)

// SmartContract provides functions for managing an Asset
type SmartContract struct {
	contractapi.Contract
}

// Asset describes basic details of what makes up a simple asset
type Asset struct {
	User_id             string 
	Pc_id          string 
	Date           string    
	Event          string 
	SC             string
}

// test###
// InitLedger adds a base set of assets to the ledger
func (s *SmartContract) InitLedger(ctx contractapi.TransactionContextInterface) error {
	// a := []list{data1,data2}
	assets := []Asset{
		{User_id: "sc-1-1", Pc_id: "PC-3504", Date: "03/11/2011 07:55:15", Event: "logon", SC: "1"},
		{User_id: "sc-1-2", Pc_id: "PC-3504", Date: "03/11/2011 08:55:15", Event: "Device", SC: "1"},
		{User_id: "sc-1-3", Pc_id: "PC-3504", Date: "03/11/2011 09:55:15", Event: "HTTP", SC: "1"},
		{User_id: "sc-2-1", Pc_id: "PC-8844", Date: "03/11/2012 07:55:15", Event: "logon", SC: "2"},
		{User_id: "sc-2-2", Pc_id: "PC-8844", Date: "03/11/2012 08:55:15", Event: "HTTP", SC: "2"},
		{User_id: "sc-2-3", Pc_id: "PC-8844", Date: "03/11/2012 09:55:15", Event: "email", SC: "2"},
	}
	
	for _, asset := range assets {
		assetJSON, err := json.Marshal(asset)
		fmt.Println(assetJSON)
		if err != nil {
			return err
		}
		
		// Putstate(Key, Value)
		err = ctx.GetStub().PutState(asset.User_id, assetJSON)
		if err != nil {
			return fmt.Errorf("failed to put to world state. %v", err)
		}
	}

	return nil
}



// GetAllAssets returns all assets found in world state
func (s *SmartContract) GetAllAssets(ctx contractapi.TransactionContextInterface, sc_num string) ([]*Asset, error) {
	// range query with empty string for startKey and endKey does an
	// open-ended query of all assets in the chaincode namespace.

	resultsIterator, err := ctx.GetStub().GetStateByRange("", "")
	if err != nil {
		return nil, err
	}
	defer resultsIterator.Close()

	var assets []*Asset
	for resultsIterator.HasNext() {
		queryResponse, err := resultsIterator.Next()
		if err != nil {
			return nil, err
		}

		var asset Asset
		err = json.Unmarshal(queryResponse.Value, &asset)
		if err != nil {
			return nil, err
		}
		if asset.SC == sc_num{
			assets = append(assets, &asset)
		}
		
	}

	return assets, nil
}




// // GetAllAssets returns all assets found in world state
// func (s *SmartContract) GetAllAssets(ctx contractapi.TransactionContextInterface) ([]*Asset, error) {
// 	// range query with empty string for startKey and endKey does an
// 	// open-ended query of all assets in the chaincode namespace.

// 	resultsIterator, err := ctx.GetStub().GetStateByRange("", "")
// 	if err != nil {
// 		return nil, err
// 	}
// 	defer resultsIterator.Close()

// 	var assets []*Asset
// 	for resultsIterator.HasNext() {
// 		queryResponse, err := resultsIterator.Next()
// 		if err != nil {
// 			return nil, err
// 		}

// 		var asset Asset
// 		err = json.Unmarshal(queryResponse.Value, &asset)
// 		if err != nil {
// 			return nil, err
// 		}
// 		if asset.SC == "1"{
// 			assets = append(assets, &asset)
// 		}
		
// 	}

// 	return assets, nil
// }


// CreateAsset issues a new asset to the world state with given details.
func (s *SmartContract) CreateAsset(ctx contractapi.TransactionContextInterface, user_id string) error {
	
	// test := []string{"`", user_id ,"`"}
	// test_val := strings.Join(test, " ")
	// fmt.Println(test_val)

	var data []Asset
	err := json.Unmarshal([]byte(user_id), &data)
	if err!= nil{
		return err
	}


	// for range start!!
	for _, json_val := range data{
		exists, err := s.AssetExists(ctx, json_val.User_id)
		if err != nil {
			return err

		}
		
		if exists {
			return fmt.Errorf("the asset %s already exists", json_val.User_id)
		}

		assetJSON, err := json.Marshal(json_val)
		if err != nil {
			return err
		}
		return ctx.GetStub().PutState(json_val.User_id, assetJSON)
	}
	return nil
}

// // CreateAsset issues a new asset to the world state with given details.
// func (s *SmartContract) CreateAsset(ctx contractapi.TransactionContextInterface, user_id string, pc_id string, date string, event string, sc string) error {
	
	
// 	exists, err := s.AssetExists(ctx, user_id)
// 	if err != nil {
// 		return err
// 	}
// 	if exists {
// 		return fmt.Errorf("the asset %s already exists", user_id)
// 	}

// 	asset := Asset{
// 		User_id:        user_id,
// 		Pc_id:          pc_id,
// 		Date:           date,
// 		Event:          event,
// 		SC:             sc,
// 	}
// 	assetJSON, err := json.Marshal(asset)
// 	if err != nil {
// 		return err
// 	}
// 	return ctx.GetStub().PutState(user_id, assetJSON)
// }

// ReadAsset returns the asset stored in the world state with given id.
func (s *SmartContract) ReadAsset(ctx contractapi.TransactionContextInterface, user_id string) (*Asset, error) {
	assetJSON, err := ctx.GetStub().GetState(user_id)
	if err != nil {
		return nil, fmt.Errorf("failed to read from world state: %v", err)
	}
	if assetJSON == nil {
		return nil, fmt.Errorf("the asset %s does not exist", user_id)
	}

	var asset Asset
	err = json.Unmarshal(assetJSON, &asset)
	if err != nil {
		return nil, err
	}

	return &asset, nil
}

// // UpdateAsset updates an existing asset in the world state with provided parameters.
// func (s *SmartContract) UpdateAsset(ctx contractapi.TransactionContextInterface, id string, color string, size int, owner string, appraisedValue int) error {
// 	exists, err := s.AssetExists(ctx, id)
// 	if err != nil {
// 		return err
// 	}
// 	if !exists {
// 		return fmt.Errorf("the asset %s does not exist", id)
// 	}

// 	// overwriting original asset with new asset
// 	asset := Asset{
// 		ID:             id,
// 		Color:          color,
// 		Size:           size,
// 		Owner:          owner,
// 		AppraisedValue: appraisedValue,
// 	}
// 	assetJSON, err := json.Marshal(asset)
// 	if err != nil {
// 		return err
// 	}

// 	return ctx.GetStub().PutState(id, assetJSON)
// }



// // DeleteAsset deletes an given asset from the world state.
// func (s *SmartContract) DeleteAsset(ctx contractapi.TransactionContextInterface, id string) error {
// 	exists, err := s.AssetExists(ctx, id)
// 	if err != nil {
// 		return err
// 	}
// 	if !exists {
// 		return fmt.Errorf("the asset %s does not exist", id)
// 	}

// 	return ctx.GetStub().DelState(id)
// }

// AssetExists returns true when asset with given ID exists in world state
func (s *SmartContract) AssetExists(ctx contractapi.TransactionContextInterface, id string) (bool, error) {
	assetJSON, err := ctx.GetStub().GetState(id)
	if err != nil {
		return false, fmt.Errorf("failed to read from world state: %v", err)
	}

	return assetJSON != nil, nil
}

// // TransferAsset updates the owner field of asset with given id in world state.
// func (s *SmartContract) TransferAsset(ctx contractapi.TransactionContextInterface, id string, newOwner string) error {
// 	asset, err := s.ReadAsset(ctx, id)
// 	if err != nil {
// 		return err
// 	}

// 	asset.Owner = newOwner
// 	assetJSON, err := json.Marshal(asset)
// 	if err != nil {
// 		return err
// 	}

// 	return ctx.GetStub().PutState(id, assetJSON)
// }

