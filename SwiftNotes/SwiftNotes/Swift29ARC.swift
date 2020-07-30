//
//  Swift29ARC.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/29.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift29ARC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// ARC 自动引用计数
        
        // - Swift 使用自动引用计数(ARC)来跟踪并管理应用使用的内存。大部分情况下，这意味着在 Swift 语言中，内存管理”仍然工作"，不需要自己去考虑内存管理的事情。当实例不再被使用时，ARC会自动释放这些类的实例所占用的内存。
        // - 引用计数只应用在类的实例。结构体(Structure)和枚举类型是值类型，并非引用类型，不是以引用的方式来存储和传递的。
        
        
        /// ARC 如何工作
        
        // - 每次创建一个类的实例，ARC 就会分配一个内存块，用来存储这个实例的相关信息。这个内存块保存着实例的类型，以及这个实例相关的属性的值。
        // - 当实例不再被使用时，ARC 释放这个实例使用的内存，使这块内存可作它用。这保证了类实例不再被使用时，它们不会占用内存空间。
        // - 但是，如果 ARC 释放了仍在使用的实例，那么你就不能再访问这个实例的属性或者调用它的方法。如果你仍然试图访问这个实例，应用极有可能会崩溃。
        // - 为了保证不会发生上述的情况，ARC 跟踪与类的实例相关的属性、常量以及变量的数量。只要有一个有效的引用，ARC 都不会释放这个实例。
        // - 为了让这变成现实，只要你将一个类的实例赋值给一个属性或者常量或者变量，这个属性、常量或者变量就是这个实例的强引用(strong reference)。之所以称之为“强”引用，是因为它强持有这个实例，并且只要这个强引用还存在，就不能销毁实例。
        
        
        /// 循环引用
        
        // - 在两个类实例彼此保持对方的强引用，使得每个实例都使对方保持有效时会发生这种情况。我们称之为强引用环。
        // - 通过用弱引用或者无主引用来取代强引用，我们可以解决强引用环问题。
        
        class Person {
            let name: String
            init(name: String) {
                self.name = name
            }
            var apartment: Apartment?
            deinit {
                print("\(name) is being deinitialized")
            }
        }
        
        class Apartment {
            let uint: String
            init(uint: String) {
                self.uint = uint
            }
            var tenant: Person?
            deinit {
                print("Apartment \(uint) is being deinitialized")
            }
        }
        
        
        /// 解决循环引用
        
        // - 弱引用和无主引用允许引用环中的一个实例引用另外一个实例，但不是强引用。因此实例可以互相引用但是不会产生强引用环。
        // - 对于生命周期中引用会变为 nil 的实例，使用弱引用;对于初始化时赋值之后引用再也不会赋值为 nil 的实例，使用无主引用。
        
        
        /// 弱引用
        
        // - 弱引用不会增加实例的引用计数，因此不会阻止ARC销毁被引用的实例。这种特性使得引用不会变成强引用环。声明属性或者变量的时候，关键字weak表明引用为弱引用。
        // - 弱引用只能声明为变量类型，因为运行时它的值可能改变。弱引用绝对不能声明为常量。
        // - 因为弱引用可以没有值，所以声明弱引用的时候必须是可选类型的。在Swift语言中，推荐用可选类型来作为可能没有值的引用的类型。
        
        class Apartment1 {
            let uint: String
            init(uint: String) {
                self.uint = uint
            }
            weak var tenant: Person?
            deinit {
                print("Apartment \(uint) is being deinitialized")
            }
        }
        
        
        /// 无主引用
        
        // - 和弱引用相似，无主引用也不强持有实例。但是和弱引用不同的是，无主引用默认始终有值。因此，无主引用只能定义为非可选类型(non-optional type)。在属性、变量前添加 unowned 关键字，可以声明一个无主引用。
        // - 因为是非可选类型，因此当使用无主引用的时候，不需要展开，可以直接访问。不过非可选类型变量不能赋值为 nil，因此当实例被销毁的时候，ARC 无法将引用赋值为 nil。
        // - 当实例被销毁后，试图访问该实例的无主引用会触发运行时错误。使用无主引用时请确保引用始终指向一个未销毁的实例。
        
        class Country {
            let name: String
            var capitalCity: City?
            init(name: String, capitalName: String) {
                self.name = name
                self.capitalCity = City(name: capitalName, country: self)
            }
        }
        
        class City {
            let name: String
            unowned let country: Country
            init(name: String, country: Country) {
                self.name = name
                self.country = country
            }
        }
        
        
        /// 闭包引用循环
        
        // - 将一个闭包赋值给类实例的某个属性，并且这个闭包使用了实例，这样也会产生强引用环。这个闭包可能访问了实例的某个属性，例如 self.someProperty，或者调用了实例的某个方法，例如 self.someMethod。这两种情况都导致了闭包使用 self，从而产生了循环引用。
        
        
        /// 闭包引用循环解决
        
        // - 定义占有列表 - 占有列表中的每个元素都是由 weak 或者 unowned 关键字和实例的引用(如 self 或 someInstance)组成。每一对都在中括号中，通过逗号分开。
        // - 当闭包和占有的实例总是互相引用时并且总是同时销毁时，将闭包内的占有定义为无主引用。
        // - 相反的，当占有引用有时可能会是nil时，将闭包内的占有定义为弱引用。
        
        /*
            lazy var someClosure = { [unowned self, weak delegate = self.delegate] (index: Int, stringToProcess: String) -> String in
                // closure body goes here
            }
        */
        
        
        /// 内存安全
        
        // - 默认情况下，Swift 会克服代码层面上的一些不安全的行为，如:确保一个变量被初始化完后才能被访问、确保变量在销毁后不会被访问等等安全操作。
        // - Swift 也会确保在多路访问内存中同一区域时不会冲突(独占访问该区域)。通常情况下，我们 完全无需考虑内存访问冲突的问题，因为 Swift 是自动管理内存的。然而，在码代码的时候，了解那些地方可能发生内存访问冲突是非常重要的。通常情况下，如果你的代码有内存访问冲突，那么 Xcode 会提示编译错误或者运行时错误。
        // - 访问可以分两种:
        // - （1）即时访问:即在访问开始至结束前都不可能有其他代码来访问同一区域。
        // - （2）长期访问:即在访问开始至结束前可能有其他代码来访问同一区域。长期访问可能和其他即时访问或者长期访问重叠。
        
        // inout 参数访问冲突:
        var stepSize = 1
        func increment(_ number: inout Int) {
            number += stepSize
        }
        //increment(&stepSize) // 调用出错：modification requires exclusive access
        
        // 解决
        var copyOfStepSize = stepSize // Make an explicit copy
        increment(&copyOfStepSize) // 调用
        stepSize = copyOfStepSize // Update the original
        
        // self 访问冲突
        var oscar = Player(name: "Oscar", health: 10, energy: 10)
        var maria = Player(name: "Maria", health: 5, energy: 10)
        oscar.shareHealth(with: &maria) // OK
        // oscar.shareHealth(with: &oscar) //Error
        
        
        
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

struct Player {
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        // balance(&teammate.health, &health)
    }
}
