//
//  Helper.swift
//  ThermoSlider
//
//  Created by Siddharth Paneri on 13/08/18.
//  Copyright © 2018 Siddharth Paneri. All rights reserved.
//

import Foundation


enum DisplayPrecisionValue : Int {
    case p0                     = 1
    case p1                     = 10        // <-- Use default
    case p2                     = 100
    case p3                     = 1000
    case p4                     = 10000
    case p5                     = 100000
    case p6                     = 1000000
    case p7                     = 10000000
    case p8                     = 100000000
    case p9                     = 1000000000
}

class Helper {
    class func getDecimalPlaceFormat(_ precision : Int) -> String {
        
        var decimal = 0 // 0 decimal places
        
        for char in String(precision) {
            if char == "0" {
                decimal += 1
            }
        }
        
        return ".\(decimal)"
    }
}

extension Double {
    
    /** Given a value to round and a factor to round to,
     round the value to the nearest multiple of that factor.
     */
    func round(_ toNearest: Double) -> Double {
        return round(self / toNearest) * toNearest
    }
    
    /** Given a value to round and a factor to round to,
     round the value DOWN to the largest previous multiple
     of that factor.
     */
    func roundDown(_ toNearest: Double) -> Double {
        return floor(self / toNearest) * toNearest
    }
    
    /** Given a value to round and a factor to round to,
     round the value DOWN to the largest previous multiple
     of that factor.
     */
    func roundUp(_ toNearest: Double) -> Double {
        return ceil(self / toNearest) * toNearest
    }
    
    /** Given a value to round and a factor to round to,
     round the value DOWN or UP decided according to closest value.
     */
    func closestRoundDouble(_ toNearest:Double) -> Double {
        let down =  self.roundDown(toNearest)
        let up = self.roundUp(toNearest)
        
        if (up-self) < (self-down) {
            return up
        } else {
            return down
        }
    }
    
    func format(_ f: String) -> String {
        return String(format: "%\(f)f", self)
    }
    
}

