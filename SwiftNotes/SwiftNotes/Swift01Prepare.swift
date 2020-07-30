//
//  Swift01Prepare.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/22.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift01Prepare: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Swift 学习
        
        // - 官方文档：https://docs.swift.org/swift-book/
        // - 源码：https://github.com/apple/swift
        // - objc.io：https://www.objc.io/

        
        /// 基本数据类型

        // 整数类型：`Int、Int8、UInt8、Int32、UInt32、Int64、UInt64`
        // 浮点数类型：`Float、Double`
        // 布尔类型：`Bool(true、false)`


        /// 声明常量和变量

        // 使用关键字 `let` 来声明常量
        // 使用关键字 `var` 来声明变量


        let num = 3
        var count = 10
        count = 11
        print(num)
        print(count)


        /// 类型别名

        // 使用关键字 `typealias` 定义一个类型别名

        typealias AudioSample = UInt8
        let sample: AudioSample = 32
        print(sample)
        
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
