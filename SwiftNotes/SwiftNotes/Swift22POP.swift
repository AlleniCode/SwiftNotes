//
//  Swift22POP.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/28.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift22POP: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// OOP（Object Oriented Programming）面向对象编程
        
        // - 面向对象编程的三大特性：封装、继承、多态。
        // - 几乎所有的编程语言都支持OOP，Java、Ruby等语言的设计理念中几乎将一切事物都看作对象，对象即中心、对象即真理。
        
        // - OOP 的缺陷：
        // - （1）继承机制要求你在开始之前就能设计好整个程序的框架、结构、事物间的连接关系。这要求开发者必须有很好的分类设计能力，将不同的属性和方法分配的合适的层次里面去。设计清晰明了的继承体系总是很难的。(C++标准库不是面向对象的)
        // - （2）结构天生对改动有抵抗特性。这也是为什么OOP领域中所有程序员都对重构讳莫如深，有些框架到最后代码量急剧膨胀变得难以维护从而失控。(修改行为比修改结构简单)
        // - （3）继承机制带来的另一个问题就:很多语言都不提供多继承，我们不得不在父类塞入更多的内容，子类中会存在无用的父类属性和方法，而这些冗余代码给子类带来的一定的风险，而且对于层级很深的代码结构来说Bug修复将会成为难题。(组合优于继承)
        // - （4）对象的状态不是我们的编码的好友，相反是我们的敌人。对象固有的状态在分享和传递过程中是很难追踪调试的，尤其在并行程序编码中问题就更加明显。OOP 所带来的可变、不确定、复杂等特征完全与并行编程中倡导的小型化、核心化、高效化完全背离。(值类型优于引用类型)
        
        
        /// POP（protocol oriented programming）面向协议编程
        
        // - "A protocol defines a blueprint of methods, properties... The protocol can then be adopted by a class, structure, or enumeration”
        
        
        /// OOP vs POP
        
        // - OOP - 主要关心对象是什么
        // - POP - 主要关心对象做什么
        
        // OOP
        
        class Human {
            var name: String
            var age: Int
            
            init(name: String, age: Int) {
                self.name = name
                self.age = age
            }
            
            func sayHi() {
                print("Say hi")
            }
        }
        
        class Athlete: Human {
            override func sayHi() {
                print("Hi, I'm \(name)")
            }
        }
        
        class Runner: Athlete {
            func run() {
                print("run")
            }
        }
        
        class Swimer: Athlete {
            func swim() {
                print("swim")
            }
        }
        
        // 如果既是田径运动员，又是游泳运动员该怎么处理？？？
        
        // POP
        
        
        
        
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

// POP
protocol Human {
    var name: String { get set }
    var age: Int { get set }
    func sayHi()
}

protocol Runnable {
    func run()
}

protocol Swimming {
    func swim()
}

struct Runner: Human, Runnable {
    var name: String = "zhangsan"
    var age: Int = 18
    
    func sayHi() {
         print("Hi, I'm \(name)")
    }
    
    func run() {
        print("run")
    }
}

struct Swimer: Human, Swimming {
    var name: String = "lisi"
    var age: Int = 19
    
    func sayHi() {
         print("Hi, I'm \(name)")
    }
    
    func swim() {
        print("swim")
    }
}

struct AllAroundAthlete: Human, Runnable, Swimming {
    var name: String = "wangwu"
    var age: Int = 20
    
    func sayHi() {
         print("Hi, I'm \(name)")
    }
    
    func run() {
        print("run")
    }
    
    func swim() {
        print("swim")
    }
}
