var express = require('express');
var request = require("request");
var session = require('express-session');
var mysql = require('mysql');
var bodyParser = require('body-parser');
var multer = require('multer');
var bcrypt = require('bcrypt');
var app = express();


app.use(express.static("css"));
app.use(express.static('public'));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(session({
    secret: 'top secret code!',
    resave: true,
    saveUninitialized: true
}));

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'admin',
    password: 'admin',
    database: 'webstoredb'
});
// connection.connect();

app.set('view engine', 'ejs');


app.get('/', function(req, res) {
    res.render('home');
});

/* Error Route*/
app.get('*', function(req, res) {
    res.render('error');
});

app.listen(process.env.PORT || 3000, function() {
    console.log('Server has been started');
})