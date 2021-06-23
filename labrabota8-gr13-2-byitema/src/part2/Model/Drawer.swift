import Foundation
import UIKit

class Drawer: UIView{
    static func DrawPentagon(x: CGFloat, y:CGFloat, circumRadius: CGFloat) -> CALayer{
        let path = UIBezierPath()
        path.move(to: CGPoint(x: x, y: y))
        
        let shapeLayer = CAShapeLayer()
        
        for i in 0...5 {
            let delta = 2*CGFloat.pi*1.0*CGFloat(i)/5;
            let xDelta = circumRadius*CGFloat(cos(delta))
            let yDelta = circumRadius*CGFloat(sin(delta))
            
            path.addLine(to: CGPoint(x:x+xDelta, y:y+yDelta))
        }
        
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.red.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 3.0
        
        return shapeLayer
    }
    
    static func DrawSixLeaf(x: CGFloat, y:CGFloat, circumRadius: CGFloat) -> CALayer {
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: x, y: y), radius: CGFloat(circumRadius * 1.7), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
            
        let shapeLayer = CAShapeLayer()
        
        for i in 0...6 {
            let delta = 2*CGFloat.pi*1.0*CGFloat(i)/6;
            let xDelta = circumRadius*CGFloat(cos(delta))
            let yDelta = circumRadius*CGFloat(sin(delta))
            
            let circlePath2 = UIBezierPath(arcCenter: CGPoint(x: x + xDelta, y: y + yDelta), radius: CGFloat(circumRadius), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
            
            let shapeLayer2 = CAShapeLayer()
            shapeLayer2.path = circlePath2.cgPath
            shapeLayer2.fillColor = UIColor.red.cgColor
            shapeLayer2.strokeColor = UIColor.red.cgColor
            shapeLayer2.lineWidth = 3.0
            
            shapeLayer2.shadowPath = circlePath2.cgPath
            shapeLayer2.lineWidth = 3.0
            shapeLayer2.shadowRadius = 10.0
            shapeLayer2.shadowOpacity = 0.8
            shapeLayer2.shadowOffset = CGSize.zero
            
            shapeLayer.addSublayer(shapeLayer2)
        }
        
        let shapeLayer3 = CAShapeLayer()
        shapeLayer3.path = circlePath.cgPath

        shapeLayer3.fillColor = UIColor.red.cgColor
        shapeLayer3.strokeColor = UIColor.red.cgColor
        shapeLayer3.lineWidth = 3.0
        
        shapeLayer.addSublayer(shapeLayer3)
        
        return shapeLayer
    }
    
    static func DrawUnion(x: CGFloat, y:CGFloat, circumRadius: CGFloat) -> CALayer {
        let shapeLayer = CAShapeLayer()
        let lay = Drawer.DrawPentagon(x: x, y: y, circumRadius: 40)
        
        shapeLayer.addSublayer(lay)
        
        let layer2 = Drawer.DrawSixLeaf(x: x, y: y + 40, circumRadius: 30)
        shapeLayer.addSublayer(layer2)
        
        return shapeLayer
    }
}
