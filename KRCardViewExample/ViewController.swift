//
//  ViewController.swift
//  KRCardViewExample
//
//  Created by kamalraj venkatesan on 05/03/21.
//

import UIKit
import KRCardView

class ViewController: UIViewController, KRCardView {

    var cardViewController: CardViewController!
    var cardHandleAreaHeight: CGFloat = 100
    var cardHeight: CGFloat = 300
    var containerBlurEffect: UIBlurEffect?
    var containerBackgroundColour: UIColor? = UIColor.black.withAlphaComponent(0.3)

    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardViewController = self.storyboard?.instantiateViewController(withIdentifier: "BottomViewController") as! BottomViewController
        
        self.addKRCardView()
    }
    
    
    @IBAction func handleCardViewVisibility(_ sender: UIButton) {
        
        self.showKRCardView()
    }
    
}

