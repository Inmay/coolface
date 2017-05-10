//
//  ViewController.swift
//  coolinter
//
//  Created by WuYueFeng on 2017/5/9.
//  Copyright © 2017年 WuYueFeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let itLayer = bzLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        itLayer.frame = CGRect.init(x: (view.bounds.width-300)/2, y: (view.bounds.height-300)/2, width: 300, height: 300)
        view.layer.addSublayer(itLayer)
        
        itLayer.setNeedsDisplay()
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        firstTouch = touches.first!.location(in: self.view)
    }
    
    var firstTouch:CGPoint = CGPoint(x: 0, y: 0)
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let xOffset = touches.first!.location(in: self.view).x - firstTouch.x
        let yOffset = touches.first!.location(in: self.view).y - firstTouch.y
        itLayer.movePoint = CGPoint(x: itLayer.movePoint.x + xOffset/2, y: itLayer.movePoint.y + yOffset/2)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        
        UIView.animate(withDuration: 1) {
            self.itLayer.movePoint = self.itLayer.centerPoint
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
