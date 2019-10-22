//
//  Canvas.swift
//  IaPhotographer
//
//  Created by Gabriel Rocco on 05/07/2019.
//  Copyright © 2019 Gabriel Rocco. All rights reserved.
//

import Foundation
import UIKit

class Line{
    var start: CGPoint
    var end: CGPoint
    
    var startX: CGFloat{
        get{
            return start.x
        }
    }
    
    var startY: CGFloat{
        get{
            return start.y
        }
    }
    
    var endX: CGFloat{
        get{
            return end.x
        }
    }
    
    var endY: CGFloat{
        get{
            return end.y
        }
    }
    
    init(start _start:CGPoint, end _end: CGPoint) {
        start = _start
        end = _end
    }

}

class Canvas: UIView{
    
    
    
    var lines: [Line] = []
    var lastPoint: CGPoint!
    var drawColor = UIColor.white.cgColor
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastPoint = touches.first?.location(in: self)
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
      var newPoint = touches.first?.location(in: self)
      
        if Int(newPoint!.x) > Int(lastPoint.x*1.02) || Int(newPoint!.x) < Int(lastPoint.x*1.02) {
            lines.append(Line(start: lastPoint, end: newPoint!))
            lastPoint = newPoint
        }
       self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        context!.setStrokeColor(drawColor)
        context!.setLineWidth(18)
        context!.setAlpha(0.1)
        context!.setLineCap(.butt)
      
        context!.setAllowsAntialiasing(true)
        context!.setFlatness(0.8)
       
        
        for line in lines {
           context?.beginPath()
            context?.move(to: CGPoint(x: line.startX, y: line.startY))
            context?.addLine(to: CGPoint(x: line.endX, y: line.endY))
            context?.strokePath()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    
    var color: UIColor = UIColor.white
    
    
    
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else{
            return
        }
        
        //        let startPoint = CGPoint(x: 0, y: 0)
        //        let endPoint = CGPoint(x: 100, y: 100)
        //
        //        context.move(to: startPoint)
        //        context.addLine(to: endPoint)
        
        
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(20)
        context.setAlpha(0.16)
        context.setLineCap(.round)
       // context.setAllowsAntialiasing(true)
        context.setFlatness(0.8)
      context.setFillColor(color.cgColor)
      
      //   context.setShouldAntialias(true)
   
   
        
        
        lines.forEach { (line) in
            for (i, p) in line.enumerated() {
                if i == 0{
                    context.move(to: p)
                }else{
                   context.addLine(to: p)
                }
                
            }
        }
        
        
        
        
        
        context.strokePath()
        
    }
    
    // var line = [CGPoint]()
    var lines =  [[CGPoint]]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        lines.append([CGPoint]())
    }
    
    
    //Whatever you do here you can track where your finger is inside the view
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
          let methodStart = NSDate()
        
        guard let point = touches.first?.location(in: self) else{return}
        
        guard var lastLine = lines.popLast() else{return}
        
 
    
        lastLine.append(point)
        
        lines.append(lastLine)
        
        
        // line.append(point)
        
        setNeedsDisplay()
        
        let methodFinish = NSDate()
        let executionTime = methodFinish.timeIntervalSince(methodStart as Date)
         print("Execution time: \(executionTime)")
        
    }
    
    */
    
}
