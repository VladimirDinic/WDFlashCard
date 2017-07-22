//
//  ViewController.swift
//  WDFlashCard
//
//  Created by Vladimir Dinic on 7/22/17.
//  Copyright © 2017 Vladimir Dinic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WDFlashCardDelegate {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var frontView: UIView!
    @IBOutlet weak var flashCard: WDFlashCard!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        flashCard.flashCardDelegate = self
        flashCard.duration = 2.0
        flashCard.flipAnimation = .flipFromLeft
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: WDFlashCardDelegate methods
    
    func flipBackView() -> UIView {
        return backView
    }
    
    func flipFrontView() -> UIView {
        return frontView
    }
    
    
}

