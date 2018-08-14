//
//  ThermoSliderTrackLayer.swift
//  ThermoSlider
//
//  Created by Siddharth Paneri on 13/08/18.
//  Copyright © 2018 Siddharth Paneri. All rights reserved.
//

import UIKit

class ThermoSliderTrackLayer: CALayer {
    weak var thermoSlider: ThermoSlider?
    
    override func draw(in ctx: CGContext) {
        if let slider = thermoSlider {
            
            self.sublayers?.removeAll()
            
            // Path without ticks
            let trackPath = UIBezierPath(roundedRect: CGRect(x: 0, y: (bounds.height-slider.trackHeight)/2, width: bounds.width, height: slider.trackHeight), cornerRadius: slider.trackHeight)
            
            
            let headpath = UIBezierPath(ovalIn: CGRect(x: 0, y: bounds.height/4, width: bounds.height/2, height: bounds.height/2));
            trackPath.append(headpath)
            
            let startColor = slider.trackGradientStartColor
            let endColor = slider.trackGradientEndColor
            var components : [CGFloat] = []
            if let startColorComps = startColor.components {
                components.append(contentsOf: startColorComps)
            }
            
            if let endColorComps = endColor.components {
                components.append(contentsOf: endColorComps)
            }
            
//            components = [
//                startColorComps[0], startColorComps[1], startColorComps[2], startColorComps[3],     // Start color
//                endColorComps[0], endColorComps[1], endColorComps[2], endColorComps[3]      // End color
//            ]
            
            // Setup the gradient
            let baseSpace = CGColorSpaceCreateDeviceRGB()
            let gradient = CGGradient(colorSpace: baseSpace, colorComponents: components, locations: nil, count: 2)
            
            // Gradient direction
            let startPoint = CGPoint(x: self.bounds.minX, y: self.bounds.midY)
            let endPoint = CGPoint(x: self.bounds.maxX, y: self.bounds.midY)
            
            ctx.saveGState();
            ctx.addPath(trackPath.cgPath);
            ctx.clip();
            ctx.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: []);
            ctx.restoreGState();
 
        }
    }
}
