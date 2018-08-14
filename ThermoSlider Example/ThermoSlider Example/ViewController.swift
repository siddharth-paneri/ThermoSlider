//
//  ViewController.swift
//  ThermoSlider
//
//  Created by Siddharth Paneri on 13/08/18.
//  Copyright © 2018 Siddharth Paneri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var thermoSliderView: ThermoSliderView!
    @IBOutlet weak var label_Min: UILabel!
    @IBOutlet weak var label_Max: UILabel!
    @IBOutlet weak var label_Value: UILabel!
    
    let min : Double = 0.0
    let max : Double  = 60.0
    var thermoValue : Double = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        thermoSliderView.sliderMaxThumbImage = UIImage(named: "thumb-icon")
        thermoSliderView.sliderMinThumbImage = UIImage(named: "thumb-icon")
        thermoSliderView.componentColor = UIColor.red
        thermoSliderView.gradientEndColor = UIColor.red
        thermoSliderView.thermoSlider.addTarget(self, action: #selector(sliderValueDidChanged(_:)), for: .valueChanged)
        thermoSliderView.thermoSlider.addTarget(self, action: #selector(sliderTouchReleased(_:)), for: .touchUpInside)
        
        /* minimum and maximum value of slider */
        thermoSliderView.thermoSlider.minimumTempratureValue = min
        thermoSliderView.thermoSlider.maximumTempratureValue = max
        
        //Display precision
        let format = Helper.getDecimalPlaceFormat(Int(DisplayPrecisionValue.p1.rawValue))
        self.label_Min.text = "min \(min.format(format))°"
        self.label_Max.text = "max \(max.format(format))°"
    }

    @objc func sliderValueDidChanged(_ slider: ThermoSlider){
        let value = slider.getTemperatureValue(slider.value)
        self.thermoValue = value
        self.updateTargetDisplay()
    }
    
    @objc func sliderTouchReleased(_ slider: ThermoSlider){
        
    }
    

    func updateTargetDisplay() {
        //Display precision
        let format = Helper.getDecimalPlaceFormat(Int(DisplayPrecisionValue.p1.rawValue))
        self.label_Value.text = "\(self.thermoValue.format(format))°"
    }
    
    
}



