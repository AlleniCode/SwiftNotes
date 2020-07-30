//
//  Swift30Frameworks.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/29.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift30Frameworks: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// Swift 第三方库
        
        
        /// Alamofire 网络请求
        
        // - https://github.com/Alamofire/Alamofire
        // - Alamofire 是在苹果 URL Loading System 基础上封装的网络库，简单易用并且可扩展。
        
        
        /// SwiftyJSON JSON 解析
        
        // - https://github.com/SwiftyJSON/SwiftyJSON
        // - SwiftyJSON makes it easy to deal with JSON data in Swift.
        
        
        /// Dollar 标准库扩展
        
        // - https://github.com/ankurp/Dollar
        // - https://www.dollarswift.org
        // - Dollar is a Swift library that provides useful functional programming helper methods without extending any built in objects. It is similar to Lo-Dash or Underscore.js in Javascript.
        
        
        /// SnapKit 自动布局
        
        // - https://github.com/SnapKit/SnapKit
        // - SnapKit is a DSL to make Auto Layout easy on both iOS and OS X.
        
        
        /// Kingfisher 图片加载和缓存
        
        // - https://github.com/onevcat/Kingfisher
        // - Kingfisher is a powerful, pure-Swift library for downloading and caching images from the web. It provides you a chance to use a pure-Swift way to work with remote images in your next app.
        
        
        /// R.Swift 优雅地使用资源
        
        // - https://github.com/mac-cain13/R.swift
        // - Get strong typed, autocompleted resources like images, fonts and segues in Swift projects.
        
        // - 在当前项目的 targets 中选择 Build phrase,点击+号选择添加 New Run Script Phase。
        // - 将 Run Script 移动至 Compile sources 之上, Check Pods Manifest.lock 之下。在 Run Script 中添加:"$PODS_ROOT/R.swift/rswift" “$SRCROOT"。
        // - 编译你的项目,在 Finder 中你会看到 R.generated.swift 在工程中,将该文件拖动至项目中,切记 千万不要勾选 Copy items if needed。
        // - 每当项目build时，R.swift开始运行。
        // - 这个文件根据项目里的资源文件自动在 R.generated.swift 文件中按照类型生成结构体。
        // - 强类型,无需类型判断和转换,自动返回对应类型。
        // - 支持多种资源类型。
        // - 自动完成,无需猜测图像名称,避免资源名称拼写错误。
        
        
        /// MonkeyKing 社交分享
        
        // - https://github.com/nixzhu/MonkeyKing
        // - MonkeyKing helps you post messages to Chinese Social Networks, without their buggy SDKs.
        
        
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
