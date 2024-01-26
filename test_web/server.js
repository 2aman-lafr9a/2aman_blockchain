const express = require('express');
const path = require('path');
const app = express();

app.get("/",(req , res) =>{
    res.sendFile(path.join(__dirname+'/index.html'));
})

app.get("/teamManager",(req , res) =>{
    res.sendFile(path.join(__dirname+'/team_manager.html'));
})
app.get("/teamManager2",(req , res) =>{
    res.sendFile(path.join(__dirname+'/team_manager2.html'));
})

app.get("/agence",(req , res) =>{
    res.sendFile(path.join(__dirname+'/agence.html'));
})
app.get("/agence2",(req , res) =>{
    res.sendFile(path.join(__dirname+'/agence2.html'));
})
app.get("/sign",(req , res) =>{
    res.sendFile(path.join(__dirname+'/Sign.html'));
})
const server = app.listen(5000);
const portNumber = server.address().port;
console.log("port: " ,portNumber);