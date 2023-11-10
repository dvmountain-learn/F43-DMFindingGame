//
//  LTConstants.swift
//  DMFindingGame
//
//  Created by SENGHORT KHEANG on 11/10/23.
//

import UIKit
import Foundation

func anyTransition(_ view: AnyObject, _ duration: CFTimeInterval) {
    let animation = CATransition()
    animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    animation.type = CATransitionType.fade
    animation.duration = duration
    view.layer.add(animation, forKey: CATransitionType.fade.rawValue)
}

func formatted(_ value: Int) -> String {
    return String(format: "%d", value)
}
