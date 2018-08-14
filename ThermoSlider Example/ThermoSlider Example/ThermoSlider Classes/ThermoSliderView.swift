//
//  ThermoSliderView.swift
//  CustomSlider
//
//  Created by Siddharth Paneri on 12/05/16.
//  Copyright © 2016 Secure Meters Limited. All rights reserved.
//

import UIKit

class ThermoSliderView: UIControl {

    let thermoSlider = ThermoSlider(frame: CGRect.zero)
    var thumbHeight : CGFloat = 0
    var theameColor : UIColor = UIColor.red
    var gradientStartColor : UIColor!
    var gradientEndColor : UIColor!
    var componentColor : UIColor!
    var sliderMinThumbImage : UIImage!
    var sliderMaxThumbImage : UIImage!
    var stepValue : Double = 0.5 {
        didSet {
            updateSlider()
        }
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, ThumbHeight thumbHeight: CGFloat) {
        super.init(frame: frame)
        _ = ThermoSliderView.init(frame: frame)
        self.thumbHeight = thumbHeight
    }
    
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.thumbHeight = rect.size.height
        self.backgroundColor = UIColor.clear
        let margin: CGFloat = 0
        let xPos = margin/2+thumbHeight/2
        let width = self.bounds.width - xPos*2
        let backDrop = ThermoSliderBackDrop(frame: bounds, thumbWidth: thumbHeight, centerTomb: CGPoint(x: xPos, y: bounds.midY), theameColor: self.theameColor)
        self.layer.addSublayer(backDrop)
        self.addSubview(thermoSlider)
        
        self.thermoSlider.trackGradientStartColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
        self.thermoSlider.trackGradientEndColor = self.gradientEndColor.cgColor
        self.thermoSlider.trackColor = self.componentColor.cgColor
        self.thermoSlider.theameColor = self.theameColor.cgColor
        self.thermoSlider.thumbWidth = thumbHeight
        self.thermoSlider.stepValue = self.stepValue
        
        self.thermoSlider.minimumThumbImage = self.sliderMinThumbImage
        self.thermoSlider.maximumThumbImage = self.sliderMaxThumbImage
        self.thermoSlider.frame = CGRect(x: (thumbHeight/2)-thermoSlider.trackHeight, y: 0, width: width, height: thermoSlider.thumbWidth)
    }
    
    func updateSlider() {
        self.thermoSlider.stepValue = self.stepValue
    }
    
    func degreesToRadians(_ degree: Double)->CGFloat {
        let radian = (degree*Double.pi / 180.0)
        return CGFloat(radian)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return self.thermoSlider.beginTracking(touch, with: event)
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return self.thermoSlider.continueTracking(touch, with: event)
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        self.thermoSlider.endTracking(touch, with: event)
        
    }

}
