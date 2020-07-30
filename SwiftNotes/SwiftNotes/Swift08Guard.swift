//
//  Swift08Guard.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/24.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift08Guard: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// guard 语句
        /*
        - `guard` 语句，类似于 `if` 语句，基于布尔表达式来执行语句。
        - 使用 `guard` 语句来要求一个条件必须是真才能执行 `guard` 之后的语句。
        - 与 `if` 语句不同，`guard` 语句总是有一个 `else` 分句，`else` 分句里的代码会在条件不为真的时候执行。
       */
        
        // 判断 IP 地址的合法性
        func isIPAddress(ipAddress: String) -> (Int, String) {
            let compoments = ipAddress.split(separator: ".")
            
            guard compoments.count == 4 else {
                return (100, "ip 只能有四部分")
            }
            
            guard let first = Int(compoments[0]), first >= 0 && first < 256 else {
                return (1, "第一个数不对")
            }
            
            guard let second = Int(compoments[1]), second >= 0 && second < 256 else {
                return (2, "第二个数不对")
            }
            
            guard let third = Int(compoments[1]), third >= 0 && third < 256 else {
                return (3, "第三个数不对")
            }
            
            guard let fourth = Int(compoments[1]), fourth >= 0 && fourth < 256 else {
                return (4, "第四个数不对")
            }
            
            return (0, "ip 地址合法")
        }
        print(isIPAddress(ipAddress: "1.2.3.4"))
        
        
        /// 模式分类
        /*
        - 通配符模式（Wildcard Pattern）
        - 标识符模式（Identifier Pattern）
        - 值绑定模式（Value-Binding Pattern）
        - 元组模式（Tuple Pattern）
        - 枚举用例模式（Enumeration Case Pattern）
        - 可选项模式（Optional Pattern）
        - 类型转换模式（Type-Casting Pattern）
        - 表达式模式（Expression Pattern）
        */
        
        // （1）通配符模式由一个下划线（_）构成，用于匹配并忽略任何值
        for _ in 1...3 {
            // ...
        }
        
        // （2）标识符模式匹配任何值，并将匹配的值和一个变量或常量绑定起来
        let someValue = 42
        print(someValue)
        
        // （3）值绑定模式把匹配到的值绑定给一个变量或者常量。
        let point = (1, 2)
        switch point {
        case let (x, y): // 将 point 中的元素绑定到 x 和 y
            print("The point is at (\(x), \(y)).")
        }
        
        // （4）元组模式是由逗号分隔的，具有零个或多个模式的列表，并由一对圆括号括起来。元组模式匹配相应元组类型的值。
        // 可以使用类型标准去限制一个元组模式能匹配哪种元组类型。例如，在常量声明 let (x, y):(Int, Int) = (1, 2) 中的元组模式 (x, y):(Int, Int) 只匹配两个元素都是 Int 类型的元组。
        // 当元组模式被用于 for-in 语句或者变量和常量声明时，它仅可以包含通配符模式、标识符模式、可选模式或者其他包含这些模式的元组模式。
        let points = [(0, 0), (0, 1), (1, 0), (1, 1)]
        for (x, y) in points where y == 0 {
            print("(\(x), 0)")
        }
        
        // （5）枚举用例模式匹配现有的某个枚举类型的某个用例。枚举用例模式出现在 switch 语句中的 case 标签中，以及 if、while、guard、for-in 语句的 case 条件中。
        
        // 可选项模式匹配 Optional<Wrapped> 枚举在 some(Wrapped) 中包装的值。
        // 可选项模式为 for-in 语句提供了一种迭代数组的简便方式，只为数组中非 nil 的元素执行循环体。
        let someOptional: Int? = 42
        // Match using an enumeration case pattern.
        if case .some(let x) = someOptional {
            print(x)
        }
        
        // Match using an optional pattern.
        if case let x? = someOptional {
            print(x)
        }
        
        let array: [Int?] = [nil, 2, 3, nil, 5]
        // Match only non-nil values.
        for case let number? in array {
            print("Found a \(number)")
        }
        
        // （6）有两种类型转换模式，is 模式和 as 模式。is 模式只出现在 switch 语句中的 case 标签中。如下：
        // - is 类型
        // - 模式 as 类型
        // is 模式仅当一个值的类型在运行时和 is 模式右边的指定类型一致，或者是其子类的情况下，才会匹配这个值。is 模式和 is 运算符有相似表现，它们都进行类型转换，但是 is 模式没有返回类型。
        // as 模式仅当一个值的类型在运行时和 as 模式右边的指定类型一致，或者是其子类的情况下，才会匹配这个值。如果匹配成功，被匹配的值的类型被转换成 as 模式右边指定的类型。
        let animals:[Any] = [Dog(runSpeed: 55), Bird(flighHeight: 2000), Fish(depth: 100)]
        for animal in animals {
            switch animal {
            case let dog as Dog:
                print("\(dog.name) can run \(dog.runSpeed)")
            case let fish as Fish:
                print("\(fish.name) can dive depth \(fish.depth)")
            case is Bird:
                print("bird can fly!")
            default:
                print("unknow animal!")
            }
        }
        
        // （7）表达式模式代表表达式的值，只出现在 switch 语句中的 case 标签中。
        let onePoint = (1, 1)
        switch onePoint {
        case (0, 0):
            print("(0, 0) is at the origin.")
        case (-2...2, -2...2):
            print("(\(onePoint.0), \(onePoint.1)) is near the origin.")
        default:
            print("The point is at (\(onePoint.0), \(onePoint.1)).")
        }
        
        // 可以重载 ~= 运算符来提供自定义的表达式匹配行为。
        /*
            func ~= (pattern: String, value: Int) -> Bool {
                return pattern == "\(value)"
            }
         
             switch onePoint {
             case ("0", "0"):
                 print("(0, 0) is at the origin.")
             default:
                 print("The point is at (\(onePoint.0), \(onePoint.1)).")
             }
        */
        let e = Employee(salary: 9999)
        switch e.salary {
        case 0...1000:
            print("艰难生活")
        case 1000...5000:
            print("小康生活")
        case 5000...10000:
            print("活得很滋润")
        default:
            print("土豪")
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


protocol Animal {
    var name: String { get }
}

struct Dog: Animal {
    var name: String {
        return "dog"
    }
    var runSpeed: Int
}

struct Bird: Animal {
    var name: String {
        return "bird"
    }
    var flighHeight: Int
}

struct Fish: Animal {
    var name: String {
        return "fish"
    }
    var depth: Int
}


struct Employee {
    var salary: Float
}

extension Employee {
    static func ~= (lhs: Range<Float>, rhs: Employee) -> Bool {
        return lhs.contains(rhs.salary)
    }
}




