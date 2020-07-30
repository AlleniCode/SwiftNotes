//
//  Swift33KVC&KVO.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/30.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class PersonXX: NSObject {
    @objc dynamic var age = 0
}

class Swift33KVC_KVO: UIViewController {
    
    @objc dynamic let p = PersonXX()
    var ob: NSKeyValueObservation?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// KVC/KVO
        
        
        /// KVC
        
        // - 从 Swift4 开始，类和 struct 都支持 KVC。
        // - 继承自 NSObject 的类，标记为 @objc 的属性可以使用 setValue(_:forKey)。
        // - 非继承自 NSObject 的类和结构体，使用索引+参数值。
        
        
        /// KVC-索引+参数名
        
        struct ValueType {
            var name: String
        }
        
        var obj = ValueType(name: "Objective-C")
        let name = \ValueType.name
        print(name)
        // set
        obj[keyPath: name] = "Swift"
        // get
        let valueOfName = obj[keyPath: name]
        print(valueOfName)
        
        class Teacher {
            var age = 0
            var name = ""
        }
        
        let teacher = Teacher()
        teacher[keyPath: \Teacher.name] = "Allen"
        let teacherName = teacher[keyPath: \Teacher.name]
        print(teacherName)
        
        
        /// KVO
        
        // - 只有 NSObject 才能支持 KVO。
        // - 要观察的属性必须使用 @objc dynamic 修饰。
        
        //@objc dynamic let p = Person()
        
        //var ob: NSKeyValueObservation?
        
        p.addObserver(self, forKeyPath: "age", options: [.new, .old], context: nil)
        
        // 建议使用这种方式
        ob = observe(\.p.age, options: [.new, .old]) { (_, change) in
            print(change.newValue as Any)
        }
        
        p.age = 3
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "age" {
            print("age 被改变了")
            print(change as Any)
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
