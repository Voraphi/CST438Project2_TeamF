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
app.set('view engine', 'ejs');

// const connection = mysql.createConnection({
//     host: process.env.HOST,
//     user: process.env.USERNAME,
//     password: process.env.PASSWORD,
//     database: process.env.DATABASE
// });
// connection.connect();

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'admin',
    password: 'admin',
    database: 'webstoredb'
});
connection.connect();


/* Middleware */
function isAuthenticated(req, res, next){
    if(!req.session.authenticated) res.redirect('/login');
    else next();
}

function checkUsername(username){
    let stmt = 'SELECT * FROM users WHERE username=?';
    return new Promise(function(resolve, reject){
       connection.query(stmt, [username], function(error, results){
           if(error) throw error;
           resolve(results);
       }); 
    });
}

function checkPassword(password, hash){
    return new Promise(function(resolve, reject){
       bcrypt.compare(password, hash, function(error, result){
          if(error) throw error;
          resolve(result);
       }); 
    });
}


function query(stmt, data) {
    return new Promise(function(resolve, reject) {
        connection.query(stmt, data, function(error, result) {
            if (error) throw error;
            
            resolve(result);
        });
    });
}


/* Home Route*/
app.get('/', function(req, res) {
    
    let stmt = 'SELECT * FROM items';
    
    connection.query(stmt, function(error, results) {
        if (error) throw error;
        if (results.length) {
            // console.log(results)
            res.render("home", { results: results, userauth: req.session.authenticated });
        }
    });
    
});

/* Login Routes */
app.get('/login', function(req, res){
    res.render('login');
});

app.post('/login', async function(req, res){
    let isUserExist   = await checkUsername(req.body.username);
    let hashedPasswd  = isUserExist.length > 0 ? isUserExist[0].password : '';
    let passwordMatch = await checkPassword(req.body.password, hashedPasswd);
    if(passwordMatch){
        req.session.authenticated = true;
        req.session.user = isUserExist[0].username;
        // console.log(isUserExist[0]);
        req.session.sellerId = isUserExist[0].userId;
        // console.log(req.session.sellerId);
        res.redirect('/welcome');
    }
    else{
        res.render('login', {error: true});
    }
});

/* Register Routes */
app.get('/register', function(req, res){
    res.render('register');
});

app.post('/register', function(req, res){
    let salt = 10;
    console.log(req.body.password,req.body.username);
    bcrypt.hash(req.body.password, salt, function(error, hash){
        if(error) throw error;
        let stmt = 'INSERT INTO users (username, password, firstname, lastname) VALUES (?, ?, ?, ?)';
        let data = [req.body.username, hash, req.body.firstname, req.body.lastname];
        connection.query(stmt, data, function(error, result){
           if(error) throw error;
           res.redirect('/login');
        });
    });
});

app.get('/additem',isAuthenticated, function(req, res){
    res.render('additem');
});

app.post('/additem', function(req, res){
    let stmt = 'INSERT INTO items (sellerId, itemlink, itemname, color, category, unitsleft, price, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)';
    // console.log(req.body.price);
    // console.log(req.body.itemlink);
    // console.log(req.body.itemname);
    // console.log(req.body.color);
    // console.log(req.body.category);
    // console.log(req.body.unitsleft);
    // console.log(req.body.desc);
    let data = [req.session.sellerId, req.body.itemlink, req.body.itemname, req.body.color, req.body.category, parseInt(req.body.unitsleft), parseInt(req.body.price), req.body.desc];
    connection.query(stmt, data, function(error, result){
       if(error) throw error;
       res.redirect('/additem');
    });
});

/* cart Routes */
app.get('/cart', isAuthenticated, async function(req, res){
    
    let cart_stmt = 'select * from items natural join cart where cart.userId = ?';
    let cart_data = [req.session.sellerId]
    
    connection.query(cart_stmt, cart_data, function(error, results) {
       if (error) throw error;
       
    //   console.log(results);
       
       res.render('cart', {results : results});
       
    });
    
    
    // let cart_data = [req.session.sellerId];
    
    
    // let result = await query(cart_stmt, cart_data);


    // console.log(result);
    // var items = [];
        
    //     // console.log(result);
        
    // result.forEach(async function (r) {
    //     let item_stmt = 'select * from items where itemId = ?'
    //     let item_data = [r.itemId];
        
    //     let data = await query(item_stmt, item_data);
       
    //     console.log(data[0]);
    //     items.push(Object.values(JSON.parse(JSON.stringify(data[0]))));

        
    // });
    
    // items.forEach(function(v){ console.log(v) });
    
    // console.log(items);
    
    
});

app.post('/updatecart', async function(req, res) {
    
    let cart_stmt = 'select * from items natural join cart where cart.userId = ?';
    let cart_data = [req.session.sellerId];
    
    var r = await query(cart_stmt, cart_data);
    
    // connection.query(cart_stmt, cart_data, function(error, results) {
    //   if (error) throw error;
       
    //   console.log("hmm");
       
    // });
    
    console.log(r);
    
    console.log(req.body.leng);
    
    for(var i = 0; i < req.body.leng; i++) {
        
        
        
    }
    
    res.redirect('/cart');
    
});

/* Logout Route */
app.get('/logout', function(req, res){
   req.session.destroy();
   res.redirect('/');
});

app.post('/addtocart', function(req, res) {
   
   let stmt = 'insert into cart (itemId, userId, units) VALUES (?, ?, ?)';
   
   let data = [parseInt(req.body.itemId), req.session.sellerId, 1];
   
   console.log(data);
   
  connection.query(stmt, data, function(error, result) {
      if (error) throw error;
     
      res.redirect('/');
  });
   
    
});


/* Checkout Routes */
app.get('/checkout', isAuthenticated, function(req, res){
    
      let cart_stmt = 'select * from items natural join cart where cart.userId = ?';
    let cart_data = [req.session.sellerId]
    
    connection.query(cart_stmt, cart_data, function(error, results) {
        if (error) throw error;
       
    //   console.log(results);
       
        // res.render('cart', {results : results});
        res.render('checkout', {results : results});
       
    });
    
});

/* Welcome Route */
app.get('/welcome', isAuthenticated, function(req, res){
   res.render('welcome', {user: req.session.user}); 
});

app.get('/receipt', isAuthenticated, function(req, res){
   res.render('receipt', {user: req.session.user}); 
});

app.get('/orederhistory', isAuthenticated, function(req, res){
   res.render('orederhistory', {user: req.session.user}); 
});

app.get('/searchkeywords', isAuthenticated, function(req, res) {
    
    let stmt = 'select * from items where itemname LIKE %?% or color LIKE %?% or description LIKE %?%';
    let data = [req.body.keyword, req.body.keyword, req.body.keyword];
    
    connection.query(stmt, data, function(error, result) {
       if (error) throw error;
       res.render("searchkeywords", { results: result });
    });
    
});

app.get('/searchcategory', isAuthenticated, function(req, res) {
    
    let stmt = 'select * from items where category LIKE %?%';
    let data = [req.body.category];
    
    connection.query(stmt, data, function(error, result) {
       if (error) throw error;
       res.render("searchcategory", { results: result });
    });
    
});

/* Error Route*/
app.get('*', function(req, res){
   res.render('error'); 
});

app.listen(process.env.PORT || 3000, function(){
    console.log('Server has been started');
})
