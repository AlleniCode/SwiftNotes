//
//  Swift27AccessControl.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/29.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift27AccessControl: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 权限控制
        
        
        /// 模块和源文件
        
        // - 模块指的是独立的代码分发单元，框架或应用程序会作为一个独立的模块来构建和发布。在 Swift 中,一个模块可以使用 import 关键字导入另外一个模块。
        // - 源文件就是 Swift 中的源代码文件, 它通常属于一个模块, 即一个应用程序或者框架。尽管我们一般会将不同的类型分别定义在不同的源文件中，但是同一个源文件也可以包含多个类型、函数之类的定义。
        
        
        /// 访问级别
        
        // - open: 公开权限, 最高的权限, 可以被其他模块访问, 继承及复写。只能用于类和类的成员。
        // - public: 公有访问权限，类或者类的公有属性或者公有方法可以从文件或者模块的任何地方进行访问。那么什么样才能成为一个模块呢?一个App就是一个模块，一个第三方API, 第三等方框架等都是一个完整的模块，这些模块如果要对外留有访问的属性或者方法，就应该使用 public 的访问权限。public 的权限在 Swift 3.0 后无法在其他模块被复写方法、属性或被继承。
        // - internal: 顾名思义，internal 是内部的意思，即有着 internal 访问权限的属性和方法说明在模块内部可以访问， 超出模块内部就不可被访问了。在 Swift 中默认就是 internal 的访问权限。
        // - fileprivate: 文件私有访问权限，被 fileprivate 修饰的类或者类的属性或方法可以在同一个物理文件中访问。如果超出该物理文件，那么有着 fileprivate 访问权限的类, 属性和方法就不能被访问。
        // - private: 私有访问权限，被 private 修饰的类或者类的属性或方法可以在同一个物理文件中的同一个类型(包含 extension)访问。如果超出该物理文件或不属于同一类型，那么有着 private 访问权限的属性和方法就不能被访问。
        
        
        /// 潜规则
        
        // - （1）如果一个类的访问级别是 fileprivate 或 private 那么该类的所有成员都是 fileprivate 或 private(此时成员无法修改访问级别)，如果一个类的访问级别是 open、internal 或者 public 那么它的所有成员都是 internal，类成员的访问级别不能高于类的访问级别(注意:嵌套 类型的访问级别也符合此条规则)。
        // - （2）常量、变量、属性、下标脚本访问级别低于其所声明的类型级别，并且如果不是默认访问级别 (internal)要明确声明访问级别(例如一个常量是一个 private 类型的类类型，那么此常量必须声明为 private 或 fileprivate)。
        // - （3）在不违反1、2两条潜规则的情况下，setter 的访问级别可以低于 getter 的访问级别(例如一个属性访问级别是 internal，那么可以添加 private(set) 修饰将 setter 权限设置为 private，在当前模块中只有此源文件可以访问，对外部是只读的)。
        // - （4）必要构造方法(required 修饰)的访问级别必须和类访问级别相同，结构体的默认逐一构造函 数的访问级别不高于其成员的访问级别(例如一个成员是 private 那么这个构造函数就是 private，但是可以通过自定义来声明一个 public 的构造函数),其他方法(包括其他构造方法 和普通方法)的访问级别遵循潜规则1。
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
