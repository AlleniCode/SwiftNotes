//
//  Swift32App.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/29.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift32App: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 搭建 Swift 项目
        
        
        /// 包管理的三种方式
        
        // - CocoaPods
        // - Carthage
        // - Swift Package Manager
        
        
        /// CocoaPods
        
        // - CocoaPods 是非常好用的第三方依赖管理工具。它于2011年发布，经过这几年的发展，已经非常完善。
        // - CocoaPods 支持项目中采用 Objective-C 或 swift 语言。
        // - CocoaPods 会将第三方库的源代码编译为静态库 .a 文件或者动态框架 .framework 文件的形式，并将它们添加到项目中，建立依赖关系。
        
        
        /// Carthage
        
        // - Carthage 是一个轻量级的项目依赖管理工具。Carthage 主张“去中心化”和“非侵入性”。
        // - CocoaPods 搭建了一个中心库，第三方库被收入到该中心库，所以没有收录的第三方库是不能使用 CocoaPods 管理的，这就是所谓的“中心化”思想。
        // - 而 Carthage 没有这样的中心库，第三方库基本上都是从 GitHub 或者私有 git 库中下载的，这就是“去中心化”。
        // - 另外， CocoaPods 下载第三方库后，会将其编译成静态链接库或者动态框架文件，这种做法会修改 Xcode 项目属性配置依赖关系，这就是所谓的“侵入性”。
        // - 而 Carthage 下载成功后，会将第三方库编译为动态框架，由开发人员自己配置依赖关系，Carthage 不会修改 Xcode 项目属性，这就是所谓的“非侵入性”。
        
        
        /// Carthage 使用
        
        // 使用 brew 安装 carthage:
        // - （1）$brew update
        // - （2）$brew install carthage
        
        // 创建 cartfile 文件:
        // - $touch cartfile
        
        // 修改 cartfile 文件:
        // - github "Alamofire/Alamofire"
        // - github "onevcat/Kingfisher"
        // - github "nixzhu/MonkeyKing"
        // - github "SwiftyJSON/SwiftyJSON"
        // - github "SnapKit/SnapKit"
        
        // cartfile - Dependency origin:
        // - Carthage支持两种类型的源，一个是 github ，另一个是 git:
        // - （1）github 表示依赖源，告诉 Carthage 去哪里下载文件。依赖源之后跟上要下载的库，格式为 Username/ProjectName。
        // - （2）Git 关键字后面跟的是资料库的地址，可以是远程的 URL 地址，使用 git://, http://, ssh://， 或者是本地资料库地址。
        
        // cartfile - Dependency Version:
        // - 告诉 Carthage 使用哪个版本，这是可选的，不写默认使用最新版本:
        // - （1）== 1.0 表示使用1.0版本。
        // - （2）>= 1.0 表示使用1.0或更高的版本。
        // - （3）~> 1.0 表示使用版本1.0以上但是低于2.0的最新版本，如1.2，1.6。
        // - （4）branch名称 / tag名称 / commit名称，意思是使用特定的分支/标签/提交，比如可以是分支名 master，也可以是提交5c8a74a。
        
        // carthage update 安装所有平台的库:
        // - $carthage update
        
        // carthage update --platform iOS 安装 iOS 平台的库:
        // - carthage update --platform iOS
        
        // Cartfile.resolved 文件和 Carthage 目录:
        // - Cartfile.resolved 文件:
        // - （1）这个文件是生成后的依赖关系以及各个库的版本号，不能修改。
        // - （2）Cartfile.resolved 文件确保提交的项目可以使用完全相同的配置与方式运行启用。 跟踪项目当前所用的依赖版本号，保持多端开发一致，出于这个原因，建议提交这个文件到版本控制中。
        // - Carthage 目录:
        // - （1）Checkouts 保存从git拉取的依赖库源文件。
        // - （2）Build 包含编译后的文件，包含 Mac 与 iOS 对应的 .framework。
        
        // 项目配置
        // - 项目 Target -> Build Setting -> Search Paths -> Framework Search Paths 添加 $(PROJECT_DIR)/Carthage/ Build/iOS。
        // - 项目Target -> Build Phases -> '+' -> New Run Script Phase:
        // - （1）添加脚本 /usr/local/bin/Carthage copy-frameworks。
        // - （2）添加"Input Files" $(SRCROOT)/Carthage/Build/iOS/Alamofire.framework 等等。
        
        
        /// Swift Package Manager
        
        // - Swift Package Manager 是苹果推出的用于管理分发 swift 代码的工具，可以用于创建使用 swift 的库和可执行程序。
        // - 能够通过命令快速创建 library 或者可执行的 swift 程序，能够跨平台使用，使开发出来的项目能够在不同平台上运行。
        // - Xcode 集成：File -> Swift Packages -> Add Package Dependency。
        
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
