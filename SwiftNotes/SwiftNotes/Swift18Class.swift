//
//  Swift18Class.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/27.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift18Class: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 类的初始化和反初始化
        
        
        /// 初始化器
        
        // - 初始化器在创建特定类型的实例时被调用。
        
        struct Fahrenheit {
            var temperature: Double
            init() {
                temperature = 32.0
            }
        }
        let f = Fahrenheit()
        print("The default temperature is \(f.temperature) Fahrenheit")
        
        
        /// 默认的属性值
        
        // - 如上所述，你可以在初始化器里为存储属性设置初始值。
        // - 另外，指定一个默认属性值作为属性声明的一部分。当属性被定义的时候你可以通过为这个属性分配一个初始值来指定默认的属性值。
        
        struct Fahrenheit1 {
            var temperature = 32.0
        }
        let f1 = Fahrenheit1()
        print("The default temperature is \(f1.temperature) Fahrenheit")
        
        
        /// 默认的初始化器
        
        // - Swift 为所有没有提供初始化器的结构体或类提供了一个默认的初始化器来给所有的属性提供了默认值。
        // - 这个默认的初始化器只是简单地创建了一个所有属性都有默认值的新实例。
        
        class ShoppingListItem {
            var name: String?
            var quantity = 1
            var purchased = false
        }
        let item = ShoppingListItem()
        print(item.name ?? "")
        print(item.quantity)
        print(item.purchased)
        
        
        /// 自定义初始化
        
        // - 可以提供初始化形式参数作为初始化器的一部分，来定义初始化过程中的类型和值的名称。 初始化形式参数与函数和方法的形式参数具有相同的功能和语法。
        
        struct Celsius {
            var temperatureInCelsius: Double
            init(fromFahrenheit fahrenheit: Double) {
                temperatureInCelsius = (fahrenheit - 32.0) / 1.8
            }
            init(fromKelvin kelvin: Double) {
                temperatureInCelsius = kelvin - 273.15
            }
        }
        let boillingPointOfWater = Celsius(fromFahrenheit: 212.0)
        let freezingPointOfWater = Celsius(fromKelvin: 273.15)
        print(boillingPointOfWater)
        print(freezingPointOfWater)
        
        
        /// 在初始化中分配常量属性
        
        // - 在初始化的任意时刻，你都可以给常量属性赋值，只要它在初始化结束是设置了确定的值即可。
        // - 一旦为常量属性被赋值，它就不能再被修改了。
        
        class SurveyQuestion {
            let text: String
            var response: String?
            init(text: String) {
                self.text = text
            }
            func ask() {
                print(text)
            }
        }
        let beetsQuestion = SurveyQuestion(text: "How about beets?")
        beetsQuestion.ask()
        beetsQuestion.response = "I also like beets, but not with cheese."
        
        
        /// 结构体的成员初始化器
        
        // - 如果结构体类型中没有定义任何自定义初始化器，它会自动获得一个成员初始化器。
        // - 不同于默认初始化器，结构体会接收成员初始化器即使它的存储属性没有默认值。
        
        struct Size {
            var width = 0.0, height = 0.0
        }
        let twoByTwo = Size(width: 2.0, height: 2.0)
        print(twoByTwo)
        
        
        /// 值类型的初始化器委托
        
        // - 初始化器可以调用其他初始化器来执行部分实例的初始化。这个过程，就是所谓的初始化器委托，避免了多个初始化器里冗余代码。
        
        struct Point {
            var x = 0.0, y = 0.0
        }
        
        struct Rect {
            var origin = Point()
            var size = Size()
            init() {}
            init(origin: Point, size: Size) {
                self.origin = origin
                self.size = size
            }
            init(center: Point, size: Size) {
                let originX = center.x - (size.width / 2)
                let originY = center.y - (size.height / 2)
                self.init(origin: Point(x: originX, y: originY), size: size)
            }
        }
        
        
        /// 类的继承和初始化
        
        // - 所有类的存储属性(包括从它的父类继承的所有属性)都必须在初始化期间分配初始值。
        // - Swift 为类类型定义了两种初始化器以确保所有的存储属性接收一个初始值。这些就是所谓的指定初始化器和便捷初始化器。
        // - 指定初始化器是类的主要初始化器。指定的初始化器可以初始化所有那个类引用的属性并且调用合适的父类初始化器来继续这个初始化过程给父类链。
        // - 类偏向于少量指定初始化器，并且一个类通常只有一个指定初始化器。指定初始化器是初始化开始并持续初始化过程到父类链的“传送”点。
        // - 每个类至少得有一个指定初始化器。如同在初始化器的自动继承里描述的那样，在某些情况下，这些需求通过从父类继承一个或多个指定初始化器来满足。
        // - 便捷初始化器是次要的。你可以在相同的类里定义一个便捷初始化器来调用一个指定的初始化器作为便捷初始化器来给指定初始化器设置默认形式参数。你也可以为具体的使用情况或输入的值类型定义一个便捷初始化器从而创建这个类的实例。
        // - 如果你的类不需要便捷初始化器你可以不提供它。在为通用的初始化模式创建快捷方式以节省时间或者类的初始化更加清晰明了的时候使用便捷初始化器。
        
        
        /// 指定初始化器和便捷初始化器
        
        // - 用与值类型的简单初始化器相同的方式来写类的指定初始化器。
        // - 用 convenience 修饰符放到 init 关键字前定义便捷初始化器。
        
        /*
         init(parameters) {
             statements
         }
         
         convenience init(parameters) {
             statements
         }
         */
        
        
        /// 类的初始化委托
        
        // - 指定初始化器必须从它的直系父类调用指定初始化器。
        // - 便捷初始化器必须从相同的类里调用另一个初始化器。
        // - 便捷初始化器最终必须调用一个指定初始化器。
        
        
        /// 两段式初始化
        
        // - Swift 的类初始化是一个两段式过程。
        // - 在第一个阶段，每一个存储属性被引入类分配了一个初始值。
        // - 一旦每个存储属性的初始状态被确定，第二个阶段就开始了，每个类都有机会在新的实例准备使用之前来定制它的存储属性。
        // - 两段式初始化过程的使用让初始化更加安全，同时在每个类的层级结构给与了完备的灵活性。
        // - 两段式初始化过程可以防止属性值在初始化之前被访问，还可以防止属性值被另一个初始化器意外地赋予不同的值。
        
        
        /// 两段式初始化过程-阶段一
        
        // - 指定或便捷初始化器在类中被调用;
        // - 为这个类的新实例分配内存。内存还没有被初始化;
        // - 这个类的指定初始化器确保所有由此类引入的存储属性都有一个值。现在这些存储属性的内存被初始化了;
        // - 指定初始化器上交父类的初始化器为其存储属性执行相同的任务;
        // - 这个调用父类初始化器的过程将沿着初始化器链一直向上进行，直到到达初始化器链的最顶部;
        // - 一旦达了初始化器链的最顶部，在链顶部的类确保所有的存储属性都有一个值，此实例的内存被认为完全初始化了，此时第一阶段完成。
        
        /// 两段式初始化过程-阶段二
        
        // - 从顶部初始化器往下，链中的每一个指定初始化器都有机会进一步定制实例。初始化器现在能够访问 self 并且可以修改它的属性，调用它的实例方法等等;
        // - 最终，链中任何便捷初始化器都有机会定制实例以及使用 slef 。
        
        
        /// 安全检查
        
        // - 1、指定初始化器必须保证在向上委托给父类初始化器之前，其所在类引入的所有属性都要初始化完成。
        // - 2、指定初始化器必须先向上委托父类初始化器，然后才能为继承的属性设置新值。如果不这样做，指定初始化器赋予的新值将被父类中的初始化器所覆盖。
        // - 3、便捷初始化器必须先委托同类中的其它初始化器，然后再为任意属性赋新值(包括同类里定义的属性)。如果没这么做，便捷构初始化器赋予的新值将被自己类中其它指定初始化器所覆盖。
        // - 4、初始化器在第一阶段初始化完成之前，不能调用任何实例方法、不能读取任何实例属性的值，也不能引用 self 作为值。
        
        class Person {
            var name: String
            var age: Int
            init(name: String, age: Int) {
                self.name = name
                self.age = age
            }
            convenience init() {
                self.init(name: "[Unnamed]", age: 0)
            }
        }
        
        class Teacher: Person {
            var salary: Int
            init(name: String, age: Int, salary: Int) {
                self.salary = salary
                super.init(name: name, age: age)
                self.name = name + "老师"
                
                self.test()
            }
            convenience init(name: String) {
                self.init(name: name, age: 30, salary: 5000)
            }
            
            func showInfo() {
                print("Teacher \(name), age \(age), salary \(salary)")
            }
            
            func test() {
                print("I am a teacher")
            }
        }
        
        
        /// 初始化器的继承和重写
        
        // - 不像在 Objective-C 中的子类，Swift 的子类不会默认继承父类的初始化器。
        // - Swift 的这种机制防止父类的简单初始化器被一个更专用的子类继承并被用来创建一个没有完全或错误初始化的新实例的情况发生。只有在特定情况下才会继承父类的初始化器。
        // - 如果你想自定义子类来实现一个或多个和父类相同的初始化器，你可以在子类中为那些初始化器提供定制的实现。
        // - 当你写的子类初始化器匹配父类指定初始化器的时候，你实际上可以重写那个初始化器。
        // - 因此，在子类的初始化器定义之前你必须写 override 修饰符。如同默认初始化器所描述的那样，即使是自动提供的默认初始化器你也可以重写。
        
        
        /// 初始化器的自动继承
        
        // - 如果你的子类没有定义任何指定初始化器，它会自动继承父类所有的指定初始化器。
        // - 如果你的子类提供了所有父类指定初始化器的实现——要么是通过规则1继承来的，要么通过 在定义中提供自定义实现的——那么它自动继承所有的父类便捷初始化器。
        
        
        /// 可失败初始化器
        
        // - 定义类、结构体或枚举初始化时可以失败在某些情况下会管大用。
        // - 这个失败可能由以下几种方式触发，包括给初始化传入无效的形式参数值，或缺少某种外部所需的资源，又或是其他阻止初始化的情况。
        // - 为了妥善处理这种可能失败的情况，在类、结构体或枚举中定义一个或多个可失败的初始化器。通过在 init 关键字后面添加问号( init? )来写。
        
        
        /// 可失败初始化器 init!
        
        // - 通常来讲我们通过在 init 关键字后添加问号( init? )的方式来定义一个可失败初始化器以创建一个合适类型的可选项实例。
        // - 另外，你也可以使用可失败初始化器创建一个隐式展开具有合适类型的可选项实例。通过在 init 后面添加惊叹号( init! )而不是问号。
        
        
        /// 必要初始化器
        
        // - 在类的初始化器前添加 required 修饰符来表明所有该类的子类都必须实现该初始化器。
        
        
        /// 反初始化器
        
        // - 在类实例被释放的时候，反初始化器就会立即被调用。
        // - 你可以是用 deinit 关键字来写反初始化器，就如同写初始化器要用 init 关键字一样。
        // - 反初始化器只在类类型中有效。
        // - 反初始化器会在实例被释放之前自动被调用。你不能自行调用反初始化器。
        // - 父类的反初始化器可以被子类继承，并且子类的反初始化器实现结束之后父类的反初始化器会被调用。
        // - 父类的反初始化器总会被调用，就算子类没有反初始化器。
        // - 每个类当中只能有一个反初始化器。反初始化器不接收任何形式参数，并且不需要写圆括号。
        
        /*
            deinit {
                // perform the deinitialization
            }
        */
        
        
        /// 定义基类
        
        // - 任何不从另一个类继承的类都是所谓的基类。
        // - Swift 类不会从一个通用基类继承。你没有指定特定父类的类都会以基类的形式创建。
        
        class Vehicle {
            var currentSpeed = 0.0
            var description: String {
                return "traveling at \(currentSpeed) miles per hour"
            }
            func makeNoise() {
                // do nothing
            }
        }
        
        
        /// 子类
        
        // - 子类是基于现有类创建新类的行为。子类从现有的类继承了一些特征，你可以重新定义它们。你也可以为子类添加新的特征。
        // - 为了表明子类有父类，要把子类写在父类的前面，用冒号分隔。
        
        class Bicycle: Vehicle {
            var hasBasket = false
        }
        let bicycle = Bicycle()
        bicycle.hasBasket = true
        bicycle.currentSpeed = 15.0
        print(bicycle.description)
        
        
        /// 重写
        
        // - 子类可以提供它自己的实例方法、类型方法、实例属性，类型属性或下标脚本的自定义实现，否则它将会从父类继承。这就所谓的重写。
        // - 要重写而不是继承一个特征，你需要在你的重写定义前面加上 override 关键字。这样做说明你打算提供一个重写而不是意外提供了一个相同定义。
        // - 意外的重写可能导致意想不到的行为，并且任何没有使用 override 关键字的重写都会在编译时被诊断为错误。
        
        
        /// 访问父类的方法、属性和下标脚本
        
        // - 你可以通过使用 super 前缀访问父类的方法、属性或下标脚本:
        // - （1）一个命名为 someMethod() 的重写方法可以通过 super.someMethod() 在重写方法的实现中调用父类版本的 someMethod() 方法。
        // - （2）一个命名为 someProperty 的重写属性可以通过 super.someProperty 在重写的 getter 或 setter 实现中访问父类版本的 someProperty 属性。
        // - （3）一个命名为 someIndex 的重写下标脚本可以使用 super[someIndex] 在重写的下标脚本实现中访问父类版本中相同的下标脚本。
        
        
        /// 重写方法
        
        // - 可以在子类中重写一个继承的实例或类型方法来提供定制的或替代的方法实现。
        
        class Train: Vehicle {
            override func makeNoise() {
                 print("咔嚓！咔嚓！咔嚓！呜~")
            }
        }
        let train = Train()
        train.makeNoise()
        
        
        /// 重写属性的 getter 和 setter
        
        // - 可以提供一个自定义的 getter (和 setter，如果合适的话)来重写任意继承的属性，无论在最 开始继承的属性实现为储属性还是计算属性。
        
        class Car: Vehicle {
            var gear = 1
            override var description: String {
                return super.description + " in gear \(gear)"
            }
        }
        let car = Car()
        car.currentSpeed = 25.0
        car.gear = 3
        print(car.description)
        
        
        /// 重写属性的观察器
        
        // - 可以使用属性重写来为继承的属性添加属性观察器。这就可以让你在继承属性的值改变时得到通知，无论这个属性最初如何实现。
        // - 不能给继承而来的常量存储属性或者只读的计算属性添加属性观察器。这些属性的值不能被设置，所以提供 willSet 或 didSet 实现作为重写的一部分也是不合适的。
        // - 不能为同一个属性同时提供重写的 setter 和重写的属性观察器。如果你想要监听属性值的改变，并且你已经为那个属性提供了一个自定义的 setter，那么你从自定义的 setter 里就可以监听任意值的改变。
        
        class AutomaticCar: Car {
            override var currentSpeed: Double {
                didSet {
                    gear = Int(currentSpeed / 10.0) + 1
                }
            }
        }
        let automatic = AutomaticCar()
        automatic.currentSpeed = 35.0
        print(automatic.description)
        
        
        /// 阻止重写
        
        // - 可以通过标记为 final 来阻止一个方法、属性或者下标脚本被重写。
        // - 通过在方法、属性或者下标脚本的关键字前写 final 修饰符(比如 final var ， final func ， final class func ， final subscript)
        
        
        /// 多态和类型转换
        
        
        /// 类型检查
        
        // - 使用类型检查操作符( is )来检查一个实例是否属于一个特定的子类。如果实例是该子类类型，类型检查操作符返回 true ，否则返回 false 。
        
        class MediaItem {
            var name: String
            init(name: String) {
                self.name = name
            }
        }
        
        class Movie: MediaItem {
            var director: String
            init(name: String, director: String) {
                self.director = director
                super.init(name: name)
            }
        }
        
        class Song: MediaItem {
            var artist: String
            init(name: String, artist: String) {
                self.artist = artist
                super.init(name: name)
            }
        }
        
        let library = [Movie(name: "A", director: "a"), Song(name: "B", artist: "b"), Movie(name: "C", director: "c")]
        print(type(of: library))
        
        for item in library {
            if let realItem = item as? Movie {
                print(realItem.director)
            } else if let realItem = item as? Song {
                print(realItem.artist)
            }
        }
        
        
        /// 向下类型转换
        
        // - 某个类类型的常量或变量可能实际上在后台引用自一个子类的实例。当你遇到这种情况时你可以尝试使用类型转换操作符( as? 或 as! )将它向下类型转换至其子类类型。
        // - 由于向下类型转换可能失败，类型转换操作符就有了两个不同形式。条件形式， as? ，返回了一个你将要向下类型转换的值的可选项。强制形式， as! ，则将向下类型转换和强制展开结合为一个步骤。
        
        
        /// Any 和 AnyObject
        
        // - Swift 为不确定的类型提供了两种特殊的类型别名:
        // - （1）AnyObject 可以表示任何类类型的实例。
        // - （2）Any 可以表示任何类型，包括函数类型。
        
        
        /// 嵌套类型
        
        // - Swift 中的类，结构体和枚举可以进行嵌套，即在某一类型的内部定义类型，这种类型嵌套 在 Java 中称为内部类，在 C# 中称为嵌套类。
        // - 嵌套类型的能够访问它外部的成员。
        
        
        
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
