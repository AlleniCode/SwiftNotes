//
//  Swift06Forin.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/24.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift06Forin: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// for in 遍历序列
        for i in 0...10 {
            print(i)
        }
        
        for c in "Hello" {
            print(c)
        }
        
        // 如果不需要序列的每一个值，可以使用下划线来取代遍历名以忽略值
        let base = 3
        let power = 5
        var answer = 1
        for _ in 1...power {
            answer *= base
        }
        print("\(base) to the power of \(power) is \(answer)")
        
        
        /// for in 遍历字典
        let numberOfLegs = ["Spider": 8, "Ant": 6, "Cat": 4]
        
        for (animalName, legCount) in numberOfLegs {
            print("\(animalName) has \(legCount) legs")
        }
        
        for t in numberOfLegs {
            print("\(t.0) has \(t.1) legs")
        }
        
        
        /// for in 遍历分段区间
        let minuteInterval = 5
        
        for tickMark in stride(from: 0, to: 50, by: minuteInterval) {
            print(tickMark)
        }
        
        for tickMark in stride(from: 0, through: 50, by: minuteInterval) {
            print(tickMark)
        }
        
        
        /// while 循环
        var count = 0
        repeat {
            print(count)
            count += 1
        } while count < 5 
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
