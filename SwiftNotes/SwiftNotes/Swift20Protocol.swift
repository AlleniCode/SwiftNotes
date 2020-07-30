//
//  Swift20Protocol.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/27.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift20Protocol: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 协议的语法
        
        // - 自定义类型声明时，将协议名放在类型名的冒号之后来表示该类型采纳一个特定的协议。多个 协议可以用逗号分开列出。
        // - 若一个类拥有父类，将这个父类名放在其采纳的协议名之前，并用逗号分隔。
        
        /*
            protocol SomeProtocol {
                // protocol definition goes here
            }
            
            struct SomeStructure: FirstProtocol, AnotherProtocol {
                // structure definition goes here
            }
            
            class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
                // class definition goes here
            }
        */
        
        
        /// 属性要求
        
        // - 协议可以要求所有遵循该协议的类型提供特定名字和类型的实例属性或类型属性。
        // - 协议并不会具体说明属性是储存型属性还是计算型属性——它只具体要求属性有特定的名称和类型。
        // - 协议同时要求一个属性必须明确是可读的或可读的和可写的。
        // - 若协议要求一个属性为可读和可写的，那么该属性要求不能用常量存储属性或只读计算属性来满足。
        // - 若协议只要求属性为可读的，那么任何种类的属性都能满足这个要求，而且如果你的代码需要的话，该属性也可以是可写的。
        
        /*
            protocol SomeProtocol {
                var mustBeSettable: Int { get set }
                var doesNotNeedToBeSettable: Int { get }
            }
        */
        
        // - 在协议中定义类型属性时在前面添加 static 关键字。当类的实现使用 class 或 static 关键字前缀声明类型属性要求时，这个规则仍然适用。
        
        /*
            protocol AnotherProtocol {
                static var someTypeProperty: Int { get set }
            }
        */
        
        
        /// 方法要求
        
        // - 协议可以要求采纳的类型实现指定的实例方法和类方法。
        // - 这些方法作为协议定义的一部分，书写方式与正常实例和类方法的方式完全相同，但是不需要大括号和方法的主体。
        // - 允许变量拥有参数，与正常的方法使用同样的规则。但在协议的定义中，方法参数不能定义默认值。
        // - 正如类型属性要求的那样，当协议中定义类型方法时，你总要在其之前添加 static 关键字。
        // - 即使在类实现时，类型方法要求使用 class 或 static 作为关键字前缀，前面的规则仍然适用。
        
        
        /// mutating 方法要求
        
        // - 若你定义了一个协议的实例方法需求，想要异变任何采用了该协议的类型实例，只需在协议里方法的定义当中使用 mutating 关键字。
        // - 这允许结构体和枚举类型能采用相应协议并满足方法要求。
        
        
        /// 初始化器要求
        
        // - 协议可以要求遵循协议的类型实现指定的初始化器。
        // - 和一般的初始化器一样，只用将初始化器写在协议的定义当中，只是不用写大括号也就是初始化器的实体。
        
        /*
            protocol SomeProtocol {
                init(someParameter: Int)
            }
        */
        
        
        /// 初始化器要求的类实现
        
        // - 你可以通过实现指定初始化器或便捷初始化器来使遵循该协议的类满足协议的初始化器要求。
        // - 在这两种情况下，你都必须使用 required 关键字修饰初始化器的实现。
        
        /*
            class SomeClass: SomeProtocol {
                require init(someParameter: Int) {
                    // initializer implementation goes here
                }
            }
        */
        
        // - 如果一个子类重写了父类指定的初始化器，并且遵循协议实现了初始化器要求，那么就要为这个初始化器的实现添加 required 和 override 两个修饰符。
        
        /*
            protocol SomeProtocol {
                init()
            }
            
            class SomeSuperClass {
                init() {
                    // initializer implementation goes here
                }
            }
            
            class SomeSubClass: SomeSuperClass, SomeProtocol {
                // "required" from SomeProtocol, "override" from SomeSuperClass
                required override init() {
                    // initializer implementation goes here
                }
            }
        */
        
        
        /// 将协议作为类型
        
        // - 在函数、方法或者初始化器里作为形式参数类型或者返回类型;
        // - 作为常量、变量或者属性的类型;
        // - 作为数组、字典或者其他存储器的元素的类型。
        
        
        /// 协议继承
        
        // - 协议可以继承一个或者多个其他协议并且可以在它继承的基础之上添加更多要求。
        // - 协议继承的语法与类继承的语法相似，只不过可以选择列出多个继承的协议，使用逗号分隔。
        
        /*
            protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
                // protocol definition goes here
            }
        */
        
        
        /// 类专用的协议
        
        // - 通过添加 AnyObject 关键字到协议的继承列表，你就可以限制协议只能被类类型采纳(并且不是结构体或者枚举)。
        
        /*
            protocol SomeClassOnlyProtocol: AnyObject, SomeProtocol {
                // class-only protocol definition goes here
            }
        */
        
        
        /// 协议组合
        
        // - 可以使用协议组合来复合多个协议到一个要求里。协议组合行为就和你定义的临时局部协议一样拥有构成中所有协议的需求。协议组合不定义任何新的协议类型。
        // - 协议组合使用 SomeProtocol & AnotherProtocol 的形式。你可以列举任意数量的协议，用和符号连接 ( & )，使用逗号分隔。除了协议列表，协议组合也能包含类类型，这允许你标明一个需要的父类。
        
        func wishHappyBirthday(to celebrator: Named & Aged) {
            print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
        }

        let person = PersonN(name: "Allen", age: 18)
        wishHappyBirthday(to: person)
        
        /// 可选协议要求
        
        // - 你可以给协议定义可选要求，这些要求不需要强制遵循协议的类型实现。
        // - 可选要求使用 optional 修饰符作为前缀放在协议的定义中。
        // - 可选要求允许你的代码与 Objective-C 操作。 协议和可选要求必须使用 @objc 标志标记。
        // - 注意 @objc 协议只能被继承自 Objective-C 类或其他 @objc 类采纳。它们不能被结构体或者枚举采纳。
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


protocol FullyNamed {
    var fullName: String { get }
}

struct Personn: FullyNamed {
    var fullName: String
}
let john = Personn(fullName: "John Appleseed")

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix ?? "") + " " + name
    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")


protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct PersonN: Named, Aged {
    var name: String
    var age: Int
}



