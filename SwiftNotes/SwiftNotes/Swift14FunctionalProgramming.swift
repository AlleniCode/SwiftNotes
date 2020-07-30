//
//  Swift14FunctionalProgramming.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/26.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift14FunctionalProgramming: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 函数式编程
        
        // - 命令式编程风格常常被迫使我们出于性能考虑，把不同的任务交织起来，以便能够用一次循环来完成多个任务。
        // - 而函数式编程使用高阶函数把我们解放出来，让我们站在更高的抽象层次上去考虑问题，把问题看得更清楚。
        // - 面向对象编程通过封装不确定因素来使代码能被人理解；函数式编程通过尽量减少不确定因素来使代码能被人理解。
        // - 在面向对象的命令式编程语言里面，重用的单元是类和类之间沟通用的消息。
        // - 函数式编程语言实现重用的思路很不一样，函数式语言提倡在有限的几种关键数据结构上运用针对这些数据结构高度优化过的操作，以此构成基本的运转机构。
        // - 开发者再根据具体用途，插入自己的数据结构和高阶函数去调整机构的运转方式。
        // - 比起一味地创建新的类结构体系，把封装的单元降低到函数级别，更有利于达到细粒度的、基础层面的重用。
        // - 函数式程序员喜欢用少数几个核心数据结构，围绕它们去建立一套充分优化的运转机构。
        // - 面向对象程序员喜欢不断地创建新的数据结构和附属的操作，因为压倒一切的面向对象编程范式就是建立新的类和类间的消息。
        // - 把所有的数据结构都封装成类，一方面压制了方法层面的重用，另一方面鼓励了大粒度的框架式的重用。
        // - 函数式编程的程序结构更方便我们在比较小的层面上重用代码。

        
        /// 题目
        
        // 读入一个文本文件，确定所有单词的使用频率并从高到低排序，打印出所有单词及其频率的排序列表。
        let NON_WORDS: Set = ["the", "and", "of", "to", "it", "in", "or", "is", "as", "so", "but", "be"]
        let words = """
        I love and am used to keeping a distance with those changed things.Only in this way can I know what will not be abandoned by time. Forexample, when you love someone, changes are all around. Then I stepbackward and watching it silently, then I see the true feelings.
        """
        
        // （1）命令式解决方案：
        func wordFreq(words: String) -> [String: Int] {
            var wordDict: [String: Int] = [:]
            let wordList = words.split(separator: " ")
            for word in wordList {
                let lowercaseWord = word.lowercased()
                if !NON_WORDS.contains(lowercaseWord) {
                    if let count = wordDict[lowercaseWord] {
                        wordDict[lowercaseWord] = count + 1
                    } else {
                        wordDict[lowercaseWord] = 1
                    }
                }
            }
            return wordDict
        }
        print(wordFreq(words: words))
        
        // （2）函数式解决方案：
        func wordFreq1(words: String) -> [String: Int] {
            var wordDict: [String: Int] = [:]
            let wordList = words.split(separator: " ")
            wordList.map { $0.lowercased() }
                .filter { !NON_WORDS.contains($0) }
                .forEach { word in
                    wordDict[word] = (wordDict[word] ?? 0) + 1
            }
            return wordDict
        }
        print(wordFreq1(words: words))
        
        
        /// 具体业务需求
        
        // 假设我们有一个名字列表，其中一些条目有单个字符构成。现在的任务是，将除去单字符条目之外的列表内容，放在一个逗号分隔的字符串里返回，且每个名字的首字母都要大写。
        let employee = ["neal", "s", "stu", "j", "rich", "bob", "aiden", "j", "ethan", "liam", "mason", "moah", "lucas", "jacob", "jack"]
        
        // （1）命令式解法：
        func cleanNames(names: Array<String>) -> String {
            var cleanedNames = ""
            for name in names {
                if name.count > 1 {
                    cleanedNames += name.capitalized + ","
                }
            }
            cleanedNames.remove(at: cleanedNames.index(before: cleanedNames.endIndex))
            return cleanedNames
        }
        print(cleanNames(names: employee))
        
        // （2）函数式解法：
        func cleanNames1(names: Array<String>) -> String {
            let cleanedNames = names.filter { $0.count > 1 }
                .map { $0.capitalized }
                .joined(separator: ",")
            return cleanedNames
        }
        print(cleanNames1(names: employee))
        
        // 对并行操作的尝试改进
        let cleanedNames = employee.filter { $0.count > 1}
                                   .parallelMap { $0.capitalized }
                                   .joined(separator: ",")
        print(cleanedNames)
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

extension Array where Element: Any {
    // 该方法不稳定，有些问题
    func parallelMap<T>(_ transform: (Element) -> T) -> [T] {
        let n = self.count
        if n == 0 {
            return []
        }
        
        var result = ContiguousArray<T>()
        result.reserveCapacity(n)
        
        DispatchQueue.concurrentPerform(iterations: n) { i in
            result.append(transform(self[i]))
        }
        
        return Array<T>(result)
    }
}

