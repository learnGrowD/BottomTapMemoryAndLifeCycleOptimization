//
//  MainViewController.swift
//  BottomTapMemoryAndLifeCycleOptimization
//
//  Created by 도학태 on 2023/04/18.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import PanModal


class MainTapBarViewController : UITabBarController {
    static let KOTLIN = 0
    static let SWIFT  = 1
    static let JAVA   = 2
    static let META   = 3
    static let CSHARP = 4
    
    
    var isSelectConrifm = true
    var translatePageLastIndex = -1
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        launchScreen()
    }
    
    func bind() {
        
        let emptyVc = UIViewController()
        
        let kotlinVc = KotlinViewController()
        let swiftVc = SwiftViewController()
        let cSharpVc = CSharpViewController()
        viewControllers = [
            generateNavController(kotlinVc, "Kotil", UIImage(systemName: "circle.square")),
            generateNavController(swiftVc, "Swift", UIImage(systemName: "flag.2.crossed.circle.fill")),
            generateNavController(emptyVc, "Meta", UIImage(systemName: "person.fill")),
            generateNavController(emptyVc, "Java", UIImage(systemName: "train.side.front.car")),
            generateNavController(cSharpVc, "CSharp", UIImage(systemName: "lock.display")),
        ]
    }
    
    /*
     초기 화면을 정한다.
     UITabbarViewController가 viewDidLoad에서 초기화가 완료된 이후에
     lanchScreen 호출 -> viewWillAppear에서 호출
     */
    
    func launchScreen() {
        if isSelectConrifm {
            /*
             초기 화면 SWIFT 설정
             */
            self.selectedIndex = MainTapBarViewController.SWIFT
            isSelectConrifm.toggle()
        }
        
    }
    
    /*
     TabBar에 ViewController 등록하는 함수
     */
    func generateNavController(
        _ vc : UIViewController,
        _ title : String,
        _ image : UIImage?
    ) -> UINavigationController {
        vc.view.backgroundColor = .white
        let navController = UINavigationController(rootViewController: vc)
        let tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
        navController.tabBarItem = tabBarItem
        
        return navController
    }
    
    func attribute() {
        self.delegate = self
    }
}

extension MainTapBarViewController : UITabBarControllerDelegate {
    
    /*
     Page 전환 로직이 담겨 있는 함수
     Bottom Tap 할때 이 함수가 호출
     */
    func translatePage(_ selectIndex : Int) {
        
        /*
         정상적으로 페이지 전환해야 되는 Page에는 LastIndex를 넣어준다
         Page전환이 되면 안되는 페이지는 LastIndex를 넣어주지 않고 LastIndex에 있는 값으로 페이지 유지하고
         새로운 페이지를 띄운다.
         */
        switch selectIndex {
        case MainTapBarViewController.META:
            self.selectedIndex = translatePageLastIndex
            
            let metaVc = MetaViewController()
            metaVc.view.backgroundColor = .white
            
            let navVc = UINavigationController(rootViewController: metaVc)
            navVc.modalTransitionStyle = .coverVertical
            navVc.modalPresentationStyle = .fullScreen
           
            self.present(navVc, animated: true)
             
        case MainTapBarViewController.JAVA:
            self.selectedIndex = translatePageLastIndex

            let javaVc = JavaViewController()
            javaVc.view.backgroundColor = .white
            
            self.presentPanModal(javaVc)
        default:
            self.translatePageLastIndex = selectIndex
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        translatePage(self.selectedIndex)
        
    }
}
