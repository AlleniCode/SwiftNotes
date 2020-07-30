//
//  Swift24Multi-thread.swift
//  SwiftNotes
//
//  Created by 张玉涛 on 2020/7/28.
//  Copyright © 2020 SwiftNotes. All rights reserved.
//

import UIKit

class Swift24Multi_thread: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 写在前面
        
        // - 为什么几乎所有的GUI框架都是单线程的?
        // - https://community.oracle.com/blogs/kgh/2004/10/19/multithreaded-toolkits-failed-dream
        
        
        /// 多线程可以做什么
        
        // - 网络请求
        // - IO
        // - 计算
        // - 数据模型转化
        // - ...
        
        
        /// 多线程编程的方式
        
        // - Thread
        // - Cocoa Operation (Operation 和 OperationQueue)
        // - Grand Central Dispath (GCD)
        
        
        /// Thread
        
        // - Tread 在三种多线程技术中是最轻量级的，但需要自己管理线程的生命周期和线程同步。线程同步对数据的加锁会有一定的系统开销。
        
        // - 快捷方式创建:
        // - （1）detachNewThread(_ block: @escaping () -> Void)
        // - （2）detachNewThreadSelector(_ selector: Selector, toTarget target: Any, with argument: Any?)
        
        for i in 0...10 {
            Thread.detachNewThread {
                print(i)
            }
        }
        
        // - 初始化器:
        // - （1）Thread(target:, selector:, object:)
        
        class ObjectForThread {
            func threadTest() {
                let thread = Thread(target: self, selector: #selector(threadWorker), object: nil)
                thread.start()
                print("threadTest")
            }
            
            @objc func threadWorker() {
                print("threadWorker")
            }
        }
        let obj = ObjectForThread()
        obj.threadTest()
        
        
        /// Cocoa Operation 概述
        
        // - 面向对象
        // - Operation + OperationQueue
        // - 取消，依赖，任务优先级，复杂逻辑，保存业务状态，子类化
        
        // - Operation
        // - BlockOperation
        // - isReady
        // - isExecuting
        // - isFinished
        // - isCancelled
        
        // - sync:
        // - main()
        
        // - async:
        // - start()
        // - isAsynchronous
        // - isExecuting
        // - isFinished
        
        // - OperationQueue
        // - OperationQueue 队列里可以加入很多个 Operation，可以把 OperationQueue 看做一个线程池，可往线程池中添加操作 (Operation)到队列中。
        // - 底层使用GCD。
        // - maxConcurrentOperationCount 可以设置最大并发数。
        // - defaultMaxConcurrentOperationCount 根据当前系统条件动态确定的最大并发数。
        // - 可以取消所有 Operation，但是当前正在执行的不会取消。
        // - 所有 Operation 执行完毕后退出销毁。
        
        // BlockOperation
        class ObjectForOperation {
            func threadTest() {
                let operation = BlockOperation { [weak self] in
                    self?.threadWorker()
                }
                let queue = OperationQueue()
                queue.addOperation(operation)
                print("threadTest")
            }
            
            @objc func threadWorker() {
                print("threadWorker")
            }
        }
        let obj1 = ObjectForOperation()
        obj1.threadTest()
        
        // 继承 Operation
        class MyOperation: Operation {
            override func main() {
                sleep(1)
                print("MyOperation")
            }
        }
        class ObjectForOperation1 {
            func threadTest() {
                let operation = MyOperation()
                operation.completionBlock = { () -> Void in
                    print("operation.completionBlock")
                }
                let queue = OperationQueue()
                queue.addOperation(operation)
                print("threadTest")
            }
            
            @objc func threadWorker() {
                print("threadWorker")
            }
        }
        let obj2 = ObjectForOperation1()
        obj2.threadTest()
        print("After invoke test")
        
        
        /// GCD
        
        // 主要特性：
        // - 任务 + 队列
        // - 易用
        // - 效率
        // - 性能
        
        // 源码：
        // - https://opensource.apple.com/tarballs/libdispatch/
        
        // 功能：
        // - 创建管理 Queue
        // - 提交 Job
        // - Dispatch Group
        // - 管理 Dispatch Object
        // - 信号量 Semaphore
        // - 队列屏障 Barrier
        // - Dispatch Source
        // - Queue Context 数据
        // - Dispatch I/O Channel
        // - Dispatch Data 对象
        
        // GCD-队列:
        // - 主队列: 任务在主线程执行
        // - 并行队列: 任务会以先进先出的顺序入列和出列，但是因为多个任务可以并行执行，所以完成顺序是不一定的。
        // - 串行队列: 任务会以先进先出的顺序入列和出列，但是同一时刻只会执行一个任务。
        // - 最终的目标队列都是主队列和全局队列。
        // - 如果把一个并行队列的目标队列设置为一个串行队列，那么并行队列将不再并行。
        // - 如果多个队列的目标队列都设置为同一个串行队列，那么这多个队列连同目标队列里的任务都将串行执行。
        // - 如果设置目标队列形成环了，结果是不可预期的。
        // - 如果在一个队列正在执行任务的时候更换目标队列，结果也是不可预期的。
        
        // GCD-队列API:
        // - Dispatch.main
        // - Dispatch.global
        // - DispatchQueue(label:, qos:, attributes:, autoreleaseFrequency:, target:)
        // - queue.label
        // - setTarget(queue: DispatchQueue?)
        
        
        /// GCD 基本操作
        
        // - sync
        // - async
        // - asyncAfter
        
        // GCD-串行 vs 并行:
        // - 串⾏和并⾏描述的是任务之间如何运⾏。
        // - 串⾏任务每一次仅执⾏⼀个。
        // - 并⾏任务可以多个同时执⾏。
        
        // GCD-sync:
        // - 提交任务到当前队列里，并且直到任务执行完成，当前队列才会返回。
        // - 调度一个任务去立即执行，但是不用等任务执行完当前队列就会返回。
        
        let queue = DispatchQueue(label: "MyQueue", qos: DispatchQoS.default, attributes: DispatchQueue.Attributes.concurrent, autoreleaseFrequency: DispatchQueue.AutoreleaseFrequency.inherit, target: nil)
        queue.sync {
            print("in queue sync")
        }
        print("after invoke queue method")
        
        queue.async {
            sleep(1)
            print("in queue async")
        }
        
        // GCD-asyncAfter:
        // - 调度一个任务去多久之后执行，但是不用等任务执行完当前队列就会返回
        
        queue.asyncAfter(deadline: .now() + 1) {
            print("in queue asyncAfter")
        }
        
        
        /// GCD 高级特性
        
        // - DispatchGroup
        // - DispatchSource
        
        // DispatchGroup-wait:
        let group = DispatchGroup()
        let requestQueue = DispatchQueue(label: "request_queue")
        
        group.enter()
        requestQueue.async {
            Thread.sleep(forTimeInterval: 1)
            print("接口 A 请求数据完成")
            group.leave()
        }
        
        group.enter()
        requestQueue.async {
            Thread.sleep(forTimeInterval: 1)
            print("接口 B 请求数据完成")
            group.leave()
        }
        
        print("我是最开始执行的，异步操作里的打印后执行")
        
        group.wait()
        print("接口 A 和接口 B 的数据请求都已完毕，开始合并两个接口的数据！")
        
        // DispatchGroup-notify:
        group.notify(queue: requestQueue) {
            print("notify - 接口 A 和接口 B 的数据请求都已完毕，开始合并两个接口的数据！")
        }
        print("验证不堵塞")
        
        // DispatchSource:
        // - 简单来说，dispatch source是一个监视某些类型事件的对象。当这些事件发生时，它自动将一个 task 放入一个dispatch queue的执行例程中。
        
        // DispatchSource-Timer:
        var seconds = 10
        let timer: DispatchSourceTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        timer.schedule(deadline: .now(), repeating: 1.0)
        timer.setEventHandler {
            seconds -= 1
            if seconds < 0 {
                timer.cancel()
            } else {
                print(seconds)
            }
        }
        timer.resume()
        
        
        /// 多线程典型场景
        
        // - 一个页面有三个网络请求，需要在三个网络请求都返回的时候刷新界面。
        // - 实现一个线程安全的Array的读和写。
        // - 编写一个多线程下载器，可以执行多个下载任务，每个任务可以保存当下下载字节数，总字节数，可以设置回调得到当前下载进度。
        // - 需要在主线程等待一个异步任务返回，才能继续执行下面的逻辑，但是又不希望堵塞用户事件。
        
        // 安全的 Array:
        var array = Array(0...10000)
        
        func getLastItem() -> Int? {
            var temp: Int? = nil
            if array.count > 0 {
                temp = array[array.count - 1]
            }
            return temp
        }
        
        func removeLastItem() {
            array.removeLast()
        }
        
        // 非线程安全的调用
        let arrayQueue1 = DispatchQueue(label: "array_queue_1")
        let arrayQueue2 = DispatchQueue(label: "array_queue_2")
        arrayQueue1.async {
            for _ in 0...10000 {
                removeLastItem()
            }
        }
        arrayQueue2.async {
            for _ in 0...10000 {
                if let item = getLastItem() {
                    print(item)
                }
            }
        }
        // 运行出错：Fatal error: Index out of range
        
        // 加安全锁
        let lock = NSLock()
        
        func getLastItem1() -> Int? {
            lock.lock()
            var temp: Int? = nil
            if array.count > 0 {
                temp = array[array.count - 1]
            }
            lock.unlock()
            return temp
        }
        
        func removeLastItem1() {
            lock.lock()
            array.removeLast()
            lock.unlock()
        }
        
        arrayQueue1.async {
            for _ in 0...10000 {
                removeLastItem1()
            }
        }
        arrayQueue2.async {
            for _ in 0...10000 {
                if let item = getLastItem1() {
                    print(item)
                }
            }
        }
        
        // - 如果在一段时间内只有读操作，我们是不需要加锁的，而上述 NSLock 的方式则仍然强制每一次读操作都加锁等待，对性能造成不小的影响，尤其是我们对数组的读操作远远多于写操作的时候，这个性能的影响就会相当可观。那么怎么解决这一问题呢?
        // - 一个队列加两个方法:
        // - （1）首先是并行队列，既然我们要保持多线程环境并行操作的优势，那我们肯定要选择并行队列。
        // - （2）二是 sync 方法，这个方法来封装我们的读操作，读操作的发起方需要在调用读方法的时候能直接拿到返回值，而不是在异步回调里面获取。
        // - （3）三是 async 方法使用 barrier flag，这个方法来封装我们的写操作，这个方法起到一个栅栏的作用,它等待所有位于 barrier async 函数之前的操作执行完毕后执行，并且在 barrier async 函数执行之后，barrier async 函数之后的操作才会得到执行。
        
        let arrayQueue3 = DispatchQueue(label: "array_queue_3")
        func getLastItem2() -> Int? {
            var temp: Int? = nil
            arrayQueue3.sync {
                if array.count > 0 {
                    temp = array[array.count - 1]
                }
            }
            return temp
        }
        
        func removeLastItem2() {
            let workItem = DispatchWorkItem(qos: DispatchQoS.default, flags: DispatchWorkItemFlags.barrier) {
                array.removeLast()
            }
            arrayQueue3.async(execute: workItem)
        }
        
        arrayQueue1.async {
            for _ in 0...10000 {
                removeLastItem2()
            }
        }
        arrayQueue2.async {
            for _ in 0...10000 {
                if let item = getLastItem2() {
                    print(item)
                }
            }
        }
        
        
        /// 其他常见的多线程编程模式
        
        // - Promise
        // - Pipeline
        // - Master-Slave
        // - Serial Thread Confinement
        
        // Promise:
        // - 在需要多个操作的时候，会导致多个回调函数嵌套，导致代码不够直观，就是常说的 Callback Hell。
        // - 如果几个异步操作之间并没有前后顺序之分(例如不需要前一个请求的结果作为后一个请求的参数)时，同样需要等待上一个操作完成再实行下一个操作。
        // - 丧失了 return 特性。
        // - 所谓 Promise，就是一个对象，用来传递异步操作的消息。它代表了某个未来才会知道结果的 事件(通常是一个异步操作)，并且这个事件提供统一的 API，可供进一步处理。
        // - 对象的状态不受外界影响。Promise 对象代表一个异步操作，有三种状态:Pending(进行中，又称 Incomplete)、Resolved(已完成，又称 Fulfilled)和 Rejected(已失败)。只有异步操作的结果，可以决定当前是哪一种状态，任何其他操作都无法改变这个状态。这也是 Promise 这个名字的由来，它的英语意思就是「承诺」，表示其他手段无法改变。
        // - 一旦状态改变，就不会再变，任何时候都可以得到这个结果。Promise对象的状态改变，只有两种可能:从 Pending 变为 Resolved 和从 Pending 变为 Rejected。只要这两种情况发生，状态就凝固了，不会再变了，会一直保持这个结果。就算改变已经发生了，你再对 Promise 对象添加回调函数，也会立即得到这个结果。这与事件(Event)完全不同，事件的特点是，如果你错过了它，再去监听，是得不到结果的。
        
        // Pipeline:
        // - 将一个任务分解为若干个阶段(Stage)，前阶段的输出为下阶段的输入，各个阶段由不同的工作者线程负责执行。
        // - 各个任务的各个阶段是并行(Parallel)处理的。
        // - 具体任务的处理是串行的，即完成一个任务要依次执行各个阶段，但从整体任务上看，不同任务的各个阶段的执行是并行的。
        
        // Master/Slave:
        // -
        
        // Serial Thread Confinement:
        // - 如果并发任务的执行涉及某个非线程安全对象，而很多时候我们又不希望因此而引入锁。
        // - 通过将多个并发的任务存入队列实现任务的串行化，并为这些串行化任务创建唯一的工作者线程进行处理。
        
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
