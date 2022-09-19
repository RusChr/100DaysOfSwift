import UIKit

class Vehicle {
    var wheels: Int
    init(wheels: Int) {
        self.wheels = wheels
    }
}

class Truck: Vehicle {
    var goodsCapacity: Int
    init(wheels: Int, goodsCapacity: Int) {
        self.goodsCapacity = goodsCapacity
        super.init(wheels: wheels)
    }
}

let truck = Truck(wheels: 4, goodsCapacity: 10)
truck.goodsCapacity
truck.wheels

//

class Singer {
    var name = "Taylor Swift"
}
let singer = Singer()
singer.name

let singerCopy = singer
singerCopy.name = "Justin Bieber"

singer.name
singerCopy.name

//

struct SingerStruct {
    var name = "Aaa Bbb"
}
let singerStruct = SingerStruct()
singerStruct.name

var singerStructCopy = singerStruct
singerStructCopy.name = "Ccc Ddd"

singerStruct.name
singerStructCopy.name

// properties mutating: classes vs structs

class TestClass {
    var name = "Class"
    let age = 8
}
let testClass = TestClass()
testClass.name = "TestClass"
//testClass.age = 10 // Error: let age = 8
//

struct TestStruct {
    var name = "Struct"
    let age = 18
}
let testStruct = TestStruct()
//testStruct.name = "TestStruct" // Error: let testStruct = TestStruct()
