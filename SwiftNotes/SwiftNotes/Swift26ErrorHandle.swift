//
//  Swift26ErrorHandle.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/29.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift26ErrorHandle: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 错误表示
        
        // - 在 swift 中如果我们要定义一个表示错误的类型非常简单，只要遵循 Error 协议就可以了，我们通常用枚举或结构体来表示错误类型，枚举可能用的多些，因为它能更直观的表达当前错误类型的每种错误细节。
        
        enum VendingMachineError: Error {
            case invalidSelection
            case insufficientFunds(coinsNeeded: Int)
            case outOfStaock
        }
        
        
        /// 如何抛出错误
        
        // - 函数、方法和初始化器都可以抛出错误。需要在参数列表后面，返回值前面加 throws 关键字。
        
        /*
            func canThrowErrors() throws -> String {}
            
            func cannotThrowErrors() -> String {}
        */
        
        struct Item {
            var price: Int
            var count: Int
        }
        
        class VendingMachine {
            var inventory = ["Candy": Item(price: 12, count: 7),
                             "Chips": Item(price: 10, count: 4),
                             "Pretzels": Item(price: 7, count: 11)]
            var coinsDeposited = 0
            
            func vend(itemNamed name: String) throws {
                defer {
                    print("退出清理")
                }
                
                guard let item = inventory[name] else {
                    throw VendingMachineError.invalidSelection
                }
                
                guard item.count > 0 else {
                    throw VendingMachineError.outOfStaock
                }
                
                guard item.price <= coinsDeposited else {
                    throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
                }
                
                coinsDeposited -= item.price
                
                var newItem = item
                newItem.count -= 1
                inventory[name] = newItem
                
                print("Dispensing \(name)")
            }
        }
        
        
        /// 使用 Do-Catch 做错误处理
        
        // - 在 Swift 中我们使用 do-catch 块对错误进行捕获，当我们在调用一个 throws 声明的函数或方法时，我们必须把调用语句放在 do 语句块中，同时 do 语句块后面紧接着使用 catch 语句块。
        
        let machine = VendingMachine()
        machine.coinsDeposited = 5
        do {
            try machine.vend(itemNamed: "Candy")
        } catch VendingMachineError.invalidSelection {
            print("no such thing")
        } catch VendingMachineError.insufficientFunds(let coninsNeeded) {
            print("you need more coins \(coninsNeeded)")
        } catch VendingMachineError.outOfStaock {
            print("out of stock")
        } catch {
            print("unexpected error")
        }
        
        // try?:
        // - try? 会将错误转换为可选值，当调用 try?+函数或方法语句时候，如果函数或方法抛出错误，程序不会发崩溃，而返回一个nil，如果没有抛出错误则返回可选值。
        
        // try!:
        // - 如果你确信一个函数或者方法不会抛出错误，可以使用 try! 来中断错误的传播。但是如果错误真的发生了，你会得到一个运行时错误。
        
        
        /// 指定退出的清理动作
        
        // - defer 关键字: defer block 里的代码会在函数 return 之前执行，无论函数是从哪个分支 return 的，还是有 throw，还是自然而然走到最后一行。
        
        let machine1 = VendingMachine()
        machine1.coinsDeposited = 15
        do {
            try machine1.vend(itemNamed: "Candy")
        } catch VendingMachineError.invalidSelection {
            print("no such thing")
        } catch VendingMachineError.insufficientFunds(let coninsNeeded) {
            print("you need more coins \(coninsNeeded)")
        } catch VendingMachineError.outOfStaock {
            print("out of stock")
        } catch {
            print("unexpected error")
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
