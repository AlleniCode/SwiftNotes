//
//  Swift09Array.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/25.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift09Array: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 创建数组
        
        // 字面量创建
        let array = [1, 2, 3, 4, 5]
        print(array)
        
        let array1: [Int] = []
        print(array1)
        
        let array2: [String] = []
        print(array2)
        
        
        // 初始化器创建
        let array3 = [String]()
        print(array3)
        
        let array4 = Array<String>()
        print(array4)
        
        let array5 = Array(repeating: "A", count: 5)
        print(array5)
        
        let numbers = [Int](0...10)
        print(numbers)
        
        let chars = Array("hello")
        print(chars)
        
        let persons = ["zhangsan": 13, "lisi": 14, "wangwu": 15]
        let names = Array(persons.keys)
        print(names)
        
        
        /// 数组遍历（for-in、for-Each）
        
        // for-in
        let nums = [Int](0...7)
        for num in nums {
            print(num)
        }
        
        // 同时得到索引和值 enumerated()
        for (index, num) in nums.enumerated() {
            print("the index is \(index)")
            print(num * 10)
        }
        
        // forEach，无法使用 break 或 continue 跳出或者跳过循环，使用 return 只能退出当前一次循环的执行体
        /*
        let nums = [Int](0...7)
        nums.forEach { (num) in
            if num == 3 {
                break // 错误提示：Unlabeled 'break' is only allowed inside a loop or switch, a labeled break is required to exit an if or do
            }
            print(num * 10)
        }
        */
        
        // 使用 Iterator 迭代器遍历数组
        var numIterator = nums.makeIterator()
        while let num = numIterator.next() {
            print(num * 10)
        }
        
        
        /// 数组的索引
        // - startIndex 返回第一个元素的位置，对于数组来说，永远都是 0。
        // - endIndex 返回最后一个元素索引 +1 的位置，对于数组来说，等同于 count。
        // - 如果数组为空，startIndex 等于 endIndex。
        
        // 使用 indices 获取数组的索引区间
        let nums1 = [Int](2...7)
        for i in nums1.indices {
            print(nums1[i] * 10)
        }
        
        
        /// 数组的查找
        
        // 判断是否包含指定元素
        // - contains(_:) 判断数组是否包含给定元素
        // - contains(where:) 判断数组是否包含符合给定条件的元素
        let array6 = [10, 20, 30, 1]
        print(array6.contains(30))
        print(array6.contains(where: { $0 < 10}))
        
        // 判断所有元素是否符合某个条件
        // - allSatisfy(_:) 判断数组的每一个元素是否都符合给定的条件
        let array7 = [10, 20, 30, 1]
        print(array7.allSatisfy({ $0 > 10}))
        print(array7.allSatisfy({ $0 > 0}))
        
        // 查找元素
        let array8 = [1, 4, 5, 20, 10, 90, 100]
        print(array8.first ?? 0)
        print(array8.last ?? 0)
        print(array8.first(where: { $0 > 10}) ?? 0)
        print(array8.last(where: { $0 < 10}) ?? 0)
        
        // 查找索引
        let array9 = [1, 4, 5, 10, 20, 10, 90, 100]
        print(array9.firstIndex(of: 10) ?? 0)
        print(array9.lastIndex(of: 10) ?? 0)
        print(array9.firstIndex(where: { $0 > 10}) ?? 0)
        print(array9.lastIndex(where: { $0 < 10}) ?? 0)
        
        // 查找最大最小元素
        let array10 = [1, 4, 5, 10, 20, 10, 90, 100]
        print(array10.max() ?? 0)
        print(array10.min() ?? 0)
        
        let array11 = [(45, "error1"), (23, "error2"), (30, "error3")]
        print(array11.min(by: { a, b in a.0 < b.0}) ?? (0, "error"))
        print(array11.max(by: { a, b in a.0 < b.0}) ?? (0, "error"))
        
        
        /// 数组的添加和删除
        
        // 在末尾添加
        var array12 = [Int](1...7)
        array12.append(100) // 添加一个元素
        print(array12)
        array12.append(contentsOf: 100...105) // 添加多个元素
        print(array12)
        
        // 在任意位置插入
        var array13 = [Int](1...7)
        array13.insert(-1, at: 0)
        print(array13)
        array13.insert(contentsOf: -3...0, at: 0)
        print(array13)
        
        // 字符串也是 Collection，Element 是 Character 类型
        var chars1: [Character] = ["a", "b", "c"]
        chars1.insert(contentsOf: "hello", at: 0)
        print(chars1)
        
        // 移除单个元素
        var chars2: [Character] = ["a", "b", "c", "d"]
        let removeChar = chars2.remove(at: 1)
        print(removeChar)
        print(chars2)
        
        let removeChar1 = chars2.removeFirst()
        print(removeChar1)
        print(chars2)
        
        let removeChar2 = chars2.removeLast()
        print(removeChar2)
        print(chars2)
        
        let removeChar3 = chars2.popLast()
        print(removeChar3 ?? "")
        print(chars2)
        
        // 移除多个元素
        var chars3: [Character] = ["a", "b", "c", "d"]
        chars3.removeSubrange(1...2)
        print(chars3)
        
        chars3.removeAll(keepingCapacity: true)
        print(chars3)
        print(chars3.capacity)
        
        chars3.removeAll()
        print(chars3)
        print(chars3.capacity)
        
        chars3 = ["a", "b", "c", "d"]
        
        chars3.removeFirst(2)
        print(chars3)
        
        chars3.removeLast(2)
        print(chars3)
        
        
        /// ArraySlice 数组切片
        // - ArraySlice 是数组或者其他 ArraySlice 的一段连续切片，和原数组共享内存。
        // - 当要改变 ArraySlice 的时候，ArraySlice 会 copy 出来，形成单独内存。
        // - ArraySlice 拥有和 Array 基本完全类似的方法。
        
        // 通过 Drop 得到 ArraySlice
        let array14 = [1, 4, 5, 10, 20, 10, 90, 100]
        print(array14.dropFirst())
        print(array14.dropFirst(2))
        print(array14.dropLast())
        print(array14.dropLast(2))
        print(array14.drop(while: { $0 < 10 }))
        
        // 通过 Prefix 得到 ArraySlice
        let array15 = [1, 4, 5, 10, 20, 10, 90, 100]
        print(array15.prefix(4))
        print(array15.prefix(upTo: 4))
        print(array15.prefix(through: 4))
        print(array15.prefix(while: { $0 < 10}))
        
        // 通过 Suffix 得到 ArraySlice
        let array16 = [1, 4, 5, 10, 20, 10, 90, 100]
        print(array16.suffix(3))
        print(array16.suffix(from: 3))
        
        // 通过 Range 得到 ArraySlice
        let array17 = [1, 4, 5, 10, 20, 10, 90, 100]
        print(array17[3...5])
        print(array17[3..<5])
        print(array17[...5])
        print(array17[..<5])
        print(array17[5...])
        print(array17[...])
        
        // ArraySlice 无法直接赋值给一个 Array 的常量或者变量，需要使用 Array(slice)。
        var array18 = [1, 4, 5, 10, 20, 10, 90, 100]
        let slice = array18[3...5]
        array18 = Array(slice)
        print(array18)
        
        // ArraySlice 和 Array 是相互独立的，它们添加或者删除元素是不会影响对方的。
        var array19 = [10, 20, 30]
        var slice1 = array19.dropLast(1)
        
        array19.append(50)
        print(array19)
        print(slice1)
        
        slice1.append(60)
        print(array19)
        print(slice1)
        
        
        /// 数组重排操作
        
        // 数组元素的随机化
        // - shuffle() 在原数组上将数组元素打乱，只能作用在数组变量上。
        // - shuffled() 返回原数组的随机化数组，可以作用在数组变量和常量上。
        var array20 = [1, 2, 3, 4, 5, 6]
        array20.shuffle()
        print(array20)
        
        let array21 = [1, 2, 3, 4, 5, 6]
        let shuffledArray = array21.shuffled()
        print(shuffledArray)
        print(array21)
        
        // 数组的逆序
        // - reverse() 在原数组上将数组逆序，只能作用在数组变量上。
        // - reversed() 返回原数组的逆序集合表示，可以作用在数组变量和常量上，该方法不会分配新的内存空间。
        var array22 = [1, 2, 3, 4, 5, 6]
        array22.reverse()
        print(array22)
        
        let array23 = [1, 2, 3, 4, 5, 6]
        let reversedArray = array23.reversed()
        print(reversedArray)
        print(array23)
        
        // 数组的分组
        // - partition(by belongsInSecondPartition:(Element) throw -> Bool) 将数组以某个条件分组，数组前半部分都是不符合条件的元素，数组后半部分都是符合条件的元素。
        var array24 = [10, 20, 45, 30, 98, 101, 30, 4]
        let index = array24.partition(by: { $0 > 30 })
        print(index)
        print(array24)
        
        let partition1 = array24[..<index]
        let partition2 = array24[index...]
        print(partition1)
        print(partition2)
        
        // 数组的排序
        // - sort() 在原数组上将元素排序，只能作用在数组变量上。
        // - sorted() 返回原数组的排序结果数组，可以作用在数组变量个常量上。
        var array25 = [10, 20, 45, 30, 98, 101, 30, 4]
        array25.sort()
        print(array25)
        
        let array26 = [10, 20, 45, 30, 98, 101, 30, 4]
        let sortedArray = array26.sorted()
        print(sortedArray)
        
        let sortedArray1 = array26.sorted { (a, b) -> Bool in
            a > b
        }
        print(sortedArray1)
        
        // 交换数组两个元素
        // - swapAt(_:_:) 交换指定位置的两个元素
        var array27 = [10, 20, 45, 30, 98, 101, 30, 4]
        array27.swapAt(array27.startIndex, array27.endIndex - 1)
        print(array27)
        
        
        /// 数组的拼接操作
        
        // 字符串拼接操作
        // - joined() 拼接字符串数组里的所有元素为一个字符串。
        // - joined(separator:) 以给定的分隔符拼接字符串数组里的所有元素为一个字符串。
        let array28 = ["hello", "world"]
        print(array28.joined())
        print(array28.joined(separator: ","))
        
        // 元素为 Sequence 数组的拼接
        // - joined() 拼接数组里的所有元素为一个更大的 Sequence。
        // - joined(separator:) 以给定的分隔符拼接数组里的所有元素为一个更大的 Sequence。
        let ranges = [0...3, 8...10, 15...20]
        for range in ranges {
            print(range)
        }
        for i in ranges.joined() {
            print(i)
        }
        
        let nestedNumbers = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        let joined = nestedNumbers.joined(separator: [-1, -2])
        print(Array(joined))
        
        
        /// 数组的底层实现探究
        
        // 数组的协议结构：Sequence -> Collection -> RangeReplaceableCollection -> Array
        // 定义自己的 Sequence:
        // - 自定义 Iterator（遵守 IteratorProtocol 协议），内部实现 Element 数据类型和 next() 方法。
        // - 自定义 Sequence（继承 Sequence），内部实现 Iterator 的定义和 makeIterator() 方法。
        
        // 自定义斐波那契数列：
        let fibs = FibsSequence(10)
        for fib in fibs {
            print(fib)
        }
        
        
        /// 用数组来实现栈和队列
        
        // Stack 栈是一种后入先出的数据结构，仅限在栈顶进行插入或删除操作。
        var stack = Stack<Int>()
        print(stack.isEmpty)
        stack.push(1)
        stack.push(3)
        stack.push(10)
        print(stack.count)
        print(stack.pop() ?? 0)
        
        // Queue 队列是一种先进先出的数据结构。
        var queue = Queue<Int>()
        print(queue.isEmpty)
        queue.enqueue(1)
        queue.enqueue(3)
        queue.enqueue(10)
        print(queue.count)
        print(queue.dequeue() ?? 0)
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


struct FibsIterator: IteratorProtocol {
    let number: Int
    var index: Int = 0
    
    init(_ number: Int) {
        self.number = number
    }
    
    var state = (0, 1)
    mutating func next() -> Int? {
        if index >= number {
            return nil
        }
        index += 1
        
        let fibNumber = state.0
        state = (state.1, state.0 + state.1)
        return fibNumber
    }
}


struct FibsSequence: Sequence {
    let number: Int
    init(_ number: Int) {
        self.number = number
    }
    typealias Iterator = FibsIterator
    func makeIterator() -> FibsSequence.Iterator {
        return FibsIterator(number)
    }
}


struct Stack<T> {
    private var elements = [T]()
    
    var count: Int {
        return elements.count
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var peek: T? {
        return elements.last
    }
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T? {
        return elements.popLast()
    }
}


struct Queue<T> {
    private var elements = [T]()
    
    var count: Int {
        return elements.count
    }
    
    var isEmpty: Bool {
        return elements.isEmpty
    }
    
    var peek: T? {
        return elements.first
    }
    
    mutating func enqueue(_ element: T) {
        elements.append(element)
    }
    
    mutating func dequeue() -> T? {
        return isEmpty ? nil : elements.removeFirst()
    }
}
