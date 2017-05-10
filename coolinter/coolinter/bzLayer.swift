//
//  bzLayer.swift
//  coolinter
//
//  Created by WuYueFeng on 2017/5/9.
//  Copyright © 2017年 WuYueFeng. All rights reserved.
//

import UIKit

class bzLayer: CALayer {
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //直径
    var diameter:CGFloat = 60
    //移动点
    //  (60,60) 为正中心
    var centerPoint = CGPoint(x: 120, y: 120)
    var movePoint:CGPoint = CGPoint(x: 120, y: 120) {
        didSet{
            //方向大于30向左移
            
            self.setNeedsDisplay()
        }
    }
    
    override func draw(in ctx: CGContext) {
        //外框
        let rect = CGRect.init(x: movePoint.x, y: movePoint.y, width: diameter, height: diameter)

//        let rectPath = UIBezierPath(rect: rect)
//        ctx.addPath(rectPath.cgPath)
//        ctx.setStrokeColor(UIColor.black.cgColor)
//        ctx.setLineWidth(1.0)
//        ctx.setLineDash(phase: 0, lengths: [5,5]) //加断点
//        ctx.strokePath() //给线条填充颜色
        
        
        //移动时偏移量,最大为0.5倍宽度(30),最小为0
        let tempX = fabs(movePoint.x - centerPoint.x)
        let movedXDistance = tempX <= diameter/2 ? tempX : diameter/2
        let toLeft = movePoint.x <= centerPoint.x //方向
        
        let tempY = fabs(movePoint.y - centerPoint.y)
        let moveYDistance = tempY <= diameter/2 ? tempY : diameter/2
        let toTop = movePoint.y <= centerPoint.y
        
        //圆顺时针ABCD
        let pointA = CGPoint.init(x: rect.origin.x+rect.width/2, y: toTop ? rect.origin.y : rect.origin.y - moveYDistance)
        let pointB = CGPoint.init(x: toLeft ? rect.maxX+movedXDistance : rect.maxX, y: rect.origin.y+rect.height/2)//向左时B的x加长
        
        let pointC = CGPoint.init(x: pointA.x, y: toTop ? rect.maxY + moveYDistance : rect.maxY)
        let pointD = CGPoint.init(x: toLeft ? rect.origin.x : rect.origin.x - movedXDistance, y: pointB.y)//向右时D的x减少
        
        //标记矩形每个点，红色
//        ctx.setFillColor(UIColor.red.cgColor)
//        
//        for point in [pointA,pointB,pointC,pointD] {
//            ctx.fill(CGRect(x: point.x, y: point.y, width: 4, height: 4))
//        }
        
        //辅助点 offset为外框.3.6
        let offset = rect.width/3.6
        let litDistance = movedXDistance/10
        
        let ab = CGPoint(x: pointA.x+offset, y: pointA.y)
        let cb = CGPoint(x: pointC.x + offset, y: pointC.y)
        let cd = CGPoint(x: pointC.x - offset, y: pointC.y)
        let ad = CGPoint(x: pointA.x - offset, y: pointA.y)
        
        
        let ba = CGPoint(x: pointB.x, y: toLeft ? pointB.y - offset + litDistance : pointB.y - offset)
        //向左时ba的y增加一点,最大1/8长度到B点,设为1/10
        
        let bc = CGPoint(x: pointB.x, y: toLeft ? pointB.y + offset - litDistance : pointB.y + offset)
        
        let dc = CGPoint(x: pointD.x, y: toLeft ? pointD.y + offset : pointD.y + offset - litDistance)
        
        let da = CGPoint(x: pointD.x, y: toLeft ? pointD.y - offset : pointD.y - offset + litDistance)
        
        
        //标记辅助点 蓝色
//        ctx.setFillColor(UIColor.blue.cgColor)
//        
//        for point in [ab,ba,bc,cb,cd,dc,da,ad] {
//            ctx.fill(CGRect(x: point.x, y: point.y, width: 4, height: 4))
//        }
        
        
        //画圆
        
        let ovalPath = UIBezierPath()
        ovalPath.move(to: pointA)
        ovalPath.addCurve(to: pointB, controlPoint1: ab, controlPoint2: ba)
        ovalPath.addCurve(to: pointC, controlPoint1: bc, controlPoint2: cb)
        ovalPath.addCurve(to: pointD, controlPoint1: cd, controlPoint2: dc)
        ovalPath.addCurve(to: pointA, controlPoint1: da, controlPoint2: ad)
        ovalPath.close()
        
        ctx.setFillColor(UIColor.magenta.cgColor)
        ctx.setStrokeColor(UIColor.white.cgColor)
        ctx.addPath(ovalPath.cgPath)
        //ctx.setLineDash(phase: 0, lengths: [1]) //取消虚线
        
        ctx.drawPath(using: .fillStroke)
        
    }
}
