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
    static let META   = 2
    static let JAVA   = 3
    static let CSHARP = 4
    
    
    var isSelectConrifm = true
    
    var mViewControllers : [String : UIViewController] = [:]
    
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
        viewControllers = [
            generateNavController(emptyVc, "Kotil", UIImage(systemName: "circle.square")),
            generateNavController(emptyVc, "Swift", UIImage(systemName: "flag.2.crossed.circle.fill")),
            generateNavController(emptyVc, "Meta", UIImage(systemName: "person.fill")),
            generateNavController(emptyVc, "Java", UIImage(systemName: "train.side.front.car")),
            generateNavController(emptyVc, "CSharp", UIImage(systemName: "lock.display")),
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
            
            self.viewControllers?[MainTapBarViewController.SWIFT] = createViewController(MainTapBarViewController.SWIFT)
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
     ViewController 생성
     */
    func createViewController(_ index : Int) -> UIViewController {
        switch index {
        case MainTapBarViewController.KOTLIN:
            if mViewControllers["KOTLIN"] == nil {
                let vc = KotlinViewController()
                vc.view.backgroundColor = .white
                vc.tabBarItem = UITabBarItem(title: "Kotlin", image: UIImage(systemName: "circle.square"), selectedImage: nil)
                mViewControllers["KOTLIN"] = UINavigationController(rootViewController: vc)
            }
            return mViewControllers["KOTLIN"] ?? UIViewController()
        case MainTapBarViewController.SWIFT:
            if mViewControllers["SWIFT"] == nil {
                let vc = SwiftViewController()
                vc.view.backgroundColor = .white
                vc.tabBarItem = UITabBarItem(title: "Swift", image: UIImage(systemName: "flag.2.crossed.circle.fill"), selectedImage: nil)
                mViewControllers["SWIFT"] = UINavigationController(rootViewController: vc)
            }
            return mViewControllers["SWIFT"] ?? UIViewController()
        case MainTapBarViewController.CSHARP:
            if mViewControllers["CSHARP"] == nil {
                let vc = CSharpViewController()
                vc.view.backgroundColor = .white
                vc.tabBarItem = UITabBarItem(title: "CSharp", image: UIImage(systemName: "lock.display"), selectedImage: nil)
                mViewControllers["CSHARP"] = UINavigationController(rootViewController: vc)
            }
            return mViewControllers["CSHARP"] ?? UIViewController()
        default:
            return UIViewController()
        }
    }
    
    
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
            let metaVc = MetaViewController()
            metaVc.view.backgroundColor = .white
            
            let navVc = UINavigationController(rootViewController: metaVc)
            navVc.modalTransitionStyle = .coverVertical
            navVc.modalPresentationStyle = .fullScreen
           
            self.present(navVc, animated: true)
             
        case MainTapBarViewController.JAVA:
            let javaVc = JavaViewController()
            javaVc.view.backgroundColor = .white
            
            self.presentPanModal(javaVc)
        default:
            break
        }
    }
    
    
    
    /*
     Button Tap 관련 함수
     */
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        /*
         META와 JAVA는 화면 전환을 막고 나머지는 화면전환을 해준다.
         또한 META와 JAVA에서는 화면 전환을 막기 전 전환 처리를 해줬다.
         */
        let index = tabBarController.viewControllers?.firstIndex(of: viewController)
        switch index {
        case MainTapBarViewController.META, MainTapBarViewController.JAVA:
            self.translatePage(index ?? 0)
            return false
        default:
            return true
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        /*
         Kotlin, SWIFT, CSHARP는 버튼탭을 할때 emptyViewController에서 각각의 ViewController로 바꿔준다
         즉 Create함수에서 보다 싶이 특정 버튼을 탭했을때 생성한다.
         */
        if selectedIndex == MainTapBarViewController.KOTLIN || selectedIndex == MainTapBarViewController.SWIFT || selectedIndex == MainTapBarViewController.CSHARP {
            viewControllers?[selectedIndex] = createViewController(selectedIndex)
        }
    }
}
