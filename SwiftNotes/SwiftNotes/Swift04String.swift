//
//  Swift04String.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/23.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift04String: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 字符串里的特殊字符
        /*
        - 转义特殊字符：`\0`（空字符），`\\`（反斜杠），`\t`（水平制表符），`\n`（换行符），`\r`（回车符），`\"`（双引号），`\'`（单引号）。
        - 任意的 Unicode 标量，写作 `\u{n}`，里面的 `n` 是一个1~8位的16进制数字，其值是合法 Unicode 值。
        - 可以再多行字符串字面量中包含双引号（`"`）而不需要转义，要在多行字符串中包含文本 `"""`，转义至少一个双引号。
        */


        /// 扩展字符串分隔符（Raw String）
        /*
        - 在字符串字面量中放置扩展分隔符来在字符串中包含特殊字符而不让它们真的生效。
        - 把字符串放在双引号（`"`）内，并由井号（`#`）包裹。
        - 如果字符串里有 `"#` 则首位需要两个 `##`。
        - 如果需要字符串中某个特殊符号的效果，使用匹配你包裹的井号数量的井号，并在前面写转义符号 `\`。
        */

        
        /// 初始化字符串
        
        // 字面量
        let emptyString = ""
        print(emptyString)
        
        // 初始化器语法
        let emptyString1 = String()
        print(emptyString1)
        
        // 多行字面量
        let numbers = """
        1\
        2\
        3
            4
        5
        """
        print(numbers)
        
        // Raw String
        let str = "1\n2\n3"
        print(str)
        
        let str1 = #"1\n2\n3"#
        print(str1)
        
        let str2 = #"1\#n2\n3"#
        print(str2)
        
        let str3 = ##"1"#2\n3"##
        print(str3)
        
        let str4 = ##"1"#2\#n3"##
        print(str4)
        
        let str5 = ##"1"#2\##n3"##
        print(str5)
        
        
        /// 字符串拼接
        var welcome = "hello"
        welcome += " world"
        print(welcome)
        
        welcome.append("!")
        print(welcome)
        
        
        /// for-in 遍历字符串
        let name = "Allen"
        for c in name {
            print(c)
        }
        
        
        /// 字符串插值
        let result = "6 * 7 = \(6 * 7)"
        print(result)
        
        let result1 = #"6 * 7 = \(6 * 7)"#
        print(result1)
        
        let result2 = #"6 * 7 = \#(6 * 7)"#
        print(result2)
        
        
        /// 字符串索引
        let welcome1 = "hello"
        print(welcome1[welcome1.startIndex])
        print(welcome1[welcome1.index(before: welcome1.endIndex)])
        
        
        /// 字符串插入
        var welcome2 = "hello"
        welcome2.insert("!", at: welcome2.endIndex)
        print(welcome2)
        
        welcome2.insert(contentsOf: " there", at: welcome2.index(before: welcome2.endIndex))
        print(welcome2)
        
        
        /// 字符串删除
        var welcome3 = "hello world!"
        welcome3.remove(at: welcome3.index(before: welcome3.endIndex))
        print(welcome3)
        
        let range = welcome3.index(welcome3.endIndex, offsetBy: -6)..<welcome3.endIndex
        welcome3.removeSubrange(range)
        print(welcome3)
        
        
        /// 子字符串 Substring
        let welcome4 = "hello, world"
        let index = welcome4.firstIndex(of: ",") ?? welcome4.endIndex
        let subString = welcome4[..<index]
        print(subString)
        
        
        /// 字符串比较
        let welcome5 = "hello"
        let welcome6 = "hello world"
        print(welcome5 == welcome6)
        print(welcome5.hasPrefix("hello"))
        print(welcome6.hasPrefix("hello"))
        print(welcome5.hasSuffix("world"))
        print(welcome6.hasSuffix("world"))
        
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
