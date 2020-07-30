//
//  Swift11Dictionary.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/26.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift11Dictionary: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 介绍
        
        // - 字典储存无序的互相关联的同一类型的键和同一类型的值的集合。
        // - 字典类型的全写方式 Dictionary<Key, Value>，简写方式 [Key: Value]，建议使用简写方式。
        // - 字典的 Key 必须是可哈希的。
        
        
        /// 创建字典
        
        // 初始化器方式
        let dict = Dictionary<String, Int>()
        print(dict)
        
        // 简写方式
        let dict1 = [String: Int]()
        print(dict1)
        
        // 字面量方式
        var dict2: Dictionary<String, Int> = [:]
        dict2 = ["zhangsan": 18, "lisi": 19, "wangwu": 20]
        print(dict2)
        
        // 元素个数
        let dict3 = ["zhangsan": 18, "lisi": 19, "wangwu": 20]
        print(dict3.count)
        
        // 是否为空
        var dict4: Dictionary<String, Int> = [:]
        print(dict4.isEmpty)
        
        dict4 = ["zhangsan": 18, "lisi": 19, "wangwu": 20]
        print(dict4.isEmpty)
        
        
        /// 遍历字典
        
        // for-in 遍历
        let dict5 = ["A": 1, "B": 2, "C": 3]
        for (key, value) in dict5 {
            print("\(key) value is \(value)")
        }
        for key in dict5.keys.sorted() {
            print("\(key) value is \(String(describing: dict5[key]))")
        }
        
        
        /// 添加或更新元素
        
        // - 使用下标添加或更新元素。
        // - 使用 updateValue(_:forKey:) 方法添加或更新元素，返回一个字典值类型的可选项。
        var dict6 = ["A": 1, "B": 2, "C": 3]
        dict6["A"] = 0
        print(dict6)
        
        dict6.updateValue(1, forKey: "A")
        print(dict6)
        
        
        /// 移除元素
        
        // - 使用下标脚本语法给一个键赋值 nil 来从字典中移除一个键值对。
        // - 使用 removeValue(forKey:) 来从字典里移除键值对，如果它们存在的话，返回移除的值，否则返回 nil。
        var dict7 = ["A": 1, "B": 2, "C": 3]
        dict7["A"] = nil
        print(dict7)
        
        dict7.removeValue(forKey: "B")
        print(dict7)
        
        
        /// 合并两个字典
        
        // - merge(_:uniquingKeysWith:)
        var dict8 = ["A": 1, "B": 2, "C": 3]
        let dict9 = ["D": 4, "E": 5, "F": 6]
        dict8.merge(dict9, uniquingKeysWith: { (current, _) in current })
        print(dict8)
        
        let dict10 = ["D": 5, "E": 6, "F": 6]
        dict8.merge(dict10, uniquingKeysWith: { (_, new) in new })
        print(dict8)
        
        
        /// KeyValuePairs
        
        // 虽然字典是无序的，但是每个 kv 对在扩容之前的位置是稳定的，如果你需要保持顺序的 kv 对可以使用 KeyValuePairs。
        let dict11: KeyValuePairs = ["A": 1, "B": 2, "C": 3]
        print(dict11.first!) // 打印的就是放进的顺序
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
