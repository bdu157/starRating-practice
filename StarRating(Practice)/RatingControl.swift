//
//  RatingControl.swift
//  StarRating(Practice)
//
//  Created by Dongwoo Pae on 7/1/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class RatingControl: UIControl {

    var value : Int = 1
    var labels: [UILabel] = []

    private let componentDimension: CGFloat = 40
    private let spacingValue: Int = 5
    private let componentActiveColor = UIColor.black
    private let componentInactiveColor = UIColor.gray
    private let componentCount: Int = 5
    
    //i can create 5 labels here and create constraints using NSLayout or isActive
    //or i can create 5 labels with CGRect using for loop
    //private var starLabel: UILabel = UILabel()
    
    func setup() {
        //create UILabels for stars and append them to array of UILabel
        for num in 1...componentCount {
            let starLabel: UILabel = UILabel()
            
            starLabel.text = "✭"
            addSubview(starLabel)
            starLabel.frame = CGRect(x: CGFloat(spacingValue * num) + componentDimension * CGFloat((num - 1)), y: 0, width: componentDimension, height: componentDimension)
            
            starLabel.tag = num
            starLabel.textColor = componentInactiveColor
            starLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
            starLabel.textAlignment = .center
            if let firstLabel = starLabel.viewWithTag(1) as? UILabel {
            firstLabel.textColor = componentActiveColor
            }
            labels.append(starLabel)
        }
    }
    
    
    //Touch Handlers
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        print("begining tracking")
        self.updateValue(at: touch)
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        self.updateValue(at: touch)
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard let touch = touch else {return}
        self.updateValue(at: touch)
    }
    
    override func cancelTracking(with event: UIEvent?) {
        print("cancel traking")
    }
 
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func updateValue(at touch: UITouch) {
        let touchPoint = touch.location(in: self)
        for label in labels {
            if label.frame.contains(touchPoint) {
            if label.tag != self.value {
                label.performFlare()
                self.value = label.tag
                for label in labels {
                    if label.tag <= value {
                        label.textColor = componentActiveColor
                    } else {
                        label.textColor = componentInactiveColor
                    }
                }
                sendActions(for: .valueChanged)
                }
            }
        }
    }
}
        extension UIView {
            // "Flare view" animation sequence
            func performFlare() {
                func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
                func unflare() { transform = .identity }
                
                UIView.animate(withDuration: 0.2,
                               animations: { flare() },
                               completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
            }
}
