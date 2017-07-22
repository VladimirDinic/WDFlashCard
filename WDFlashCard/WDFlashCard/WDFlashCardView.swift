//
//  FlipView.swift
//  FlipView
//
//  Created by Vladimir Dinic on 6/18/17.
//  Copyright © 2017 Vladimir Dinic. All rights reserved.
//

import UIKit

public enum FlipAnimations
{
    case flipFromLeft
    case flipFromRight
    case flipFromTop
    case flipFromBottom
    
    func animationOption() -> UIViewAnimationOptions
    {
        switch self
        {
            case .flipFromLeft:
                return .transitionFlipFromLeft
            case .flipFromRight:
                return .transitionFlipFromRight
            case .flipFromTop:
                return .transitionFlipFromTop
            case .flipFromBottom:
                return .transitionFlipFromBottom
        }
    }
}

@objc public protocol WDFlashCardDelegate
{
    func flipFrontView() -> UIView
    func flipBackView() -> UIView
}

@objc public protocol WDCurlAnimationDelegate
{
    func numberOfItems() -> Int
    func view(at index:Int) -> UIView
    func repeatInfinitely() -> Bool
}

open class WDFlashCard: UIView {
    
    open var flipAnimation:FlipAnimations = .flipFromLeft {
        didSet {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(flip))
            self.addGestureRecognizer(tapGesture)
        }
    }
    open var duration:Double = 1.0
    open var showFront:Bool = true
    #if TARGET_INTERFACE_BUILDER
        @IBOutlet open weak var flashCardDelegate: AnyObject?
    #else
    open var flashCardDelegate: WDFlashCardDelegate? = nil
    #endif
    var frontView:UIView?
    var backView:UIView?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setFrontAndBackView()
    {
        if let delegate = self.flashCardDelegate
        {
            frontView = delegate.flipFrontView()
            backView = delegate.flipBackView()
            backView?.isHidden = true
        }
    }
    
    open func flip() {
        self.setFrontAndBackView()
        if frontView != nil && backView != nil
        {
            let fromView = showFront ? frontView : backView
            let toView = showFront ? backView : frontView
            backView?.isHidden = showFront
            UIView.transition(from: fromView!,
                              to: toView!,
                              duration:duration,
                              options: [flipAnimation.animationOption(), .showHideTransitionViews]) { (finish) in
                                if finish {
                                    self.showFront = !self.showFront
                                    self.backView?.isHidden = self.showFront
                                }
            }
        }
    }    
}
