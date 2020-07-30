//
//  Swift16Property.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/27.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift16Property: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 如何为类、结构体、枚举添加属性
        
        
        /// 存储属性
        
        // 延迟存储属性
        // 延迟存储属性的初始值在其第一次使用时才进行计算。你可以通过在其声明前标注 lazy 修 饰语来表示一个延迟存储属性。
        // 如果被标记为 lazy 修饰符的属性同时被多个线程访问并且属性还没有被初始化，则无法保 证属性只初始化一次。
        
        class DataImpoeter {
            var fileName = "data.text"
            init() {
                print("DataImpoeter inits")
            }
        }
        
        class DataManager {
            lazy var importer = DataImpoeter()
            var data = [String]()
        }
        
        let manager = DataManager()
        manager.data.append("Some Data")
        manager.data.append("More Data")
        print("manager.data.append finish")
        print(manager.importer.fileName)
        
        
        /// 计算属性
        
        // 除了存储属性，类、结构体和枚举也能够定义计算属性，而它实际并不存储值。
        // 相反，它提供 一个读取器和一个可选的设置器来间接得到和设置其它的属性和值。
        
        struct Point {
            var x = 0.0
            var y = 0.0
        }
        
        struct Size {
            var width = 0.0
            var height = 0.0
        }
        
        struct Rect {
            var origin = Point()
            var size = Size()
            var center: Point {
                get {
                    let centerX = origin.x + (size.width / 2)
                    let centerY = origin.y + (size.height / 2)
                    return Point(x: centerX, y: centerY)
                }
                set(newCenter) {
                    origin.x = newCenter.x - (size.width / 2)
                    origin.y = newCenter.y - (size.height / 2)
                }
            }
        }
        
        // 简写 setter
        // 如果一个计算属性的设置器没有为将要被设置的值定义一个名字，那么它将被默认命名为 newValue 。
        struct Rect1 {
            var origin = Point()
            var size = Size()
            var center: Point {
                get {
                    return Point(x: origin.x + (size.width / 2), y: origin.y + (size.height / 2))
                }
                set {
                    origin.x = newValue.x - (size.width / 2)
                    origin.y = newValue.y - (size.height / 2)
                }
            }
        }
        
        // 简写 getter
        // 如果整个 getter 的函数体是一个单一的表达式，那么 getter 隐式返回这个表达式。
        struct Rect2 {
            var origin = Point()
            var size = Size()
            var center: Point {
                get {
                    Point(x: origin.x + (size.width / 2), y: origin.y + (size.height / 2))
                }
                set {
                    origin.x = newValue.x - (size.width / 2)
                    origin.y = newValue.y - (size.height / 2)
                }
            }
        }
        
        // 只读计算属性
        // 一个有读取器但是没有设置器的计算属性就是所谓的只读计算属性。只读计算属性返回一个 值，也可以通过点语法访问，但是不能被修改为另一个值。
        // 你必须用 var 关键字定义计算属性(包括只读计算属性)为变量属性，因为它们的值不是固 定的。 let 关键字只用于常量属性，用于明确那些值一旦作为实例初始化就不能更改。
        struct Rect3 {
            var origin = Point()
            var size = Size()
            var center: Point {
                return Point(x: origin.x + (size.width / 2), y: origin.y + (size.height / 2))
            }
        }
        
        
        /// 属性观察者
        
        // - willSet 会在该值被存储之前被调用。
        // - didSet 会在一个新值被存储后被调用。
        // - 如果你实现了一个 willSet 观察者，新的属性值会以常量形式参数传递。你可以在你的 willSet 实现中为这个参数定义名字。如果你没有为它命名，那么它会使用默认的名字 newValue 。
        // - 如果你实现了一个 didSet观察者，一个包含旧属性值的常量形式参数将会被传递。你可以为 它命名，也可以使用默认的形式参数名 oldValue 。如果你在属性自己的 didSet 观察者里给 自己赋值，你赋值的新值就会取代刚刚设置的值。
        
        class StepCounter {
            var totalSteps: Int = 0 {
                willSet {
                    print("About to set totalSteps to \(newValue)")
                }
                didSet {
                    if totalSteps > oldValue {
                        print("Added \(totalSteps - oldValue) steps")
                    }
                }
            }
            
        }
        
        let counter = StepCounter()
        counter.totalSteps = 100
        counter.totalSteps = 200
        counter.totalSteps = 300
        
        // 全局和局部变量
        // 观察属性的能力同样对全局变量和局部变量有效。全局变量是定义在任何函数、方法、闭包 或者类型环境之外的变量。局部变量是定义在函数、方法或者闭包环境之中的变量。
        var count: Int = 0 {
            willSet {
                print("About to set count to \(newValue)")
            }
            didSet {
                if count > oldValue {
                    print("Added \(count - oldValue)")
                }
            }
        }
        count = 10
        if count == 10 {
            print("ten")
        }
        
        
        /// 类型属性
        
        // 使用 static 关键字来定义类型属性。对于类类型的计算类型属性，你可以使用 class 关键字 来允许子类重写父类的实现。
        class SomeClass {
            static var storedTypeProperty = "some value"
            static var computedTypeProperty: Int {
                return 10
            }
            class var overrideableComputedTypeProperty: Int {
                return 20
            }
        }
        
        
        /// 实例方法-self
        
        // - 每一个类的实例都隐含一个叫做 self 的属性，它完完全全与实例本身相等。你可以使用 self 属性来在当前实例当中调用它自身的方法。
        // - 实际上，你不需要经常在代码中写 self。如果你没有显式地写出 self，Swift 会在你于方法中 使用已知属性或者方法的时候假定你是调用了当前实例中的属性或者方法。
        // - 例外就是当一个实例方法的形式参数名与实例中某个属性拥有相同的名字的时候。在这种情 况下，形式参数名具有优先权，并且调用属性的时候使用更加严谨的方式就很有必要了。你 可以使用 self 属性来区分形式参数名和属性名。
        
        struct Point1 {
            var x = 0.0, y = 0.0
            func isToTheRightOf(x: Double) -> Bool {
                return self.x > x
            }
        }
        let somePoint1 = Point1(x: 4.0, y: 5.0)
        print(somePoint1.isToTheRightOf(x: 1.0))
        
        
        /// 在实例方法中修改属性
        
        // - 结构体和枚举是值类型。默认情况下，值类型属性不能被自身的实例方法修改。
        // - 你可以选择在 func 关键字前放一个 mutating 关键字来指定方可以修改属性。
        struct Point2 {
            var x = 0.0, y = 0.0
            mutating func moveBy(x deltaX: Double, y deltaY: Double) {
                x += deltaX
                y += deltaY
            }
        }
        var somePoint2 = Point2(x: 1.0, y: 1.0)
        somePoint2.moveBy(x: 2.0, y: 3.0)
        print(somePoint2)
        
        // 在 mutating 方法中赋值给 self
        // Mutating 方法可以指定整个实例给隐含的 self 属性
        struct Point3 {
            var x = 0.0, y = 0.0
            mutating func moveBy(x deltaX: Double, y deltaY: Double) {
                self = Point3(x: x + deltaX, y: y + deltaY)
            }
        }
        var somePoint3 = Point3(x: 1.0, y: 1.0)
        somePoint3.moveBy(x: 2.0, y: 3.0)
        print(somePoint3)
        
        // 枚举的 mutating 方法
        // 枚举的异变方法可以设置隐含的 self 属性为相同枚举里的不同成员。
        enum TriStateSwitch {
            case off, low, high
            mutating func next() {
                switch self {
                case .off:
                    self = .low
                case .low:
                    self = .high
                case .high:
                    self = .off
                }
            }
            
        }
        var ovenLight = TriStateSwitch.low
        ovenLight.next()
        print(ovenLight)
        ovenLight.next()
        print(ovenLight)
        
        
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
