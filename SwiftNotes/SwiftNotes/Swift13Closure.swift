//
//  Swift13Closure.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/26.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift13Closure: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 闭包介绍
        
        // 闭包是可以在代码中被传递和引用的功能性独立的代码块。
        // 闭包能够捕获和存储定义在其上下文中的任何变量和常量的引用，这也就是所谓的闭合并包裹那些常量和变量，因此被称为闭包，Swift 能够为你处理所有关于捕获的内存管理的操作。
        // 闭包符合如下三种形式的一种：
        // （1）全局函数是一个有名字但不会捕获任何值的闭包。
        // （2）内嵌函数是一个有名字且能从其上层函数捕获值的闭包。
        // （3）闭包表达式是一个轻量级语法所写的可以捕获其上下文中常量或者变量值的没有名字的闭包。
        
        
        /// 闭包表达式语法
        
        // 闭包表达式语法能够使用常量形式参数、变量形式参数和输入输出形式参数，但不能提供默认值。
        // 可变形式参数也能使用，但需要在形式参数的最后面使用。
        // 元组也可以被用来作为形式参数和返回类型。
        /*
         { (parameters) -> (return type) in
            statements
         }
         */
        
        let names = ["zhangsan", "lisi", "wangwu", "zhaoliu"]
        let sortedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
            return s1 > s2
        })
        print(sortedNames)
        
        // 因排序闭包为实际参数来传递给函数，故 Swift 能推断它的形式参数类型和返回类型。
        // 因为所有的类型都能够被推断，所以返回箭头（->）和围绕在形式参数名周围的括号也能被省略。
        let names1 = ["zhangsan", "lisi", "wangwu", "zhaoliu"]
        let sortedNames1 = names1.sorted(by: { s1, s2 in return s1 > s2 })
        print(sortedNames1)
        
        // 从单表达式闭包隐式返回
        // 单表达式闭包能够通过从它们的声明中删掉 return 关键字来隐式返回它们单个表达式的结果。
        let names2 = ["zhangsan", "lisi", "wangwu", "zhaoliu"]
        let sortedNames2 = names2.sorted(by: { s1, s2 in s1 > s2 })
        print(sortedNames2)
        
        // 简写实际参数名
        // Swift 自动对行内闭包提供简写实际参数名，可以通过 $0、$1、$2 等名字来引用闭包的实际参数值。
        let names3 = ["zhangsan", "lisi", "wangwu", "zhaoliu"]
        let sortedNames3 = names3.sorted(by: { $0 > $1 })
        print(sortedNames3)
        
        // 运算符函数
        // Swift 的 String 类型定义了关于大于号（>）的特定字符串实现，让其作为一个有两个 String 类型的形式参数的函数并返回一个 Bool 类型的值。
        // 这正好与 sorted(by:) 方法的形式参数需要的函数相匹配。
        // 因此，你能简单地传递一个大于号，并且 Swift 将推断你想使用大于号特殊字符串函数来实现。
        let names4 = ["zhangsan", "lisi", "wangwu", "zhaoliu"]
        let sortedNames4 = names4.sorted(by: > )
        print(sortedNames4)
        
        
        // 尾随闭包
        // 如果你需要将一个很长的闭包闭包表达式作为函数最后一个实际参数传递给函数，使用尾随闭包将增强可读性。
        // 尾随闭包是一个被书写在函数形式参数的括号外面（后面）的闭包表达式。
        let names5 = ["zhangsan", "lisi", "wangwu", "zhaoliu"]
        let sortedNames5 = names5.sorted{ $0 > $1 }
        print(sortedNames5)
        
        
        /// 闭包捕获值
        
        // - 一个闭包能够从上下文捕获已被定义的常量和变量。
        // - 即使定义这些常量和变量的原作用域已经不存在，闭包仍能够在其函数体内引用和修改这些值。
        // - 作为一种优化，如果一个值没有改变或者在闭包的外面，Swift 可能会使用这个值的拷贝而不是捕获。
        // - Swift 也处理了变量的内存管理操作，当变量不再需要时会被释放。
        func makeIncrementer(forIncrement amount: Int) -> () -> Int {
            var runningTotal = 0
            func incrementer() -> Int {
                runningTotal += amount
                return runningTotal
            }
            return incrementer
        }
        
        let incrementByTen = makeIncrementer(forIncrement: 10)
        print(incrementByTen())
        print(incrementByTen())
        print(incrementByTen())
        
        // 如果你创建了第二个 incrementer，它将会有一个新的、独立的 runningTotal 变量的引用
        let incrementBySeven = makeIncrementer(forIncrement: 7)
        print(incrementBySeven())
        print(incrementBySeven())
        
        print(incrementByTen())
        
        // 在 Swift 中，函数和闭包都是引用类型。
        // 无论你什么时候赋值一个函数或者闭包给常量或者变量，你实际上都是将常量和变量设置为对函数和闭包的引用。
        // 如果你分配了一个闭包给类实例的属性，并且闭包通过引用该实例或者它们的成员来捕获实例，你将在闭包和实例间产生循环引用。
        let alsoIncrementByTen = incrementByTen
        print(alsoIncrementByTen())
        
        
        /// 逃逸闭包
        
        // - 当闭包作为一个实际参数传递给函数的时候，并且它会在函数返回之后调用，我们就说这个闭包逃逸了。
        // - 当你声明一个接受闭包作为形式参数的函数时，你可以在形式参数前面写 @escaping 来明确闭包是允许逃逸的。
        // - 闭包可以逃逸的一种方法是被存储在定义于函数外的变量里。
        // - 比如说，很多函数接收闭包实际参数来作为启动异步任务的回调。
        // - 函数在启动任务后返回，但是闭包要直到任务完成——闭包需要逃逸，以便于稍后调用。
        // - 让闭包 @escaping 意味着你必须在闭包中显示地引用 self。
        
        
        /// 自动闭包
        
        // - 自动闭包是一种自动创建的用来把作为实际参数传递给函数的表达式打包的闭包。
        // - 它不接收任何实际参数，并且当它被调用时，它会返回内部打包的表达式的值。
        // - 这个语法的好处在于通过写普通表达式代替显示闭包而使你省略包围函数形式参数的括号。
        //let number = 3
        //assert(number > 3, "number 不大于3")
        
        // 自动闭包允许你延迟处理，因此闭包内部的代码直到你调用它的时候才会运行。
        // 对于有副作用或者占用资源的代码来说很有用，因为它可以允许你控制代码何时才进行求值。
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print(customersInLine.count)
        
        let customerProvider = { customersInLine.remove(at: 0) }
        print(customersInLine.count)
        
        print("Now serving \(customerProvider())!")
        print(customersInLine.count)
        
        // 当你传一个闭包作为实际参数到函数的时候，你会得到与延迟处理相同的行为。
        func serve(customer customerProvider: () -> String) {
            print("Now serving \(customerProvider())!")
        }
        serve(customer: { customersInLine.remove(at: 0) })
        
        // 通过 @autoclosure 标志标记它的形式参数使用了自动闭包。
        // 现在你可以调用函数就像它接收了一个 String 实际参数而不是闭包。
        // 实际参数自动转换为闭包，因为 customerProvider 形式参数的类型被标记为 @autoclosure 标记。
        func serve1(customer customerProvider: @autoclosure () -> String) {
            print("Now serving \(customerProvider())!")
        }
        serve1(customer: customersInLine.remove(at: 0))
        
        
        /// 自动 + 逃逸
        
        // 如果你想要自动闭包允许逃逸，就同时使用 @autoclosure 和 @escaping 标志。
        var customerProviders: [() -> String] = []
        func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
            customerProviders.append(customerProvider)
        }
        collectCustomerProviders(customersInLine.remove(at: 0))
        collectCustomerProviders(customersInLine.remove(at: 0))
        
        print("Collected \(customerProviders.count) closures.")
        
        for customerProvider in customerProviders {
            print("Now serving \(customerProvider())!")
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
