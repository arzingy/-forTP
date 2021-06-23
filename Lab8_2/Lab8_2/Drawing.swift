//
//  Drawing.swift
//  Lab8_2
//
//  Created by admin on 5/21/21.
//

import Foundation
import UIKit

class Drawing{
static func Draw8Angle(context: CGContext, x: CGFloat , y:CGFloat, circumRadius:CGFloat){
        
        context.saveGState();
        context.move(to: CGPoint(x:x,y:y))
        
        for n in 0...8 {
            
            let angleStep = 2*3.14*1.0*CGFloat(n)/8;
            let xStep=circumRadius*CGFloat(cos(angleStep));
            let yStep=circumRadius*CGFloat(sin(angleStep));
            
            context.addLine(to: CGPoint(x:x+xStep,y:y+yStep));
        };
        
        
        
        let colors = [UIColor.green.cgColor, UIColor.red.cgColor]
             
             // 3
             let colorSpace = CGColorSpaceCreateDeviceRGB()
             
             // 4
        let colorLocations: [CGFloat] = [0, 0.3]
             
             // 5
             let gradient = CGGradient(colorsSpace: colorSpace,
                                            colors: colors as CFArray,
                                         locations: colorLocations)!
    
        context.clip();
        
             // 6
        let startPoint = CGPoint(x:x,y:0);
             let endPoint = CGPoint(x: 0, y: 2000)
             context.drawLinearGradient(gradient,
                                 start: startPoint,
                                   end: endPoint,
                               options: [])

        // Also used this method
    
         context.fillPath();
        
        context.restoreGState();
    }
}
