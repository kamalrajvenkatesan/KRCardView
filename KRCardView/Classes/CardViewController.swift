//
//  CardViewController.swift
//  CardViewAnimator
//
//  Created by kamalraj venkatesan on 31/10/18.
//  Copyright © 2018 Kamalraj. All rights reserved.
//

import UIKit

open class CardViewController: UIViewController {
    
    @IBOutlet weak var handleArea: UIView!
    
    var visualEffectView = UIVisualEffectView()
    
    var cardVisible: Bool = false
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
}
