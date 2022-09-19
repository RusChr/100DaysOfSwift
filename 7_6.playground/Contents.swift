import UIKit

func travel() -> (String) -> Void {
    var counter = 1
    return {
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}

let result = travel()

result("London")
result("London")
result("London")


//test

var previousNumber = 0 // Данная переменная создается извне замыкания, чтобы оно могло ее захватить. Иначе, создав эту переменную внутри замыкания (строка 24, примерно), данная переменная будет создаваться каждый раз по-новому.

func makeRandomNumberGenerator() -> () -> Int {
    return {
        //var previousNumber = 0 // Почему здесь закомментировано - читай выше!
        var newNumber: Int
        
        repeat {
            newNumber = Int.random(in: 1...3)
        } while newNumber == previousNumber
        
        previousNumber = newNumber
        return newNumber
    }
}

let generator = makeRandomNumberGenerator()

for _ in 1...10 {
    print(generator())
}
