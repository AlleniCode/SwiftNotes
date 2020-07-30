//
//  Swift21Protocol&Extension.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/27.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift21Protocol_Extension: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 在扩展里添加协议遵循
        
        // - 你可以扩展一个已经存在的类型来采纳和遵循一个新的协议，就算是你无法访问现有类型的源代码也行。
        // - 扩展可以添加新的属性、方法和下标到已经存在的类型，并且因此允许你添加协议需要的任何需要。
        
        let person = Person(name: "Allen", age: 18)
        print(person.textualDescription)
        
        
        /// 有条件地遵循协议
        
        // - 泛型类型可能只在某些情况下满足一个协议的要求，比如当类型的泛型形式参数遵循对应协议时。
        // - 你可以通过在扩展类型时列出限制让泛型类型有条件地遵循某协议。在你采纳协议的名字后面写泛型 where 分句。
        
        let array = [Person(name: "zhangsan", age: 10), Person(name: "lisi", age: 20)]
        print(array.textualDescription)
        
        
        /// 使用扩展声明采纳协议
        
        // - 如果一个类型已经遵循了协议的所有需求，但是还没有声明它采纳了这个协议，你可以让通过一个空的扩展来让它采纳这个协议。
        
        
        /// 协议扩展
        
        // - 协议可以通过扩展来提供方法和属性的实现以遵循类型。这就允许你在协议自身定义行为，而不是在每一个遵循或者在全局函数里定义。
        
        
        /// 提供默认实现
        
        // - 你可以使用协议扩展来给协议的任意方法或者计算属性要求提供默认实现。如果遵循类型给这个协议的要求提供了它自己的实现，那么它就会替代扩展中提供的默认实现。
        
        
        /// 给协议扩展添加限制
        
        // - 当你定义一个协议扩展，你可以明确遵循类型必须在扩展的方法和属性可用之前满足的限制。在扩展协议名字后边使用 where 分句来写这些限制。
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


protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Person: TextRepresentable {
    var textualDescription: String {
        return "name \(name), age \(age)"
    }
}

extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}


struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable {}



