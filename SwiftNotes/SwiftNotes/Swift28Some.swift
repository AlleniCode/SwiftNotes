//
//  Swift28Some.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/29.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift28Some: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 不透明类型（opaque type）
        
        // - 以下代码是可以编译通过的，但是 makeTrapezoid 的返回类型又臭又长，被暴露了出去。
        func makeTapezoid() -> JoinedShape<Triangle, JoinedShape<Square, FilppedShape<Triangle>>> {
            let t = Triangle(size: 3)
            let s = Square(size: 3)
            let f = FilppedShape(shape: t)
            return JoinedShape(top: t, bottom: JoinedShape(top: s, bottom: f))
        }
        
        let tapezoid = makeTapezoid()
        print(tapezoid.draw())
        print("----------")
        
        // - 使用 some 改进
        func makeTapezoid1() -> some Shape {
            let t = Triangle(size: 3)
            let s = Square(size: 3)
            let f = FilppedShape(shape: t)
            return JoinedShape(top: t, bottom: JoinedShape(top: s, bottom: f))
        }
        
        let tapezoid1 = makeTapezoid1()
        print(tapezoid1.draw())
        print("----------")

        // - 把 some 去掉也可以运行
        func makeTapezoid2() -> Shape {
            let t = Triangle(size: 3)
            let s = Square(size: 3)
            let f = FilppedShape(shape: t)
            return JoinedShape(top: t, bottom: JoinedShape(top: s, bottom: f))
        }
        
        let tapezoid2 = makeTapezoid2()
        print(tapezoid2.draw())
        print("----------")
        
        // - 加上参数
        func makeTapezoid3(size: Int) -> Shape {
            if size == 3 {
                return Square(size: 3)
            }
            let t = Triangle(size: size)
            let s = Square(size: size)
            let f = FilppedShape(shape: t)
            return JoinedShape(top: t, bottom: JoinedShape(top: s, bottom: f))
        }
        
        let tapezoid3 = makeTapezoid3(size: 4)
        print(tapezoid3.draw())
        print("----------")
        
        // - 加上参数后把 some 也加上
        // - 运行出错：Function declares an opaque return type, but the return statements in its body do not have matching underlying types。
        // - 因为当 size == 3 的时候，返回了一个 Square 确定类型。
        /*
            func makeTapezoid4(size: Int) -> some Shape {
                if size == 3 {
                    return Square(size: 3)
                }
                let t = Triangle(size: size)
                let s = Square(size: size)
                let f = FilppedShape(shape: t)
                return JoinedShape(top: t, bottom: JoinedShape(top: s, bottom: f))
            }
            
            let tapezoid4 = makeTapezoid4(size: 4)
            print(tapezoid4.draw())
            print("----------")
        */
        
        // - 把 if 判断去掉后正常运行
        func makeTapezoid4(size: Int) -> some Shape {
            /*
            if size == 3 {
                return Square(size: 3)
            }
            */
            let t = Triangle(size: size)
            let s = Square(size: size)
            let f = FilppedShape(shape: t)
            return JoinedShape(top: t, bottom: JoinedShape(top: s, bottom: f))
        }
        
        let tapezoid4 = makeTapezoid4(size: 5)
        print(tapezoid4.draw())
        print("----------")
        
        // - 不能将其 Container 用作函数的返回类型，因为该协议具有关联类型。也不能将它用作返回类型的泛型约束，因为函数体外没有足够的信息来推断泛型类型需要什么。
        // - 以下方法运行出错：Protocol 'ContainerN' can only be used as a generic constraint because it has Self or associated type requirements。
        /*
            func makeProtocolContainer<T>(item: T) -> ContainerN {
                return [item]
            }
        */
        
        // - 把返回结果改成 some ContainerN
        func makeProtocolContainer<T>(item: T) -> some ContainerN {
            return [item]
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


protocol Shape {
    func draw() -> String
}

struct Triangle: Shape {
    var size: Int
    
    func draw() -> String {
        var result = [String]()
        for length in 1...size {
            result.append(String(repeating: "*", count: length))
        }
        return result.joined(separator: "\n")
    }
}

struct Square: Shape {
    var size: Int
    
    func draw() -> String {
        var result = [String]()
        for _ in 0..<size {
            result.append(String(repeating: "*", count: size))
        }
        return result.joined(separator: "\n")
    }
}

struct FilppedShape<T: Shape>: Shape {
    var shape: T
    
    func draw() -> String {
        let result = shape.draw().split(separator: "\n")
        return result.reversed().joined(separator: "\n")
    }
}

struct JoinedShape<T: Shape, U: Shape>: Shape {
    var top: T
    var bottom: U
    
    func draw() -> String {
        return top.draw() + "\n" + bottom.draw()
    }
}


protocol ContainerN {
    associatedtype Item
    var count: Int { get }
    subscript(index: Int) -> Item { get }
}

extension Array: ContainerN {}
