//
//  BaseViewController.swift
//  BottomTapMemoryAndLifeCycleOptimization
//
//  Created by 도학태 on 2023/04/18.
//

import Foundation
import UIKit



protocol BaseViewControllerProtocol {
    func attrubute()
    func layout()
}

extension BaseViewControllerProtocol {
    var className : String {
        return String(describing: type(of: self))
    }
    
    
    func mInit() {
        print("\(className) : init")
        self.attrubute()
    }
    
    func mViewDidLoad() {
        print("\(className) : viewDidLoad")
        self.layout()
    }
    
    func mViewWillApear(_ animated: Bool) {
        print("\(className) : viewWillApear")
    }
    
    func mViewDidApear(_ animated: Bool) {
        print("\(className) : viewDidApear")
    }
    
    
    func mViewWillDisAppear(_ animated: Bool) {
        print("\(className) : viewWillDisAppear")
    }
    
    
    func mViewDidDisAppear(_ animated: Bool) {
        print("\(className) : viewDidDisAppear")
    }
    
    
    func mDeinit() {
        print("\(className) : deinit")
    }
}


class BaseViewController : UIViewController, BaseViewControllerProtocol {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.mInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mViewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mViewWillApear(animated)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mViewDidApear(animated)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.mViewWillDisAppear(animated)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.mViewDidDisAppear(animated)
    }
    
    
    deinit {
        self.mDeinit()
    }
    
    func attrubute() {}
    
    func layout() {}
    
}
