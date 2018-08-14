//
//  ThermoSlider.swift
//  ThermoSlider
//
//  Created by Siddharth Paneri on 13/08/18.
//  Copyright © 2018 Siddharth Paneri. All rights reserved.
//

import UIKit

class ThermoSlider: UIControl {
    
    /* given minimum limit for temprature */
    var minimumTempratureValue: Double = 5.0
    /* given maximum limit for temprature */
    var maximumTempratureValue: Double = 32.0
    
    /* given minimum limit for temprature */
    var minimumLightValue: Double = 0.0
    /* given maximum limit for temprature */
    var maximumLightValue: Double = 10.0
    
    
    var stepValue : Double = 0.5 {
        didSet {
            updateFrames()
        }
    }
    
    /* givin minimum limit for slider */
    var minimumValue: Double = 0.0 {
        didSet {
            updateFrames()
        }
    }
    /* givin maximum limit for slider */
    var maximumValue: Double = 100.0 {
        didSet {
            updateFrames()
        }
    }
    
    /* current slider value */
    var value: Double = 50.0 {
        didSet {
            updateFrames()
        }
    }
    /* previous location slider */
    var previousLocation = CGPoint()
    
    /* tracK Layer */
    let trackLayer = ThermoSliderTrackLayer()
    var trackHeight:CGFloat = 4.0 {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    /* track color*/
    var trackColor: CGColor = UIColor.lightGray.cgColor {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    
    var trackGradientStartColor: CGColor = UIColor.lightGray.cgColor {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    
    var trackGradientEndColor: CGColor = UIColor.lightGray.cgColor {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }
    
    /* Thumb Layer */
    let thumbLayer = ThermoSliderThumbLayer()
    var theameColor: CGColor = UIColor.white.cgColor {
        didSet {
            thumbLayer.setNeedsDisplay()
        }
    }
    var thumbImage: UIImage! {
        didSet {
            thumbLayer.setNeedsDisplay()
        }
    }
    
    var minimumThumbImage: UIImage! {
        didSet {
            thumbLayer.setNeedsDisplay()
        }
    }
    
    var maximumThumbImage: UIImage! {
        didSet {
            thumbLayer.setNeedsDisplay()
        }
    }
    var thumbColor: CGColor = UIColor.red.cgColor {
        didSet {
            thumbLayer.setNeedsDisplay()
        }
    }
    /* Thumb Margin */
    var thumbMargin:CGFloat = 2.0 {
        didSet {
            thumbLayer.setNeedsDisplay()
        }
    }
    
    /* Thumb Width */
    var thumbWidth: CGFloat = 100 {
        didSet {
            thumbLayer.setNeedsDisplay()
        }
    }
    override var frame: CGRect {
        didSet {
            updateFrames()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        #if ACCESSIBILITY_ENABLE
            self.isAccessibilityElement = false
            self.accessibilityHint = "ThermoSlider"
            self.accessibilityLabel = "ThermoSlider"
            self.accessibilityTraits = UIAccessibilityTraitNone
            self.accessibilityValue = "\(value)"
            self.accessibilityElementsHidden = false
        #endif
        
        trackLayer.thermoSlider = self
        trackLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(trackLayer)
        
        thumbLayer.thermoSlider = self
        thumbLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(thumbLayer)
        
        #if ACCESSIBILITY_ENABLE
            self.thumbLayer.isAccessibilityElement = true
            self.thumbLayer.accessibilityHint = "ThermoSliderViewThumb"
            self.thumbLayer.accessibilityLabel = "ThermoSliderViewThumb"
            self.thumbLayer.accessibilityTraits = UIAccessibilityTraitAdjustable
            self.thumbLayer.accessibilityValue = "\(value)"
        #endif
        
        self.accessibilityElements = [self.thumbLayer]
        
        self.addTarget(self, action: #selector(ThermoSlider.sliderValueDidChanged(_:)), for: .valueChanged)
        self.addTarget(self, action: #selector(ThermoSlider.sliderTouchReleased(_:)), for: .touchUpInside)
        
        updateFrames()
    }
    
    /* This method updates frame for full component according to slider value */
    func updateFrames() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)

        trackLayer.frame = CGRect(x: 0, y: bounds.midY-(trackHeight*2), width: bounds.width, height: trackHeight*4)
        trackLayer.setNeedsDisplay()
        
        let thumbCenter = CGPoint(x: CGFloat(value) * (bounds.width / CGFloat(maximumValue)), y: bounds.midY)
        thumbLayer.frame = CGRect(x: thumbCenter.x - thumbWidth / 2, y: thumbCenter.y - thumbWidth / 2 , width: thumbWidth, height: thumbWidth)
        self.updateSliderThumb(self)
        self.updateSliderTrack(self)
        thumbLayer.setNeedsDisplay()
        
        CATransaction.commit()
    }
    /* This method updates the thumb image according to current value of slider */
    func updateSliderThumb(_ slider: ThermoSlider){
        
        if slider.value < slider.minimumValue {
            slider.value = slider.minimumValue
        } else if slider.value > slider.maximumValue {
            slider.value = slider.maximumValue
        }
        
        if slider.value == slider.minimumValue {
            slider.thumbImage = slider.minimumThumbImage
        } else {
            slider.thumbImage = slider.maximumThumbImage
        }
    }
    
    
    func updateSliderTrack(_ slider: ThermoSlider){
        if slider.value == slider.minimumValue {
            slider.trackGradientEndColor = slider.trackGradientStartColor
        } else {
            slider.trackGradientEndColor = slider.trackColor
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previousLocation = touch.location(in: self)
        
        if thumbLayer.frame.contains(previousLocation) {
            thumbLayer.highlighted = true
        }
        
        return thumbLayer.highlighted
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        // Track how much user has dragged
        let deltaLocation = Double(location.x - previousLocation.x)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - thumbLayer.frame.width)
        
        previousLocation = location
        
        // update value
        if thumbLayer.highlighted {
            value += deltaValue
            value = clipValue(value)
        }
        self.sendActions(for: .valueChanged)
        return thumbLayer.highlighted
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        thumbLayer.highlighted = false
        let roundValue = self.value.closestRoundDouble(self.stepValue)
        let thumbCenter = CGPoint(x: CGFloat(roundValue) * (self.bounds.width / CGFloat(self.maximumValue)), y: self.bounds.midY)
            self.thumbLayer.frame = CGRect(x: thumbCenter.x - self.thumbWidth / 2, y: self.thumbMargin , width: self.thumbWidth, height: self.thumbWidth)
        self.value = self.value.closestRoundDouble(self.stepValue)
        self.sendActions(for: .touchUpInside)
        
    }
    
    func clipValue(_ value: Double) -> Double {
        return min(max(value, minimumValue ), maximumValue)
    }
    
    //MARK:- Slider Actions
    
    @objc func sliderValueDidChanged(_ slider: ThermoSlider) {
        self.updateSliderThumb(slider)
        self.updateSliderTrack(self)
    }
    @objc func sliderTouchReleased(_ slider: ThermoSlider) {
        NSLog("Slider Value \(slider.value)")
    }
    
    /**  should return decimal value of temperature with respect to slider value
     */
    func getTemperatureValue(_ sliderValue : Double) -> Double{
        let temperature = ((sliderValue/100)*(maximumTempratureValue-minimumTempratureValue))+minimumTempratureValue
        return temperature.closestRoundDouble(self.stepValue)
    }
    
    /**  should return decimal value of light with respect to slider value
     */
    func getLightValue(_ sliderValue : Double) -> Double{
        let light = ((sliderValue/100)*(maximumLightValue-minimumLightValue))+minimumLightValue
        return light.closestRoundDouble(self.stepValue)
    }
    
    /**  should return decimal value of slider with respect to temperature
     */
    func getSliderValue_OfTemperature(_ temperature : Double) -> Double{
        let sliderValue = ((temperature-minimumTempratureValue)/(maximumTempratureValue-minimumTempratureValue))*100
        return sliderValue.closestRoundDouble(self.stepValue)
    }
    
    /**  should return decimal value of slider with respect to light
     */
    func getSliderValue_OfLight(_ light : Double) -> Double {
        let sliderValue = ((light-minimumLightValue)/(maximumLightValue-minimumLightValue))*100
        return sliderValue.closestRoundDouble(self.stepValue)
    }
    
    
}

