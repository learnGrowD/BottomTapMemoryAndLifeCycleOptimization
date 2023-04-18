//
//  JavaViewController.swift
//  BottomTapMemoryAndLifeCycleOptimization
//
//  Created by 도학태 on 2023/04/18.
//

import Foundation
import UIKit
import PanModal



class JavaViewController : BaseViewController {
    
    let label = UILabel().then {
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.text = "JAVA"
    }
    
    
    override func layout() {
        super.layout()
        
        [
            label
        ].forEach {
            view.addSubview($0)
        }
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
        }
    }
}


extension JavaViewController : PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var dragIndicatorBackgroundColor: UIColor {
        return .clear
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(412)
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(412)
    }
    
}

