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

open class WDFlashCard: UIView {
    
    var animationInProgress:Bool = false
    var tapToFlipGesture:UITapGestureRecognizer?
    open var flipAnimation:FlipAnimations = .flipFromLeft
    open var duration:Double = 1.0
    open var showFront:Bool = true
    open var disableTouchToFlipFesture:Bool = false
    {
        didSet {
            self.setupTapToFlipGesture()
        }
    }
    #if TARGET_INTERFACE_BUILDER
        @IBOutlet open weak var flashCardDelegate: AnyObject?
    #else
    open var flashCardDelegate: WDFlashCardDelegate? = nil
    #endif
    var frontView:UIView?
    var backView:UIView?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupTapToFlipGesture()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupTapToFlipGesture()
    }
    
    func setupTapToFlipGesture()
    {
        if !disableTouchToFlipFesture
        {
            if let tapGesture = tapToFlipGesture
            {
                tapGesture.isEnabled = true
            }
            else
            {
                tapToFlipGesture = UITapGestureRecognizer(target: self, action: #selector(flip))
                self.addGestureRecognizer(tapToFlipGesture!)
            }
        }
        else
        {
            if let tapGesture = tapToFlipGesture
            {
                tapGesture.isEnabled = false
            }
        }
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
        if !animationInProgress
        {
            self.setFrontAndBackView()
            if frontView != nil && backView != nil
            {
                let fromView = showFront ? frontView : backView
                let toView = showFront ? backView : frontView
                backView?.isHidden = showFront
                animationInProgress = true
                UIView.transition(from: fromView!,
                                  to: toView!,
                                  duration:duration,
                                  options: [flipAnimation.animationOption(), .showHideTransitionViews]) { (finish) in
                                    self.animationInProgress = false
                                    if finish {
                                        self.showFront = !self.showFront
                                        self.backView?.isHidden = self.showFront
                                    }
                }
            }
        }
    }    
}
