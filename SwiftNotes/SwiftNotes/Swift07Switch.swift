//
//  Swift07Switch.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/24.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift07Switch: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 复合匹配
        
        let char: Character = "a"
        switch char {
        case "a", "A":
            print("The letter A")
        default:
            print("Not the letter A")
        }
        
        
        /// 区间匹配
        
        let approximateCount = 62
        let countedThings = "moons orbiting Saturn"
        var naturalCount: String
        switch approximateCount {
        case 0:
            naturalCount = "no"
        case 1..<5:
            naturalCount = "a few"
        case 5..<12:
            naturalCount = "several"
        case 12..<100:
            naturalCount = "dozens of"
        case 100..<1000:
            naturalCount = "hundreds of"
        default:
            naturalCount = "many"
        }
        print("There are \(naturalCount) \(countedThings).")
        
        
        /// 元组匹配
        
        let somePoint = (1, 1)
        switch somePoint {
        case (0, 0):
            print("(0, 0) is at the origin")
        case (_, 0):
            print("(\(somePoint.0), 0) is on the x-axis")
        case (0, _):
            print("(0, \(somePoint.1)) is on the y-axis")
        case (-2...2, -2...2):
            print("(\(somePoint.0), \(somePoint.1)) is inside the box")
        default:
            print("(\(somePoint.0), \(somePoint.1)) is outside the box")
        }
        
        
        /// 值绑定
        
        let anotherPoint = (2, 0)
        switch anotherPoint {
        case (let x, 0):
            print("on the x-axis with an x value of \(x)")
        case (0, let y):
            print("on the y-axis with a y value of \(y)")
        case let (x, y):
            print("somewhere else at (\(x), \(y))")
        }
        
        
        /// where 语句
        
        let myPoint = (1, -1)
        switch myPoint {
        case let (x, y) where x == y:
            print("(\(x), \(y)) is on the line x == y")
        case let (x, y) where x == -y:
            print("(\(x), \(y)) is on the line x == -y")
        case let (x, y):
            print("(\(x), \(y)) is just some arbitrary point")
        }
        
        
        /// 控制转移
        // comtinue、break、fallthrough、return、throw
        
        // switch 没有隐式贯穿，使用 fallthrough 关键字达到贯穿行为
        let integerToDescribe = 5
        var description = "The number \(integerToDescribe) is"
        switch integerToDescribe {
        case 2, 3, 5, 7, 11, 13, 17, 19:
            description += " a prime number, and also"
            fallthrough
        default:
            description += " an integer."
        }
        print(description)
        
        
        /// 语句标签
        // 可以使用语句标签来给循环语句或者条件语句做标记。
        // 在一个条件语句中，可以使用一个语句标签配合 break 语句来结束被标记的语句。
        // 在一个循环语句中，可以使用语句标签来配合 break 或 continue 语句来结束或者继续执行被标记的语句。
        
        var number = 10
        whileLoop: while number > 0 {
            switch number {
            case 9:
                print("9")
            case 10:
                var sum = 0
                for index in 0...10 {
                    sum += index
                    if index == 9 {
                        print(sum)
                        break whileLoop
                    }
                }
            default:
                break
            }
            number -= 1
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
