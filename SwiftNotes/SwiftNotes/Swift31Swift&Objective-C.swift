//
//  Swift31Swift&Objective-C.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/29.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift31Swift_Objective_C: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// Swift 和 Objective-C 混合编程
        
        
        /// OC 和 Swift 运行时简介
        
        
        /// Objective-C 运行时
        
        // - 动态类型(dynamic typing)
        // - 动态绑定(dynamic binding)
        // - 动态装载(dynamic loading)
        
        // 派发方式:
        // - 直接派发（Direct Dispatch）
        // - 函数表派发（Table Dispatch）
        // - 消息机制派发 (Message Dispatch)
        
        // 直接派发:
        // - 直接派发是最快的, 不止是因为需要调用的指令集会更少, 并且编译器还能够有很大的优化空间, 例如函数内联等, 直接派发也有人称为静态调用。
        // - 然而, 对于编程来说直接调用也是最大的局限, 而且因为缺乏动态性所以没办法支持继承和多态。
        
        // 函数表派发:
        // - 函数表派发是编译型语言实现动态行为最常见的实现方式. 函数表使用了一个数组来存储类声明的 每一个函数的指针. 大部分语言把这个称为 “virtual table”(虚函数表), Swift 里称为 “witness table”. 每一个类都会维护一个函数表, 里面记录着类所有的函数, 如果父类函数被 override 的 话, 表里面只会保存被 override 之后的函数. 一个子类新添加的函数, 都会被插入到这个数组的最 后. 运行时会根据这一个表去决定实际要被调用的函数.
        // - 查表是一种简单, 易实现, 而且性能可预知的方式. 然而, 这种派发方式比起直接派发还是慢一点. 从字节码角度来看, 多了两次读和一次跳转, 由此带来了性能的损耗. 另一个慢的原因在于编译器可能会由于函数内执行的任务导致无法 优化. (如果函数带有副作用的话)
        // - 这种基于数组的实现, 缺陷在于函数表无法拓展. 子类会在虚数函数表的最后插入新的函数, 没有位置可以让 extension 安全地插入函数.
        
        // 消息机制派发:
        // - 消息机制是调用函数最动态的方式. 也是 Cocoa 的基石, 这样的机制催生了 KVO, UIAppearence 和 CoreData 等功能. 这种运作方式的关键在于开发者可以在运行时改变函数 的行为. 不止可以通过 swizzling 来改变, 甚至可以用 isa-swizzling 修改对象的继承关系, 可 以在面向对象的基础上实现自定义派发.
        
        
        /// Swift 运行时
        
        // - https://github.com/apple/swift/blob/f4db1dd7a4abba2685247e1a7415d4fcb91f640d/stdlib/public/runtime/SwiftObject.h
        
        // - 纯 Swift 类的函数调用已经不再是 Objective-c 的运行时发消息，而是类似 C++ 的 vtable，在编译时就确定了 调用哪个函数，所以没法通过 runtime 获取方法、属性。
        // - 而 Swift 为了兼容 Objective-C，凡是继承自 NSObjec t的类都会保留其动态性，所以我们能通过 runtime 拿 到他的方法。这里有一点说明:老版本的 Swift(如2.2)是编译期隐式的自动帮你加上了@objc，而4.0以后版 本的 Swift 编译期去掉了隐式特性，必须使用显式添加。
        // - 不管是纯 Swift 类还是继承自 NSObject 的类只要在属性和方法前面添加 @objc 关键字就可以使用 runtime。
        
        // - 值类型总是会使用直接派发, 简单易懂。
        // - 而协议和类的 extension 都会使用直接派发。
        // - NSObject 的 extension 会使用消息机制进行派发。
        // - NSObject 声明作用域里的函数都会使用函数表进行派发。
        // - 协议里声明的, 并且带有默认实现的函数会使用函数表进行派发。
        
        // Swift 运行时-final @objc:
        // - 可以在标记为 final 的同时, 也使用 @objc 来让函数可以使用消息机制派发. 这么做的结果就 是, 调用函数的时候会使用直接派发, 但也会在 Objective-C 的运行时里注册相应的 selector. 函数可以响应 perform(selector:) 以及别的 Objective-C 特性, 但在直接调用时又可以有直接 派发的性能.
        
        
        /// 桥接
        
        // - 桥接头文件：项目名-Bridging-Header.h。
        
        
        /// Swift 调用 OC
        
        // - 在桥接头文件内 import OC 的 .h 文件。
        
        
        /// OC 调用 Swift
        
        // - 在 OC 里加入：#import "项目名-Swift.h"。
        // - Swift 的类需要继承自 NSObject, 且属性和方法前面需要加 @objc 修饰符。
        
        
        /// NS_SWIFT_NAME
        
        // - 在 Objective-C 中，重新命名在swift中的名称。
        
        
        /// NS_SWIFT_UNAVAILABLE
        
        // - 在 Swift 中不可见，不能使用。
        
        
        /// 采坑指南
        
        // Subclass:
        // - 对于自定义的类而言，Objective-C 的类，不能继承自 Swift 的类，即要混编的 OC 类不能是 Swift 类的子类。反过来，需要混编的 Swift 类可以继承自 OC 的类。
        
        // OC 的宏:
        // - 定义一个常量值，后面可以方便使用;如 #define TOOLBAR_HEIGHT 44;
        // - 定义一个不变化的常用值，或者一个较长的对象属性;如#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width);
        // - 定义一个会变化的常用变量值，或者一个较长的对象属性;如:#define STATUS_BAR_HEIGHT ([UIApplication sharedApplication].statusBarFrame.size.height);
        // - 定义一个带参数的宏，类似于一个函数;如#define RGB_COLOR(r,g,b) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.0]
        
        // Swift 中对应宏的处理：
        // - 第一种的话就比较简单，可以直接使用let TOOLBAR_HEIGTH:CGFloat = 44来替换就可以了;
        // - 第二种因为后面的值永远不会改变，也可以使用let来替换;可以用let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width;
        // - 第三种情况，也就是后面的值会发生改变，如状态栏高度，就不能够使用let来替换了，因为let是定义的常量，如果使用let，将 会导致不能够获取正确的值;这里可以使用函数来获取:func STATUSBAR_HEIGHT() -> CGFloat { return UIApplication.sharedApplication().statusBarFrame.size.height };使用时通过函数STATUSBAR_HEIGTH()获取状态栏高度;
        // - 第四种，因为有输入参数，所以也只能使用函数来替换;如:func RGB_COLOR(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {return UIColor(red: r, green: g, blue: b, alpha: 1.0)};
        
        // Swift 独有特性:
        // - Swift 中有许多 OC 没有的特性，比如，Swift 有元组、为一等公民的函数、还有特有的枚举类型。所以，要使用的混编文件要注意 Swift 独有属性问题。
        
        // NS_REFINED_FOR_SWIFT:
        // - Objective-C 的 API 和 Swift 的风格相差比较大，Swift 调用 Objective-C 的API时可能由于数据类型等不 一致导致无法达到预期(比如，Objective-C 里的方法采用了C语言风格的多参数类型;或者 Objective-C 方法返回 NSNotFound，在 Swift 中期望返回 nil)。这时候就要 NS_REFINED_FOR_SWIFT了。
        /*
             // OC 文件：
             @interface MyClass: NSObject
             
             - (NSUIteger)indexOfString:(NSString *)aString NS_REFINED_FOR_SWIFT;
             
             @end
             
             // Swift 文件：
             extension MyClass {
                 func indexOfString(aString: String!) -> Int? {
                     let index = Int(__index(of: aString))
                     if index == NSNotFound {
                         return nil
                     }
                     return index
                 }
             }
        */
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
