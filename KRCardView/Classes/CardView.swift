//
//  CardView.swift
//  KRCardView
//
//  Created by kamalraj venkatesan on 02/11/18.
//

import Foundation
import UIKit

public enum CardState: Int {
  case expanded, collapsed
}

public protocol BottomView {
  var cardViewController: CardViewController! { get set }

  var cardHandleAreaHeight: CGFloat { get }
  var cardHeight: CGFloat { get }

}

extension BottomView where Self: UIViewController {

  public func addView() {

    // Visual Effect View
    cardViewController.visualEffectView.frame = self.view.frame
    cardViewController.visualEffectView.isUserInteractionEnabled = false
    self.view.addSubview(cardViewController.visualEffectView)

    // Card view
    self.addChildViewController(cardViewController)
    self.view.addSubview(cardViewController.view)

    cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: self.cardHeight)

    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(recognizer:)))
    let panGestureRecongnizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(recognizer:)))

    cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
    cardViewController.handleArea.addGestureRecognizer(panGestureRecongnizer)

    cardViewController.view.clipsToBounds = true

  }

}


fileprivate extension UIViewController {


  var nextState: CardState {
    let bottomView = self as! BottomView
    return bottomView.cardViewController.cardVisible ? .collapsed : .expanded
  }

  @objc func handleTapGesture(recognizer: UITapGestureRecognizer) {

    guard recognizer.state == .ended else {
      return
    }

    self.animationTransitionIfNeeded(state: nextState, duration: 0.9)
  }

  @objc func handlePanGesture(recognizer: UIPanGestureRecognizer) {

    guard let bottomView = self as? BottomView else {
      return
    }

    switch recognizer.state {
    case .began:
      self.startInteractiveTransition(state: nextState, duration: 0.9)
    case .changed:

      let transition = recognizer.translation(in: bottomView.cardViewController.handleArea)
      var fractionComplete = transition.y / bottomView.cardHeight
      fractionComplete = bottomView.cardViewController.cardVisible ? fractionComplete : -fractionComplete

      self.updateInteractiveTransition(fractionCompleted: fractionComplete)
    case .ended:
      continueInteractiveTransition()
    default:
      break
    }

  }


  func animationTransitionIfNeeded(state: CardState, duration: TimeInterval) {

    guard var bottomView = self as? BottomView else {
      return
    }

    guard bottomView.cardViewController.runningAnimations.isEmpty else {
      return
    }

    // Frame
    var frameAnimator: UIViewPropertyAnimator {

      let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
        switch state {
        case .expanded:
          bottomView.cardViewController.view.frame.origin.y = self.view.bounds.height - bottomView.cardHeight
        case .collapsed:
          bottomView.cardViewController.view.frame.origin.y = self.view.bounds.height - bottomView.cardHandleAreaHeight
        }
      }

      animator.addCompletion { _ in
        bottomView.cardViewController.cardVisible = !bottomView.cardViewController.cardVisible
        bottomView.cardViewController.visualEffectView.isUserInteractionEnabled = !bottomView.cardViewController.cardVisible
        bottomView.cardViewController.runningAnimations.removeAll()
      }

      animator.startAnimation()

      return animator
    }

    // Corner Radius

    var cornerRadiusAnimator: UIViewPropertyAnimator {

      let animator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
        bottomView.cardViewController.view.layer.cornerRadius = (state == .expanded) ? 12 : 0
      }
      animator.startAnimation()

      return animator
    }

    // Visual Effect

    var blurAnimator: UIViewPropertyAnimator {

      let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
        bottomView.cardViewController.visualEffectView.effect = (state == .expanded) ? UIBlurEffect.init(style: .dark) : nil
      }

      animator.startAnimation()
      return animator
    }


    bottomView.cardViewController.runningAnimations.append(frameAnimator)
    bottomView.cardViewController.runningAnimations.append(cornerRadiusAnimator)
    bottomView.cardViewController.runningAnimations.append(blurAnimator)
  }


  func startInteractiveTransition(state: CardState, duration: TimeInterval) {

    guard var bottomView = self as? BottomView else {
      return
    }

    if bottomView.cardViewController.runningAnimations.isEmpty {

      self.animationTransitionIfNeeded(state: state, duration: duration)
    }

    bottomView.cardViewController.runningAnimations.forEach{ animator in
      animator.pauseAnimation()
      bottomView.cardViewController.animationProgressWhenInterrupted = animator.fractionComplete
    }
  }

  func updateInteractiveTransition(fractionCompleted: CGFloat) {

    guard var bottomView = self as? BottomView else {
      return
    }

    for animator in bottomView.cardViewController.runningAnimations {
      animator.fractionComplete = fractionCompleted + bottomView.cardViewController.animationProgressWhenInterrupted
    }

  }

  func continueInteractiveTransition() {

    guard var bottomView = self as? BottomView else {
      return
    }

    for animator in bottomView.cardViewController.runningAnimations {
      animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
    }

  }
}



