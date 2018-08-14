//
//  ThermoSliderThumbLayer.swift
//  ThermoSlider
//
//  Created by Siddharth Paneri on 13/08/18.
//  Copyright © 2018 Siddharth Paneri. All rights reserved.
//

import UIKit

class ThermoSliderThumbLayer: CALayer {
    var highlighted: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    weak var thermoSlider : ThermoSlider?
    
    override func draw(in ctx: CGContext) {
        if let slider = thermoSlider {
            self.sublayers?.removeAll()
            ctx.clear(self.bounds);
            ctx.setFillColor(UIColor.white.cgColor)
            ctx.fillEllipse(in: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height));
//            CGContextSetStrokeColorWithColor(ctx, slider.theameColor)
//            CGContextSetLineWidth(ctx, 5)
            let imageview = UIImageView.init(image: slider.thumbImage)
            imageview.frame = self.bounds
            imageview.contentMode = UIViewContentMode.center
            imageview.backgroundColor = UIColor.init(cgColor: slider.theameColor)//.copy(alpha: 0.2)
            imageview.layer.borderColor = slider.theameColor.copy(alpha: 0.2)
            imageview.layer.borderWidth = 1
            imageview.layer.cornerRadius = bounds.size.width/2
            imageview.layer.masksToBounds = true
            self.addSublayer(imageview.layer)
            ctx.saveGState();
            if self.highlighted {
                self.shadowColor = UIColor.black.cgColor
                self.shadowOffset = CGSize(width: 0, height: 5)
                self.shadowOpacity = 0.4
                self.shadowRadius = 5
            } else {
                self.shadowColor = UIColor.clear.cgColor
            }
            ctx.restoreGState();
        }
    }
}
