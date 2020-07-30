//
//  Swift10Set.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/25.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift10Set: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 介绍
        // Set 集合的三个特性
        // - （1）确定性：给定一个集合，任给一个元素，该元素或者属于或者不属于该集合，二者必居其一。
        // - （2）互斥性：一个集合中，任何两个元素都是不相同的，即每个元素只能出现一次。
        // - （3）无序性：一个集合中，每个元素的地位都是相同的，元素之间是无序的。
        
        // - Set 存储的类型必须是可哈希的，就是说类型必须提供计算它自身哈希值的方法。
        // - 所有 Swift 的基础类型（String、Int、Double、Bool 等）默认都是可哈希的，并且可以用于 Set 或者 Dictionary 的键。
        
        
        /// 创建 Set
        
        // 使用初始化器创建
        let set = Set<Character>()
        print(set)
        
        // 使用字面量创建
        let course: Set<String> = ["Math", "English", "History"]
        print(course)
        
        
        /// Set 类型的哈希值
        
        // 为了能把自定义的类型存储到 Set 集合里，需要实现 Hashable 协议。
        var personSet = Set<Person>()
        personSet.insert(Person(name: "Allen", age: 30))
        print(personSet)
        
        
        /// 遍历 Set
        
        // for-in 遍历
        let courseSet: Set<String> = ["Math", "English", "History"]
        for course in courseSet {
            print(course)
        }
        for course in courseSet.sorted() {
            print(course)
        }
        
        // 获取 Set 的元素个数
        let set1: Set<Character> = ["A", "B", "C"]
        print(set1.count)
        
        // 判断 Set 是否为空
        let set2: Set<Character> = ["A", "B", "C"]
        print(set2.isEmpty)
        
        
        /// Set 添加元素
        
        // insert(_:) 添加一个元素到 Set。
        var set3: Set<Character> = ["A", "B", "C"]
        set3.insert("D")
        print(set3)
        
        // update(with:) 如果已经有相等的元素，替换为新元素。如果 Set 中没有，则插入。
        var set4: Set<Character> = ["A", "B", "C"]
        set4.update(with: "E")
        print(set4)
        
        
        /// Set 移除元素
        
        // filter(_:) 返回一个新的 Set，新 Set 的元素是原始 Set 符合条件的元素。
        let set5: Set<Character> = ["A", "B", "C"]
        print(set5.filter({ $0 > "A" }))
        
        // remove(_:) 从 Set 中移除一个元素，如果元素是 Set 的成员就移除它，并且返回移除的值，如果集合中没有这个成员就返回 nil。
        var set6: Set<Character> = ["A", "B", "C"]
        print(set6.remove("A") ?? "")
        print(set6.remove("D") ?? "")
        
        // removeAll() 移除所有元素
        var set7: Set<Character> = ["A", "B", "C"]
        set7.removeAll()
        print(set7)
        
        // removeFirst() 移除 Set 的第一个元素，因为 Set 是无序的，所以第一个元素并不是放入的第一个元素。
        var set8: Set<Character> = ["A", "B", "C"]
        set8.removeFirst()
        print(set8)
        
        
        /// 基本 Set 操作的定义
        // - intersection(_:) 交集，由属于 A 且属于 B 的相同元素组成的集合，记作 A∩B。
        // - union(_:) 并集，由所有属于集合 A 和属于集合 B 的元素所组成的集合，记作 A∪B。
        // - symmetricDifference(_:) 对称差集，集合 A 与集合 B 中所有不属于 A∩B 的元素的集合。
        // - subtracting(_:) 相对补集，由属于 A 而不属于 B 的元素组成的集合，称为 B 关于 A 的相对补集，记作 A-B 或 A\B。
        
        let set9: Set<Character> = ["A", "B", "C"]
        let set10: Set<Character> = ["C", "D", "E"]
        print(set9.intersection(set10)) // 交集
        print(set9.union(set10)) // 并集
        print(set9.symmetricDifference(set10)) // 对称差集
        print(set9.subtracting(set10)) // 相对补集
        
        
        /// Set 判断方法
        // - isSubset(of:) 判断是否是另一个 Set 或者 Sequence 的子集。
        // - isSuperset(of:) 判断是否是另一个 Set 或者 Sequence 的超集。
        // - isStrictSubset(of:) 和 isStrictSuperset(of:) 判断是否是另一个 Set 的子集或超集，但是又不等于另一个 Set。
        // - isDisjoint(with:) 判断两个 Set 是否有公共元素，如果没有返回 true，如果有返回 false。
        
        let smallSet: Set = [1, 2, 3]
        let bigSet: Set = [1, 2, 3, 4]
        print(smallSet.isSubset(of: bigSet))
        print(bigSet.isSuperset(of: smallSet))
        print(smallSet.isStrictSubset(of: bigSet))
        print(bigSet.isStrictSuperset(of: smallSet))
        print(smallSet.isDisjoint(with: bigSet))
        
        
        /// 给定一个集合，返回这个集合的所有子集
        
        // 思路一：
        // 解这道题的思想本质上就是元素的选与不选的问题，于是我们就可以想到用二进制来代表选与不选的情况。
        // “1”代表这个元素已经选择，而“0”代表这个元素没有选择。
        // 假如三个元素 A、B、C，那么“101”就代表 B 没有选择，所以 “101” 代表的子集为 AC。
        
        func getSubsetsOfSet<T>(set: Set<T>) -> Array<Set<T>> {
            let count = 1 << set.count // 2的n次方，左移实现
            let elements = Array(set)
            var subSets = Array<Set<T>>()
            for i in 0..<count {
                var subSet = Set<T>()
                for j in 0...elements.count {
                    if ((i >> j) & 1) == 1 {
                        subSet.insert(elements[j])
                    }
                }
                subSets.append(subSet)
            }
            return subSets
        }
        print(getSubsetsOfSet(set: [1, 2, 3]))
        
        // 思路二：
        // 如果只有一个元素，那么它的子集有两个，分别是本身和空集，然后在已经有一个元素的子集的基础上，第二个元素有两种选法，那就是加入到前面的子集里面，或者不加入，也就是选与不选的问题。
        // 而前面的子集一共有两个，对每个子集都有来自于下一个元素的加入和不加入两种选法。
        // 那么就可以得出两个元素的子集一共有四个。
        // 依次类推，就可以得出 n 个元素的所有子集（n 个元素的子集一共用 2n 个，非空子集一共有 2n-1 个）。
        
        func getSubsetsOfSet1<T>(elements: Array<T>, index: Int, count: Int) -> Array<Set<T>> {
            var subSets = Array<Set<T>>()
            // 处理只有一个元素的情况
            if index == 0 {
                subSets.append(Set<T>())
                var subSet = Set<T>()
                subSet.insert(elements[0])
                subSets.append(subSet)
                return subSets
            }
            
            subSets = getSubsetsOfSet1(elements: elements, index: index - 1, count: count)
            for subSet in subSets {
                var subSetWithCurrent = subSet
                subSetWithCurrent.insert(elements[index])
                subSets.append(subSetWithCurrent)
            }
            return subSets
        }
        
        func getSubsetsOfSet2<T>(set: Set<T>) -> Array<Set<T>> {
            let elements = Array(set)
            return getSubsetsOfSet1(elements: elements, index: elements.count - 1, count: elements.count)
        }
        print(getSubsetsOfSet2(set: [1, 2, 3]))
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


struct Person {
    var name: String
    var age: Int
}

extension Person: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(age)
    }
}
