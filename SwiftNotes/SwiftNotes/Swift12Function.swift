//
//  Swift12Function.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/26.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift12Function: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 函数的定义和调用
        
        // 使用关键字 func 定义函数
        func greet(person: String) -> String {
            let greeting = "Hello " + person + "!"
            return greeting
        }
        
        // 函数调用
        let greeting = greet(person: "Allen")
        print(greeting)
        
        // 无形式参数的函数
        func sayHelloWorld() -> String {
            return "Hello, world."
        }
        print(sayHelloWorld())
        
        // 多形式参数的函数
        func greet1(person: String, alreadyGreeted: Bool) -> String {
            if alreadyGreeted {
                return "Hello again," + person + "!"
            }
            return "Hello" + person + "!"
        }
        print(greet1(person: "Allen", alreadyGreeted: true))
        
        // 无返回值的函数
        func greet2(person: String) {
            print("Hello \(person)!")
        }
        greet2(person: "Allen")
        
        // 多个返回值的函数
        func minMax(array: [Int]) -> (min: Int, max: Int)? {
            if array.isEmpty {
                return nil
            }
            
            var currentMin = array[0]
            var currentMax = array[0]
            for value in array[1..<array.count] {
                if value < currentMin {
                    currentMin = value
                } else if value > currentMax {
                    currentMax = value
                }
            }
            return (currentMin, currentMax)
        }
        print(minMax(array: [1, 3, 8, 0, 6]) ?? "")
        
        // 隐式返回的函数：
        // 如果整个函数体是单一的表达式，那么函数隐式返回这个表达式的值。
        func greet3(for person: String) -> String {
            "Hello, " + person + "!"
        }
        print(greet3(for: "Allen"))
        
        
        /// 函数的实际参数和形式参数
        
        // 实际参数名用在调用函数的时候，形式参数名用在函数的实现当中。
        // 默认情况下，实际参数名用形式参数名充当。
        func greet4(person: String, from hometown: String) -> String {
            return "Hello \(person)! Glad you could visit from \(hometown)."
        }
        print(greet4(person: "Allen", from: "Shanghai"))
        
        // 省略实际参数标签
        // 可以使用下划线（_）来为形式参数代替显示的实际参数标签。
        func greet5(_ person: String, from hometown: String) -> String {
            return "Hello \(person)! Glad you could visit from \(hometown)."
        }
        print(greet5("Allen", from: "Shanghai"))
        
        // 默认形式参数值
        // 如果定义了默认值，就可以在调用函数的时候省略这个实际参数。
        func greet6(_ person: String, from hometown: String = "Beijing") -> String {
            return "Hello \(person)! Glad you could visit from \(hometown)."
        }
        print(greet6("Allen"))
        
        // 可变形式参数
        // 可以通过在形式参数的类型名称后边插入三个点符号（...）来书写可变形式参数。
        // 传入到可变形式参数中的值在函数的主体中被当作是对应类型的数组。
        func arithmeticMean(_ numbers: Double...) -> Double {
            var total: Double = 0
            for number in numbers {
                total += number
            }
            return total / Double(numbers.count)
        }
        print(arithmeticMean(1.0, 2.0, 3.0))
        print(arithmeticMean(1.0, 2.0, 3.0, 4.0, 5.0))
        
        // 输入输出形式参数
        // 使用 inout 关键字来定义一个输入输出形式参数。
        // 只能把变量作为输入输出形式参数的实际参数，调用的时候直接在它前面添加一个 & 符号来明确可以被函数修改。
        // 输入输出形式参数不能有默认值，可变形式参数不能标记为 inout。
        func swapTwoInts(_ a: inout Int, _ b: inout Int) {
            let temp = a
            a = b
            b = temp
        }
        var a = 1
        var b = 2
        swapTwoInts(&a, &b)
        print(a)
        print(b)
        
        
        /// 函数类型和内嵌函数（待定）
        
        
        /// 高阶函数
        
        // map 函数
        // 对于原始集合里的每一个元素，以一个变换后的元素替换之形成一个新的集合。
        let numbers = [1, 2, 3, 4, 5]
        print(numbers.map { $0 * 10 })
        
        // filter 函数
        // 对于原始集合里的每一个元素，通过判定来将其丢弃或者放进新的集合。
        let numbers1 = [1, 2, 3, 4, 5]
        print(numbers1.filter { $0 > 3 })
        
        // reduce 函数
        // 对于原始集合里的每一个元素，作用于当前累积的结果上。
        let numbers2 = [1, 2, 3, 4, 5]
        print(numbers2.reduce(100) { $0 + $1 })
        
        // flatMap 函数
        // 对于元素是集合的集合，可以得到单级的集合。
        let results = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        let allResults = results.flatMap { $0.map { $0 * 10 } }
        let passMarks = results.flatMap { $0.filter { $0 > 5 } }
        print(allResults)
        print(passMarks)
        
        // compactMap 函数
        // 过滤空值
        let keys: [String?] = ["zhangsan", nil, "lisi", nil, "wangwu"]
        let validNames = keys.compactMap { $0 }
        print(validNames)
        
        let counts = keys.compactMap { $0?.count }
        print(counts)
        
        
        /// 类型方法
        
        // 通过在 func 关键字之前使用 static 关键字来明确一个类型方法。类同样可以使用 class 关键 字来允许子类重写父类对类型方法的实现。
        class SomeClass {
            class func someTypeMethod() {
                // do something
            }
        }
        SomeClass.someTypeMethod()
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
