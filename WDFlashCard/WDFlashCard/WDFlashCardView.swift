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
    
    func animationOption() -> UIView.AnimationOptions
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
    func flipFrontView(forFlashCard flashCardView:WDFlashCard) -> UIView
    func flipBackView(forFlashCard flashCardView:WDFlashCard) -> UIView
    @objc optional func flashCardWillFlip(forFlashCard flashCardView:WDFlashCard)
    @objc optional func flashCardFlipped(forFlashCard flashCardView:WDFlashCard)
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
            frontView = delegate.flipFrontView(forFlashCard: self)
            backView = delegate.flipBackView(forFlashCard: self)
            backView?.isHidden = true
        }
    }
    
    @objc open func showFrontView() {
        if let frontView = self.frontView
        {
            self.bringSubviewToFront(frontView)
            frontView.isHidden = false
            showFront = true
        }
    }
    
    @objc open func showBackView() {
        if let backView = self.backView
        {
            self.bringSubviewToFront(backView)
            backView.isHidden = false
            showFront = false
        }
        
    }
    
    @objc open func flip() {
        if !animationInProgress
        {
            self.setFrontAndBackView()
            if frontView != nil && backView != nil
            {
                if let delegate = self.flashCardDelegate
                {
                    if delegate.flashCardWillFlip != nil
                    {
                        delegate.flashCardWillFlip!(forFlashCard: self)
                    }
                }
                let fromView = showFront ? frontView : backView
                let toView = showFront ? backView : frontView
                backView?.isHidden = showFront
                animationInProgress = true
                UIView.transition(from: fromView!,
                                  to: toView!,
                                  duration: duration,
                                  options: [flipAnimation.animationOption(), .showHideTransitionViews]) { (finish) in
                                    self.animationInProgress = false
                                    if finish {
                                        self.showFront = !self.showFront
                                        self.backView?.isHidden = self.showFront
                                    }
                                    if let delegate = self.flashCardDelegate
                                    {
                                        if delegate.flashCardFlipped != nil
                                        {
                                            delegate.flashCardFlipped!(forFlashCard: self)
                                        }
                                    }
                }
            }
        }
    }
}

