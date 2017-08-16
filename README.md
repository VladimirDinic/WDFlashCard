# WDFlashCard
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/WDFlashCard.svg)](http://cocoapods.org/pods/WDFlashCard)
[![License](https://img.shields.io/cocoapods/l/WDFlashCard.svg?style=flat)](http://cocoapods.org/pods/WDFlashCard)
[![Platform](https://img.shields.io/cocoapods/p/WDFlashCard.svg?style=flat)](http://cocoapods.org/pods/WDFlashCard)

WDFlashCard is a simple lightweight component for displaying flashcards inside iOS apps. Just add front and back view, set flashcard animation type and duration.

 ![GitHub Logo](/Resources/FlashCard.gif)

# Installation:
## Manual:
Just download source code and include WDFlashCard/WDFlashCard/WDFlashCardView.swift in your project.

## CocoaPods:
```Ruby
target '<TargetName>' do
    use_frameworks!
    pod 'WDFlashCard'
end
```

## Usage

Add UIView to storyboard or Xib file and set WDFlashCard as its class. Also, add two views inside this WDFlashCard view to use them as a back and front view for flash card view. Then set WDFlashCardDelegate (using interface builder or in code) and implement its metods: flipBackView to set back view and flipFrontView to set front view.

```Swift
class ViewController: UIViewController, WDFlashCardDelegate {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var frontView: UIView!
    @IBOutlet weak var flashCard: WDFlashCard!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        flashCard.duration = 2.0
        flashCard.flipAnimation = .flipFromLeft
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: WDFlashCardDelegate methods
    
    func flipBackView(forFlashCard flashCardView: WDFlashCard) -> UIView {
        return backView
    }
    
    func flipFrontView(forFlashCard flashCardView: WDFlashCard) -> UIView {
        return frontView
    }
}
```

If you want to disable tap to flip option, you can set flashCard.disableTouchToFlipFesture to true (By default, it is set to true). 

```Swift
flashCard.disableTouchToFlipFesture = true
```

In that case, you are still able to flip this view. All you need to do is to call flip() method from wherever you need: 

```Swift
flashCard.flip()
```

For better understanding look at the source code example.

# Note:
If you find any bug, please report it, and I will try to fix it ASAP.
