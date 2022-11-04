const express = require( 'express' )
const bodyParser = require( 'body-parser' )
const mysql = require( 'mysql' )
const cors = require('cors')
const path = require( 'path' )

const app = express()

app.use( express.static( path.join(__dirname , '/public' ) ) )

app.get( '/category', (req, res) => {
    res.sendFile('/public/index.html', { root: __dirname })
})

app.get( '/product', (req, res) => {
    res.sendFile('/public/index.html', { root: __dirname })
})

app.get( '/receipt', (req, res) => {
    res.sendFile('/public/index.html', { root: __dirname })
})

app.get( '/login', (req, res) => {
    res.sendFile('/public/index.html', { root: __dirname })
})

// 

const port = process.env.PORT || 5000

app.use( bodyParser.urlencoded( { extended: false } ) )

app.use( bodyParser.json() )

// MYSQL
const db = mysql.createConnection({
    host             : 'localhost',
    user             : 'root',
    password         : '',
    database         : 'toy_inventory'
})

db.connect( err => {
    if( err ) {
        throw err
    }

    console.log( 'MySql Connected...' )
})

// listen on environment port
app.listen( port, () => {
    console.log( `listen on port ${ port }` )
})

app.use(function(req, res, next) {
    res.header( 'Access-Control-Allow-Origin', '*' )
    res.setHeader( 'Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE' )
    res.header( 'Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept' )
    next()
 })

// category api
app.get( '/get-category', cors(), ( req, res ) => {
    let sql = `SELECT * FROM category WHERE deleted = 0`
    db.query( sql, ( err, result ) => {
        if( err ) {
            throw err
        }
        res.send( result )
    })
})

app.post( '/add-category', cors(), ( req, res ) => {
    const { name, supplier, code } = req.body
    let post = { name, supplier, code }
    let sql = `INSERT INTO category set ?`
    db.query( sql, post, ( err, result ) => {
        if( err ) {
            throw err
        }
        res.send( result )
    })
})

app.post( '/put-category/:id', cors(), ( req, res ) => {
    const { name, supplier, code } = req.body
    let sql = `UPDATE category SET name = '${ name }', supplier = '${ supplier }', code = '${ code }' WHERE id = ${ req.params.id }`
    db.query( sql, ( err, result ) => {
        if( err ) {
            throw err
        }
        res.send( result )
    })
})

app.post( '/delete-category/:id', cors(), ( req, res ) => {
    let sql = `UPDATE category SET deleted = 1 WHERE id = ${ req.params.id }`
    db.query( sql, ( err, result ) => {
        if( err ) {
            throw err
        }
        res.send( result )
    })
})


// product api
app.get( '/get-product', cors(), ( req, res ) => {
    let sql = 
            `SELECT p.*, c.id as category_id, c.code FROM product p
            LEFT JOIN category c ON p.category_id = c.id 
            WHERE p.deleted = 0`
    db.query( sql, ( err, result ) => {
        if( err ) {
            throw err
        }
        res.send( result )
    })
})

app.post( '/add-product', cors(), ( req, res ) => {
    const { name, category_id, stock, investment, total_investment, selling, exp_return } = req.body
    let post = { name, category_id, stock, investment, total_investment, selling, exp_return  }
    let sql = `INSERT INTO product set ?`
    db.query( sql, post,( err, result ) => {
        if( err ) {
            throw err
        }

        let hsql = `INSERT INTO product_stock_history set ?`
        let hpost = { product_id: result.insertId , stock_history: stock, add_or_less_stock: stock,  }
        db.query( hsql, hpost )
        res.send( result )
    })
})

app.post( '/put-product/:id', cors(), ( req, res ) => {
    const { 
        name, category_id, stock, investment, total_investment, selling, exp_return, 
        stock_history, add_or_less_stock, receipt_ref_num, receipt_for, purchase_amount, description
    } = req.body
    
    let sql = `UPDATE product SET stock = ${ stock }, name = '${ name }', category_id = ${ category_id }, investment = '${ investment }', total_investment = '${ total_investment }', selling = '${ selling }', exp_return = '${ exp_return }' WHERE id = ${ req.params.id }`

    db.query( sql, ( err, result ) => {
        if( err ) {
            throw err
        }

        if( add_or_less_stock !== undefined ) {
            let history = { 
                product_id: req.params.id, stock_history, add_or_less: 0, 
                add_or_less_stock, receipt_ref_num, receipt_for, purchase_amount, description 
            }
            let hsql = `INSERT INTO product_stock_history set ?`
            db.query( hsql, history )
        }

        res.send( result )
    })
})

app.post( '/delete-product/:id', cors(), ( req, res ) => {
    let sql = `UPDATE product SET deleted = 1 WHERE id = ${ req.params.id }`
    db.query( sql, ( err, result ) => {
        if( err ) {
            throw err
        }
        res.send( result )
    })
})

// receipt
app.get( '/load-receipt', cors(), ( req, res ) => {
    let sql = 
            `SELECT ph.*, p.id as p_id, p.name as p_name, p.stock as current_stock ,p.selling as selling FROM product_stock_history ph
            LEFT JOIN product p ON ph.product_id = p.id 
            WHERE ph.receipt_ref_num != 'NULL' AND ph.deleted = 0 ORDER BY ph.date_time DESC`
    db.query( sql, ( err, result ) => {
        if( err ) {
            throw err
        }
        res.send( result )
    })
})

app.post( '/put-receipt/:id', cors(), ( req, res ) => {
    const { 
        add_or_less_stock, description, purchase_amount, receipt_for , stock, pid
    } = req.body
    let sql = `UPDATE product_stock_history SET add_or_less_stock = ${ add_or_less_stock }, description = '${ description }', purchase_amount = ${ purchase_amount },receipt_for = '${ receipt_for }', stock_history = ${ stock } WHERE id = ${ req.params.id }`
    db.query( sql, ( err, result ) => {
        if( err ) {
            throw err
        }

        let sqlP = `UPDATE product SET stock = ${ stock } WHERE id = ${ pid }`
        db.query( sqlP ) 
        res.send( result )
    })
})

app.post( '/delete-receipt/:id', cors(), ( req, res ) => {
    let sql = `UPDATE product_stock_history SET deleted = 1 WHERE id = ${ req.params.id }`
    db.query( sql, ( err, result ) => {
        if( err ) {
            throw err
        }
        res.send( result )
    })
})

// login 
app.post( '/login', cors(), ( req, res ) => {
    const { 
        username, password
    } = req.body
    let sql = `SELECT * FROM users WHERE username = '${ username }' AND password = '${ password }'`
    db.query( sql, ( err, result ) => {
        if( err ) {
            throw err
        }
        res.send( result )
    })
})

app.post( '/delete-receipts', cors(), ( req, res ) => {
    const { selected } = req.body
    let sql = `UPDATE product_stock_history SET deleted = 1 WHERE id IN (${ selected.join(',') })`
    db.query( sql, ( err, result ) => {
        if( err ) {
            throw err
        }
        res.send( result )
    })
})