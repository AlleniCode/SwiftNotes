//
//  Swift02Tuple.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/22.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift02Tuple: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 介绍
        /*
        - 元组把多个值合并成单一的复合型的值。
        - 元组内的值可以是任何类型，而且可以不必是同一类型。
        - 元组中的每一个元素可以指定对应的元素名称。
        - 如果没有指定名称的元素，也可以使用下标的方式来引用。
        - 可以将一个元组的内容分解成单独的常量或变量。
        - 如果只需要使用其中的一部分数据，不需要的数据可以使用下划线 “`_`” 代替。
        - 使用 Tuple 为函数返回多个值。
        - 返回值的 Tuple 可以在函数的返回类型部分被命名。
        */
        
        
        /// 元组的定义
        
        let error = (1, "没有权限")
        print(error)
        // 使用下标访问
        print(error.0)
        print(error.1)
        
        let error1 = (errorCode: 1, errorMessage: "没有权限")
        print(error1)
        // 使用命名访问
        print(error1.errorCode)
        print(error1.errorMessage)
        
        
        /// 元组的修改
        
        var error2: (errorCode: Int, errorMessage: Any) = (errorCode: 1, errorMessage: "没有权限")
        print(error2)
        
        error2.errorCode = 2
        error2.errorMessage = "未知错误"
        
        
        /// 元组的分解
        
        let error3 = (1, "没有权限")
        let (errorCode, errorMessage) = error3
        print(errorCode)
        print(errorMessage)
        
        
        /// 函数的返回值
        
        func writeFile(content: String) -> (errorCode: Int, errorMessage: String) {
            return (1, "没有权限")
        }
        let error4 = writeFile(content: "")
        print(error4)
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
