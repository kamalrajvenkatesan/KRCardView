//
//  ViewController.swift
//  KRCardView
//
//  Created by kamalraj.venkatesan on 11/02/2018.
//  Copyright (c) 2018 kamalraj.venkatesan. All rights reserved.
//

import UIKit
import KRCardView

class ViewController: UIViewController, KRCardView {

  var cardViewController: CardViewController!
  var cardHandleAreaHeight: CGFloat = 100 // Height of card view when in collapsed state
  var cardHeight: CGFloat {
    return (self.view.bounds.height - 100)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    cardViewController = self.storyboard?.instantiateViewController(withIdentifier: "BottomViewController") as! BottomViewController

    self.addKRCardView() // This method will render card view in this view controller.

  }
  
}

