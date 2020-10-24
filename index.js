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
app.get('/', async function(req, res) {
    
    let stmt = 'SELECT * FROM items inner join users on userId = sellerId';
    
    let cart_items = [];
    
    if(req.session.authenticated) {
        
        let cart_stmt = 'select * from cart where userId = ?';
        
        let cart_data = [req.session.sellerId];
        
        
        cart_items = await query(cart_stmt, cart_data);
        
        
        
    }
    
    
    connection.query(stmt, function(error, results) {
        if (error) throw error;
        if (results.length) {
            // console.log(results)
            res.render("home", { results: results, userauth: req.session.authenticated, cart_items : cart_items });
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
    res.render('register', {usernameTaken : false});
});

app.post('/register', async function(req, res){
    
    let user_stmt = 'select * from users where username = ?';
    let user_data = [req.body.username];
    
    let user = await query(user_stmt, user_data);
    
    if(user.length != 0) {
        res.render('register', {usernameTaken : true});
    } else {
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
    }
    
});

app.get('/profile', isAuthenticated, async function(req, res) {
    let stmt = 'select * from users where userId = ?';
    let data = [req.session.sellerId];
    
    let q = await query(stmt, data);
    
    res.render('profile', { user : q } );
    
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
       res.redirect('/welcome');
    });
});

app.get('/item/:itemId', async function(req, res) {
    
    let stmt = 'select * from items inner join users on userId = sellerId where itemId = ?';
    
    let data = [req.params.itemId];
    
    // console.log(data);
    
    let q = await query(stmt, data);
    
    // console.log(q);
    
    let cart_stmt = 'select * from cart where userId = ?';
        
    let cart_data = [req.session.sellerId];
    
    
    let cart_items = await query(cart_stmt, cart_data);
    
    
    res.render('item',  { results: q, userauth: req.session.authenticated, cart_items : cart_items } );
    
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
app.get('/items', isAuthenticated, async function(req, res){
    
    
    let stmt = 'SELECT * FROM items inner join users on userId = sellerId where sellerId=?';
    let data = [req.session.sellerId];
    
    connection.query(stmt,data, function(error, results) {
        if (error) throw error;
            // console.log(results)
            res.render("items", { results: results, userauth: req.session.authenticated });
    });
    
    
});
app.get('/updateitem/:itemId',isAuthenticated, async function(req, res){
  let stmt='select * from items where itemId=?';
  let data=[req.params.itemId];
  let q = await query(stmt, data);
  
  res.render("updateitem",{result:q});
});

app.post('/updateitem', function(req, res){
    let stmt= ' update items set itemlink=?, itemname=?, color=?, category=?, unitsleft=?, price=?, description=? where itemId=?'
    let data= [req.body.itemlink, req.body.itemname, req.body.color, req.body.category, parseInt(req.body.unitsleft), parseInt(req.body.price), req.body.desc, req.body.itemId];
    connection.query(stmt, data, function(error, result){
       if(error) throw error;
       res.redirect('/items');
    });
});

app.post('/removeitem', async function(req, res) {
    
    let stmt = 'delete from items where itemId = ?';
    
    let data = [req.body.itemId];
    
    console.log(data);
    let del='select * from cart where itemId=? ';
    let carts= await query(del,data);
    let q = await query(stmt, data);
    for(var i=0; carts.length>i;i++){
        let cart='delete from cart where itemId=?';
        let sdata=[q[i].itemId];
        
      await query(cart, sdata);
    }    
    console.log(q);
    
    res.redirect("/items");
    
});


app.get('/item/:itemId', async function(req, res) {
    
    let stmt = 'select * from items where itemId = ?';
    
    let data = [req.params.itemId];
    
    console.log(data);
    
    let q = await query(stmt, data);
    
    console.log(q);
    
    // res.render("/item", );
    
})

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
    
    // console.log(r);
    
    // console.log(req.body.leng);

    console.log(r.length);

    for(var i = 0; i < req.body.leng; i++) {
        
        // console.log(req.body["name" + i],  " : ", r[i].itemId);
        // console.log();
        // console.log("\n");
        
        // console.log(Object.assign("name"+i, req.body));
        
        let up_stmt = 'update cart set units = ? where cartId = ?';
        let up_data = [req.body["name" + i], r[i].cartId];
        
        let up_query = await query(up_stmt, up_data);
        
        // console.log(up_query, "from : ", r[i].units);
        

        
    }
    
    res.redirect('/cart');
    
});
app.post("/removeitem", function(req, res) {
   
   
    
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


app.post('/removefromcart', async function(req, res) {
    
    let stmt = 'delete from cart where cartId = ?';
    
    // let s = 'select * from cart';
    
    // let se = await query(s, []);
    
    // console.log(se);
    
    let data = [req.body.cartId];
    
    console.log(req.query);
    
    console.log(data[0], "ofdiewnifw");
    
    let q = await query(stmt, data);
    
    // console.log(q);
    
    res.redirect("/cart");
    
})


/* Checkout Routes */
app.get('/checkout', isAuthenticated, function(req, res){

    let cart_stmt = 'select * from items natural join cart where cart.userId = ?';
    let cart_data = [req.session.sellerId];
    
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

app.post('/receipt', async function(req, res){
    
    let cart_stmt = 'select * from items natural join cart where cart.userId = ?';
    let cart_data = [req.session.sellerId];
    
    let user_items = await query(cart_stmt, cart_data);
    
    
    let up_stmt = 'update items set unitsleft = unitsleft - ? where itemId = ?';
    
    let oh_stmt = 'insert into orderhistory (userId, itemId, itemlink, itemname, color, category, unitspurchased, price, description, datepurchased) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'; 
    
    // let stmt = 'INSERT INTO items (sellerId, itemlink, itemname, color, category, unitsleft, price, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?)';
    
    let de_stmt = 'delete from cart where cartId = ?';
    
    let date_now = Date();
    
    var date = date_now.toString().substr(0, 24);
    
    for(var i = 0; i < user_items.length; i++) {
        
        let up_data = [user_items[i].units, user_items[i].itemId];
        
        let oh_data = [req.session.sellerId, user_items[i].itemId, user_items[i].itemlink, user_items[i].itemname, user_items[i].color, user_items[i].category, user_items[i].units, user_items[i].price, user_items[i].description, date];
        
        let de_data = [user_items[i].cartId];
        
        console.log(user_items[i].unitsleft);
        
        await query(up_stmt, up_data);
        
        await query(oh_stmt, oh_data);
        
        await query(de_stmt, de_data);
        
    }
    
   res.redirect('/orderhistory');
});


app.get('/orderhistory', isAuthenticated, async function(req, res){
    
    
    let date_stmt = 'select distinct datepurchased from orderhistory where userId = ?';
    
    let oh_stmt = 'select * from orderhistory where userId = ?';
    
    let data = [req.session.sellerId];
    
    let dates = await query(date_stmt, data);
    
    let history = await query(oh_stmt, data);
    
    
    // console.log(dates);
    
    // console.log(history);
    
    
    res.render('orderhistory', { dates : dates, history : history });
    
    //render
    
    // var date = Date();
    
    // console.log(date.toString().substr(0, 23));
    // console.log(date.toString().substr(0, 24));
    // console.log(date.toString().substr(0, 26));
    
    
//   res.render('orderhistory', {user: req.session.user}); 
});

app.get('/searchkeywords', isAuthenticated, function(req, res) {
    
  res.render("searchkeywords", {cart_items : []});
  
});

app.post("/searchkeywords", function(req, res) {
    
    let words = req.body.words;
    
    res.redirect("searchkeywords/" + words);
    
});

app.get('/searchkeywords/:words', isAuthenticated, async function(req, res) {
    
    // let stmt = 'select * from items where itemname LIKE `%?%` or color LIKE `%?%` or description LIKE `%?%`;
    
    let stmt = 'select * from items inner join users on userId = sellerId where itemname LIKE \'%' + req.params.words + '%\' or color LIKE \'%' + req.params.words + '%\' or description LIKE \'%' + req.params.words + '%\'';
    
    let cart_stmt = 'select * from cart where userId = ?';
        
    let cart_data = [req.session.sellerId];
    
    
    let cart_items = await query(cart_stmt, cart_data);
    
    // let data = [req.params.words, req.params.words, req.params.words];
    
    connection.query(stmt, function(error, result) {
       if (error) throw error;
       res.render("searchkeywords", { results: result, cart_items : cart_items });
    });
    
});

app.get('/searchcategory', isAuthenticated, function(req, res) {
    
  res.render("searchcategory", {cart_items : []});
  
});

app.post('/searchcategory', function(req, res) {
    let category = req.body.category;
    
    res.redirect("searchcategory/" + category);
  
});


app.get('/searchcategory/:category', isAuthenticated, async function(req, res) {
    
    let stmt = 'select * from items inner join users on userId = sellerId where category = ?';
    let data = [req.params.category];
    
    let cart_stmt = 'select * from cart where userId = ?';
    
    let cart_data = [req.session.sellerId];
    
    
    let cart_items = await query(cart_stmt, cart_data);
    
    
    connection.query(stmt, data, function(error, result) {
       if (error) throw error;
       res.render("searchcategory", { results: result, cart_items : cart_items });
    });
    
});

/* Error Route*/
app.get('*', function(req, res){
   res.render('error'); 
});

app.listen(process.env.PORT || 3000, function(){
    console.log('Server has been started');
})