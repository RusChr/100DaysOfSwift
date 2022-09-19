import UIKit

var teams = [String: String]()
teams["Paul"] = "Red"

var results = [Int]()
var scores = Array<Int>()

var words = Set<String>()
var numbers = Set<Int>()

//my tests
results = [1, 3, 5, 2, 4, 9]

var arrAny = [Any]()
arrAny = [1, true, "String", 3.14, words, results]

arrAny.forEach { a in
    print(a)
}
