//
//  Swift05Operator.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/23.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift05Operator: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 溢出运算符
        
        print(UInt8.max)
        let num1: UInt8 = 250
        let num2 = num1 &+ 10
        print(num1)
        print(num2)
        
        print(UInt8.min)
        let num3: UInt8 = 0
        let num4 = num3 &- 10
        print(num3)
        print(num4)
        
        
        /// 合并空值运算符
        
        let a: Int? = nil
        let b = 8
        print(a ?? b)
        
        func addTwoNumbers(num1: Int?, num2: Int?) -> Int {
            return (num1 ?? 0) + (num2 ?? 0)
        }
        print(addTwoNumbers(num1: nil, num2: nil))
        print(addTwoNumbers(num1: 1, num2: nil))
        print(addTwoNumbers(num1: nil, num2: 2))
        print(addTwoNumbers(num1: 1, num2: 2))
        
        
        /// 区间运算符
        
        // 闭区间运算符（a...b）
        for i in 1...5 {
            print(i)
        }
        
        // 半开区间运算符（a..<b）
        for i in 1..<5 {
            print(i)
        }
        
        // 单侧区间（a...、...b、..<c）
        let names = ["zhangsan", "lisi", "wangwu", "zhaoliu"]
        for name in names[2...] {
            print(name)
        }
        for name in names[...2] {
            print(name)
        }
        for name in names[..<2] {
            print(name)
        }
        
        let range = ...5
        print(range.contains(6))
        print(range.contains(3))
        print(range.contains(-1))
        
        let range1 = "a"..."z"
        let welcome = "hello,world"
        for char in welcome {
            if !range1.contains(String(char)) {
                print("\(char) 不是小写字母")
            }
        }
        
        // 倒序索引 reversed()
        for i in (1...5).reversed() {
            print(i)
        }
        
        
        /// 位运算符
        /*
        - 取反运算符（`~`），0 变 1，1 变 0。
        - 与运算符（`&`），都是 1 才为 1，有一个是 0 即为 0。
        - 或运算符（`|`），只要有一个 1 就为 1，否则都为 0。
        - 异或运算符（`^`），不同为 1，相同为 0。
        - 左移运算符（`<<`），同时向左移，无符号用 0 补位，有符号用符号位补位。
        - 右移运算符（`>>`），同时向右移，无符号用 0 补位，有符号用符号位补位。
        */
        
        let number: UInt8 = 8
        print(~number)
        print(number & 0)
        print(number & 1)
        print(number | 0)
        print(number ^ 3)
        print(number << 1)
        print(number >> 1)
        
        let number1: Int8 = -8
        print(number1 << 1)
        print(number1 >> 1)
        
        
        /// 不借助临时变量，交换两个变量的值
        var i = 10
        var j = 8
        i = i ^ j
        j = i ^ j
        i = i ^ j
        print(i)
        print(j)
        
        
        /// 求无符号整数二进制中1的个数
        /*
         思路一：
             看一个八位整数 10100001，先判断最后一位是否为1，而“与”操作可以达到目的。
             可以把这个八位的数字与 00000001 进行“与”操作。
             如果结果为 1，则表示当前八位数的最后一位为 1，否则为 0。
             怎么判断第二位呢？
             向右移位，再延续前面的判断即可。
         */
        func countOfOnes(num: UInt) -> UInt {
            var count: UInt = 0
            var temp = num
            while temp != 0 {
                count += temp & 1
                temp = temp >> 1
            }
            return count
        }
        print(countOfOnes(num: 0b10100001)) // 3
        
        /*
         思路二：
             为了简化这个问题，我们考虑只有高位有 1 的情况。
             例如：11000000，如何跳过前面低位的 6 个 0，而直接判断第七位的 1？
             我们可以设计 11000000 和 10111111（也就是 11000000 - 1）做“与”操作，消去最低位的 1。
             如果得到的结果为 0，说明我们已经找到或者消去里面最后一个 1。
             如果不为 0，那么说明我们消去了最低位的 1，但是二进制中还有其他的 1，我们的计数器需要加 1，然后继续上面的操作。
         */
        func countOfOnes1(num: UInt) -> UInt {
            var count: UInt = 0
            var temp = num
            while temp != 0 {
                count += 1 // 整数不为 0，说明二进制中肯定有 1，count 先加上 1
                temp = temp & (temp - 1) // 结果不为 0，说明二进制中还有 1，继续循环 count+1
            } // 结果为 0，终止循环，返回 count
            return count
        }
        print(countOfOnes1(num: 0b11000000))
        print(countOfOnes1(num: 0b11000011))
        
        
        /// 如何判断一个整数为 2 的整数次幂
        
        /*
         思路：
             一个整数如果是 2 的整数次方，那么它的二进制表示中有且只有一位是 1，而其它所有位都是 0。
             根据前面的分析，把这个整数减去 1 后再和它自己做“与”运算，这个整数中唯一的 1 就变成 0 了，也就是得到的结果为 0。
         */
        func isPowerOfTwo(num: UInt) -> Bool {
            return (num & (num - 1)) == 0
        }
        print(isPowerOfTwo(num: 512))
        print(isPowerOfTwo(num: 511))
        
        
        /// 缺失的数字
        // （1）很多成对出现的正整数保存在磁盘文件中，注意成对的数字不一定是相邻的，如 2，3，4，3，4，2...，由于意外有一个数字消失了，如何尽快找到是哪个数字消失了？
        /*
         思路：
             考虑“异或”操作的定义，当两个操作数的对应位不相同时，该数的对应位就为 1。
             也就是说如果相等的两个数“异或”，得到的结果为 0，而 0 与任何数字“异或”，得到的是那个数字本身。
             所以我们考虑将所有的数字做“异或”操作，因为只有一个数字消失，那么其他两两出现的数字“异或”后为 0，0 与仅有的一个数字做“异或”，我们就得到了消失的那个数字。
         */
        func findLostNum(nums: [UInt]) -> UInt {
            var lostNum: UInt = 0
            for num in nums {
                lostNum = lostNum ^ num
            }
            return lostNum
        }
        print(findLostNum(nums: [1, 2, 3, 4, 3, 2, 1]))
        
        // （2）如果有两个数字意外丢失了（丢失的数字不相等），该如何找到丢失的两个数字？
        /*
         思路：
         设题目中这两个只出现一次的数字分别是 A 和 B，如果能将 A、B 分开到两个数组中，那显然符合“异或”解法的关键点了。
         因此这个题目的关键点就是将 A、B 分开到两个数组中。
         由于 A、B 肯定是不相等的，因此在二进制上必定有一位是不同的。
         根据这一位是 0 还是 1 可以将 A、B 分开到 A 组和 B 组。
         再对 A 组和 B 组分别执行“异或”解法就可以得到 A、B 了。
         而要判断 A、B 在哪一位上不同，只要根据“A 异或 B”的结果就可以知道了，这个结果在二进制上为 1 的位都说明 A、B 在这一位上是不同的。
         */
        func findTowLostNums(nums: [UInt]) -> (UInt, UInt) {
            var lostNum1: UInt = 0
            var lostNum2: UInt = 0
            var temp: UInt = 0
            // 计算两个数的异或结果（相同数字的异或结果为 0，所以循环结束其实计算的就是 A、B 的异或结果）
            for num in nums {
                temp = temp ^ num
            }
            // 找到第一个为 1 的位
            var flag: UInt = 1
            while ((flag & temp) == 0) {
                flag = flag << 1
            }
            // 找两个丢失的数字
            for num in nums {
                if (num & flag) == 0 {
                    lostNum1 = lostNum1 ^ num
                } else {
                    lostNum2 = lostNum2 ^ num
                }
            }
            return (lostNum1, lostNum2)
        }
        print(findTowLostNums(nums: [1, 2, 3, 4, 5, 3, 2, 1]))
        
        
        /// 运算符重载
        
        // 类和结构体可以为现有的运算符提供自定义的实现，称为运算符重载。
        let vector1 = Vector2D(x: 3.0, y: 1.0)
        let vector2 = Vector2D(x: 2.0, y: 4.0)
        let vector3 = vector1 + vector2
        print(vector3)
        
        // 一元运算符重载：要实现前缀或者后缀运算符，需要在声明运算符函数的时候在 func 关键字之前指定 prefix 或者 postfix 限定。
        let positive = Vector2D(x: 3.0, y: 4.0)
        let negative = -positive
        print(negative)
        let alsoPositive = -negative
        print(alsoPositive)
        
        // 组合赋值运算符：在实现的时候，需要把运算符的左参数设置成 inout 类型，因为这个参数的值会在运算符函数内直接被修改。
        var orignal = Vector2D(x: 1.0, y: 2.0)
        let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
        orignal += vectorToAdd
        print(orignal)
        
        // 等价运算符重载：
        // - 自定义的类个结构体不接收等价运算符的默认实现，也就是所谓的“等于”运算符（==）和“不等于”运算符（!=）。
        // - 要使用等价运算符来检查你自己类型的等价，需要和其他中缀运算符一样提供一个“等于”运算符重载，并且遵循标准库的 Equatable 协议。
        // - Swift 为以下自定义类型提供等价运算符合成实现：
        //   （1）只拥有遵循 Equatable 协议存储属性的结构体。
        //   （2）只拥有遵循 Equatable 协议关联类型的枚举。
        //   （3）没有关联类型的枚举。
        let vector4 = Vector2D(x: 1.0, y: 2.0)
        let vector5 = Vector2D(x: 1.0, y: 2.0)
        let vector6 = Vector2D(x: 3.0, y: 4.0)
        print(vector4 == vector5)
        print(vector5 == vector6)
        
        
        /// 自定义运算符
        // 新的运算符要在全局作用域内，使用 operator 关键字进行声明，同时还要指定 prefix、infix、postfix 限定符。
        var tobeDoubled = Vector2D(x: 1.0, y: 3.0)
        let afterDoubling = +++tobeDoubled
        print(afterDoubling)
        
        
        /// 自定义中缀运算符的优先级和结合性
        // - 自定义的中缀（infix）运算符也可以指定优先级和结合性。
        // - 每一个自定义的中缀运算符都属于一个优先级组。
        // - 优先级组指定了自定义中缀运算符和其他中缀运算符的关系。
        let firstVector = Vector2D(x: 1.0, y: 2.0)
        let secondVector = Vector2D(x: 3.0, y: 4.0)
        let thirdVector = Vector2D(x: 5.0, y: 6.0)
        
        let plusMinusVector = firstVector +- secondVector
        print(plusMinusVector)
        
        let resutVector = firstVector +- secondVector *^ thirdVector
        print(resutVector)
        
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


struct Vector2D {
    var x = 0.0
    var y = 0.0
}

prefix operator +++

infix operator +-: AdditionPrecedence

infix operator *^: MultiplicationPrecedence

precedencegroup MyPrecedence {
    associativity: left // 左结合
    lowerThan: AdditionPrecedence // 低于加法运算符
}

extension Vector2D: Equatable {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
    
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
    
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
    
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
    
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
    
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
    
    static func *^ (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x * right.x, y: left.y * left.y + right.y * right.y)
    }
}


