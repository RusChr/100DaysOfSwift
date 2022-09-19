import UIKit

func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}

travel { (place: String) -> String in
    return "I'm going to \(place) in my car"
}

//test
print()

travel { str in
    return "I'm going to \(str) in my car"
}

//
print()

func reduceTest(_ values: [Int], using closure: (Int, Int) -> Int) -> Int {
    var current = values[0] // Это не хорошо, т.к. при передаче пустого массива, будет краш. Здесь это только для учебного примера.
    
    for value in values[1...] {
        current = closure(current, value)
    }
    
    return current
}

let numbers = [10, 20, 30, 40]

let sum = reduceTest(numbers) { runningTotal, next in
    runningTotal + next // return можно опустить, если только одна строка с return
}
print(sum)

let sum2 = reduceTest(numbers, using: +) //!!! "+" - это функция, кот. принимает (Int, Int) -> Int, поэтому можно делать такое (-, *, / и т.д.).
print(sum2)

//
