//
//  ViewController.swift
//  Tower
//
//  Created by Timple Soft on 28/11/16.
//  Copyright © 2016 TimpleSoft. All rights reserved.
//

import UIKit

enum BoxColor : Int {
    case Blue = 0
    case Green = 1
    case Red = 2
    case Orange = 3
    case Yellow = 4
}

class ViewController: UIViewController, UICollisionBehaviorDelegate {

    var gravity : UIGravityBehavior!
    var collision : UICollisionBehavior!
    var animator : UIDynamicAnimator!
    
    var boxCounter : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        gravity = UIGravityBehavior()
        collision = UICollisionBehavior()
        collision.collisionDelegate = self
        collision.setTranslatesReferenceBoundsIntoBoundary(with: .zero)
        
        animator = UIDynamicAnimator(referenceView: self.view)
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    
    func viewTapped(tapGesture: UITapGestureRecognizer){
        
        let point = tapGesture.location(ofTouch: 0, in: self.view)
        addBox(x: Int(point.x), y:Int(point.y))
        
    }
    
    
    func addBox(x: Int, y: Int){
        
        boxCounter += 1
        let randomColor = self.randomColor()
        let randomSize = self.randomSize()
        
        let view = UIView(frame: CGRect(x: x - randomSize.width/2, y: y, width: randomSize.width, height: randomSize.height))
        view.backgroundColor = randomColor
        view.tag = boxCounter
        
        self.view.addSubview(view)
        self.gravity.addItem(view)
        self.collision.addItem(view)
        
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?) {
        
        if let view = item as? UIView {
            if view.tag > 1 {
                let alertVC = UIAlertController(title: "Game over", message: "You lose!", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertVC.addAction(alertAction)
                present(alertVC, animated: true, completion: { 
                    
                    for view in self.view.subviews{
                        self.gravity.removeItem(view)
                        self.collision.removeItem(view)
                        view.removeFromSuperview()
                    }
                    self.boxCounter = 0
                    
                })
            }
        }
    }

    
    func randomColor() -> UIColor {
        
        let randomNumber = Int(arc4random_uniform(UInt32(5)))
        let color : BoxColor = BoxColor(rawValue: randomNumber)!
        
        switch color {
        case .Blue:
            return #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1)
        case .Green:
            return #colorLiteral(red: 0.1803921569, green: 0.8, blue: 0.4431372549, alpha: 1)
        case .Red:
            return #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
        case .Orange:
            return #colorLiteral(red: 0.9019607843, green: 0.4941176471, blue: 0.1333333333, alpha: 1)
        case .Yellow:
            return #colorLiteral(red: 0.9450980392, green: 0.768627451, blue: 0.05882352941, alpha: 1)
        }
        
    }
    
    
    func randomSize() -> (width: Int, height: Int) {
        
        let height = Int(arc4random_uniform(UInt32(100))) + 30 // mínimo de altura 30
        let width = Int(arc4random_uniform(UInt32(100))) + 30 // mínimo de altura 30
        return (width, height)
        
    }
    
    
    
    
    
}

