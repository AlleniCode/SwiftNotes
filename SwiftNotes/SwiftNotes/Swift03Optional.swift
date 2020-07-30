//
//  Swift03Optional.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/22.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift03Optional: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 为什么需要 Optional
        /*
        - OC 里的 `nil` 是无类型的指针。
        - OC 里的数组、字典、集合等不允许放入 `nil`。
        - OC 所有对象变量都可以为 `nil`。
        - OC 只能用在对象上，而在其他地方又用其他特殊值（例如 NSNotFound）表示值的缺失。
        */


        /// Optional 介绍
        /*
        - `Optional` 是标准库里的一个 `enum` 类型。
        - `Optional.none` 就是 `nil`，`Optional.some` 则包装了实际的值。
        - 通过在变量类型后面加 `?` 表示：这里有一个值，它等于 x，或者这里根本没有值。
        - 可以通过给可选变量赋值一个 `nil` 来将之设置为没有值。
        - 可选项是没法直接使用的，需要用 `!` 展开之后才能使用。
        - 使用 `!` 来获取一个不存在的可选值会导致运行错误，在使用 `!` 强制展开之前必须确保可选项中包含一个非 `nil` 的值。
        - 可以使用可选项绑定来判断可选项是否包含值，如果包含就把值赋值给一个临时的常量或变量。
        - 可选绑定可以与 `if` 和 `while` 的语句来检查可选项内部的值，并赋值给一个变量或常量。
        - 同一个 `if` 语句中包含多个可选绑定，用逗号分开即可；如果任一可选绑定结果是 `nil` 或者布尔值为 `false`，那么整个 `if` 判断会被看作 `false`。
        - 有些可选项一旦被设定值之后，就会一直拥有值，在这种情况下，就可以去掉检查的需求，也不必每次访问的时候都进行展开。
        - 通过在声明的类型后面加 `!` 而非 `?` 来书写隐式展开可选项。
        - 隐式展开可选项主要被用在 Swift 类的初始化过程中。
        - 如果可选项不为 `nil`，返回一个可选项结果，否则返回 `nil`。
        */
        
        
        /// Optional 的定义
        let str0: String? = "abc"
        let str1: Optional<String> = "abc"
        print(str0 as Any)
        print(str1 ?? "")
        
        
        /// Optional 的展开
        let str: String? = "abc"
        
        // 使用判断展开
        if str != nil {
            let count = str!.count
            print(count)
        }
        
        // 使用绑定展开
        if let actualStr = str {
            let count = actualStr.count
            print(count)
        }
        
        // 使用强制展开
        let count = str!.count // 如果 str = nil，则会出错
        print(count)
        
        // 使用隐式展开
        let count1 = str?.count
        if count1 != nil {
            let lastIndex = count1! - 1
            print(lastIndex)
        }
        
        // 使用 unsafelyUnwrapped 方法展开
        let count2 = str.unsafelyUnwrapped.count
        print(count2)
        
        
        /// Optional Chain 可选链
        
        // 可选值的缺点:
        // - 使用可选值有时会让人感到有点笨拙，所有的解包和检查会变得如此繁重，以至于会让你想要 丢几个感叹号上去强制解包，好让你能继续工作下去。但是请小心:如果你强制解包一个没有值的可选值，你的代码就崩了。为了解决这个缺点，Swift 引入两个特性，一是合并空值运算符，二是可选链。
        
        // 可选链：
        // - 可选链是一个调用和查询可选属性、方法和下标的过程，它可能为 nil 。如果可选项包含值，属性、方法或者下标的调用成功;如果可选项是 nil ，属性、方法或者下标的调用会返回 nil 。多个查询可以链接在一起，如果链中任何一个节点是 nil ，那么整个链就会得体地失败。
        
        // 可选链代替强制展开:
        // - 你可以通过在你希望如果可选项为非 nil 就调用属性、方法或者脚本的可选值后边使用问号( ? ) 来明确可选链。这和在可选值后放叹号( ! )来强制展开它的值非常类似。主要的区别在于可选链会在可选项为 nil 时得体地失败，而强制展开则在可选项为 nil 时触发运行时错误。
        // - 为了显示出可选链可以在 nil 值上调用，可选链调用的结果一定是一个可选值，就算你查询的属性、方法或者下标返回的是非可选值。你可以使用这个可选项返回值来检查可选链调用是成功 (返回的可选项包含值)，还是由于链中出现了 nil 而导致没有成功(返回的可选值是 nil)。
        // - 另外，可选链调用的结果与期望的返回值类型相同，只是包装成了可选项。通常返回 Int 的属性通过可选链后会返回一个 Int? 。
        
        class Room {
            let name: String
            init(name: String) {
                self.name = name
            }
        }
        
        class Address {
            var buildingName: String?
            var buildingNumber: String?
            var street: String?
            func buildingIdentifier() -> String? {
                if buildingName != nil {
                    return buildingName
                } else if buildingNumber != nil && street != nil {
                    return "\(String(describing: buildingNumber)) \(String(describing: street))"
                } else {
                    return nil
                }
            }
        }
        
        class Residence {
            var rooms = [Room]()
            var numberOfRooms: Int {
                return rooms.count
            }
            subscript(i: Int) -> Room {
                get {
                    return rooms[i]
                }
                set {
                    rooms[i] = newValue
                }
            }
            func printNumberOfRooms() {
                print("The number of rooms is \(numberOfRooms)")
            }
            var address: Address?
        }
        
        class PersonX {
            var residence: Residence?
        }
        
        let john = PersonX()
        if let roomCount = john.residence?.numberOfRooms {
            print(roomCount)
        } else {
            print(0)
        }
        
        // 通过可选链访问属性:
        
        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.street = "Acacia Road"
        john.residence?.address = someAddress
        
        func createAddress() -> Address {
            print("Function was called.")
            
            let someAddress = Address()
            someAddress.buildingNumber = "29"
            someAddress.street = "Acacia Road"
            
            return someAddress
        }
        john.residence?.address = createAddress() // "Function was called." 不会被打印
        
        // 通过可选链调用方法:
        // - 函数和方法没有返回类型就隐式地指明为 Void 类型。意思是说它们返回一个 () 的值或者是一个空的元组。
        
        if john.residence?.printNumberOfRooms() != nil {
            print("It was possible to print the number of rooms.")
        } else {
            print("It was not possible to print the number of rooms.")
        }
        
        // - 如果你尝试通过可选链来设置属性也是一样的。上边通过可选链访问属性中的例子尝试设置 address 值给 john.residence ，就算是 residence 属性是 nil 也行。任何通过可选链设置属性的尝试都会返回一个 Void? 类型值，它允许你与 nil 比较来检查属性是否设置成功:
        if (john.residence?.address = someAddress) != nil {
            print("It was possible to set address.")
        } else {
            print("It was not possible to set address.")
        }
        
        // 通过可选链访问下标:
        // - 通过可选链访问下标你可以使用可选链来给可选项下标取回或设置值，并且检查下标的调用是否成功。
        
        if let firstRoomName = john.residence?[0].name {
            print("The first room name is \(firstRoomName).")
        } else {
            print("Unable to retrieve the first room name.")
        }
        
        // 链的多层连接:
        // - 你可以通过连接多个可选链来在模型中深入访问属性、方法以及下标。总之，多层可选链不会给返回的值添加多层的 可选性。
        // - 也就是说:
        // - （1）如果你访问的值不是可选项，它会因为可选链而变成可选项;
        // - （2）如果你访问的值已经是可选的，它不会因为可选链而变得更加可选。
        // - 因此:
        // - （1）如果你尝试通过可选链取回一个 Int 值，就一定会返回 Int? ，不论通过了多少层的可选链;
        // - （2）类似地，如果你尝试通过可选链访问 Int? 值， Int? 一定就是返回的类型，无论通过了多少层的可选链。
        
        // 用可选返回值链接方法:
        // - 可以通过可选链来调用返回可选类型的方法，并且如果需要的话可以继续对方法的返回值进行链接。
        
        if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
            print("John’s building identifier is \(buildingIdentifier)")
        }
        
        if let beginsWithThe = john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
            if beginsWithThe {
                print("John’s building identifier begin with \"The\".")
            } else {
                print("John’s building identifier does not begin with \"The\".")
            }
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
