import UIKit

let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanila"
]

favoriteIceCream["Paul"]
favoriteIceCream["Charlotte"]
favoriteIceCream["Charlotte", default: "Unknown"]

//tests
let ratings = [1: "Bad", 2: "OK", 3: "Good"]
//let rating = ratings["2"] //error

let ships = ["Star Trek", "Enterprise"]
type(of: ships)

let olympics = [2012: "London", 2016: "Rio", 2020: "Tokio"]
let london = olympics[2012]
