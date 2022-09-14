var sdk = require('../app.js');

module.exports = function(app) {

    app.get('/GetAllAssets', function (req, res) {
        var sc = req.query.SC;
        let args = [sc];
        sdk.send(false, 'GetAllAssets', args, res);
    });

    app.get('/AssetExists', function (req, res) {
        var id = req.query.id;
        let args = [id];
        sdk.send(false, 'AssetExists', args, res);
    });

    app.get('/DeleteAsset', function (req, res) {
        var id = req.query.id;
        let args = [id];
        sdk.send(true, 'DeleteAsset', args, res);
    });

    app.get('/InitLedger', function (req, res) {
        let args = [];
        sdk.send(true, 'InitLedger', args, res);
    });

    app.get('/ReadAsset', function (req, res) {
        var id = req.query.id;
        let args = [id];
        sdk.send(false, 'ReadAsset', args, res);
    });

    app.get('/TransferAsset', function (req, res) {
        var id = req.query.id;
        var newOwner = req.query.newOwner;
        let args = [id, newOwner];
        sdk.send(true, 'TransferAsset', args, res);
    });

    app.get('/CreateAsset', function (req, res) {

        console.log("***********************************CREATE ASSETSSSS *********************************")
        var id = req.query.id;
        let args = [id]
        
        // var args = id
        console.log(args)
        // var color = req.query.color;
        // var size = req.query.size;
        // var owner = req.query.owner;
        // var appraisedValue = req.query.appraisedValue;
        // let args = [id];
        // console.log("***********************************CREATE ARGSSSSSSS *********************************")
        // console.log(args)



        // let args = [id, color, size, owner, appraisedValue];
        sdk.send(true, 'CreateAsset', args, res);
    });

    app.get('/UpdateAsset', function (req, res) {
        var id = req.query.id;
        var color = req.query.color;
        var size = req.query.size;
        var owner = req.query.owner;
        var appraisedValue = req.query.appraisedValue;
        let args = [id, color, size, owner, appraisedValue];
        sdk.send(true, 'UpdateAsset', args, res);
    });
}
