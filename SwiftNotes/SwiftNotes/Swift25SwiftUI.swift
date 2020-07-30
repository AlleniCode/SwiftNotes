//
//  Swift25SwiftUI.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/29.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift25SwiftUI: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// SwiftUI
        
        // - Better apps. Less code.
        
        // - SwiftUI 是一种基于 Swift 的强大能力，简单创新的构建用户界面的方法，并且可以运行在苹果所有的平台上。
        // - SwiftUI 采用声明式语法，因此你可以简单声明你的用户界面。
        // - Xcode11 提供了强大的设计工具，可以通过简单的拖拽用 SwiftUI 生成用户界面。
        // - 只需要描述一次的布局-为你的视图声明任何状态的内容和布局，一旦状态发生改变， SwiftUI 会自动更新视图的渲染。
        // - 构建可复用的组件-将小型、独立视图组合到更大，更复杂的界面中。在任何为 Apple 平台所设计的应用之间，共享您的自定义视图。
        // - 精简动画-创建平滑的动画就像调用单个方法一样简单。 SwiftUI 会在必要时自动计算并过渡动画。
        // - 在 SwiftUI 中，你可以将任意的改变过程封装进一个 withAnimation 块中。默认，SwiftUI 会 对这种改变采用 fade in/out 的方式进行动画。
        
        
        /// @propertyWrapper
        
        // - 通过 property Wrapper 机制，对一些类似的属性的实现代码做同一封装。
        // - 通过 @propertyWrapper 可以移除掉一些重复或者类似的代码。
        // - 通过@State SwiftUI 实现了值的绑定、动态查找和 View 的自动重新绘制。
        // - 查看源码，了解@Binding, @ObservedObject, @EnvironmentObject 等装饰器的作用。
        
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
