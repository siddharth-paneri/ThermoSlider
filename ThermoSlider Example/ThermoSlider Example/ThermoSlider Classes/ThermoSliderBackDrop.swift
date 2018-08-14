//
//  ThermoSliderBackDrop.swift
//  ThermosSlider
//
//  Created by Siddharth Paneri on 13/08/18.
//  Copyright © 2018 Siddharth Paneri. All rights reserved.
//

import UIKit


class ThermoSliderBackDrop: CAShapeLayer {
    weak var thermoSlider: ThermoSlider?
    var centrePoint : CGPoint?
    
    
    override init() {
        super.init()
        
    }
   
    init(frame: CGRect, thumbWidth : CGFloat, centerTomb: CGPoint) {
        super.init()
        let tunnelHeight = thumbWidth*3/2
        
        let xPath = UIBezierPath(arcCenter: centerTomb, radius: thumbWidth/2, startAngle: degreesToRadians(315), endAngle: degreesToRadians(45), clockwise: true)
        let xcomebackPoint = xPath.currentPoint
        
        let bPath = UIBezierPath(arcCenter: centerTomb, radius: thumbWidth/2, startAngle: degreesToRadians(45), endAngle: degreesToRadians(315), clockwise: true)
        bPath.lineWidth = 0.1
        let comebackPoint = bPath.currentPoint
        bPath.addLine(to: CGPoint(x: frame.maxX-tunnelHeight/4, y: comebackPoint.y))
        bPath.addQuadCurve(to: CGPoint(x: frame.maxX-tunnelHeight/4, y: xcomebackPoint.y), controlPoint: CGPoint(x: frame.maxX+8, y: frame.midY))
        bPath.addLine(to: CGPoint(x: xcomebackPoint.x, y: xcomebackPoint.y))
        self.fillColor = UIColor.clear.cgColor
        self.strokeColor = UIColor.red.cgColor
        self.path = bPath.cgPath
    }
    
    
    init(frame: CGRect, thumbWidth : CGFloat, centerTomb: CGPoint, theameColor: UIColor) {
        super.init()
        let tunnelHeight = thumbWidth*3/2
        
        let xPath = UIBezierPath(arcCenter: centerTomb, radius: thumbWidth/2, startAngle: degreesToRadians(315), endAngle: degreesToRadians(45), clockwise: true)
        let xcomebackPoint = xPath.currentPoint
        
        let bPath = UIBezierPath(arcCenter: centerTomb, radius: thumbWidth/2, startAngle: degreesToRadians(45), endAngle: degreesToRadians(315), clockwise: true)
        let comebackPoint = bPath.currentPoint
        bPath.addLine(to: CGPoint(x: frame.maxX-tunnelHeight/4, y: comebackPoint.y))
        bPath.addQuadCurve(to: CGPoint(x: frame.maxX-tunnelHeight/4, y: xcomebackPoint.y), controlPoint: CGPoint(x: frame.maxX+8, y: frame.midY))
        bPath.addLine(to: CGPoint(x: xcomebackPoint.x, y: xcomebackPoint.y))
        bPath.lineWidth = 1
        self.fillColor = UIColor.clear.cgColor
        self.strokeColor = theameColor.withAlphaComponent(0.2).cgColor
        self.path = bPath.cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func degreesToRadians(_ degree: Double)->CGFloat {
        let radian = (degree*Double.pi / 180.0)
        return CGFloat(radian)
    }
    
    
}
