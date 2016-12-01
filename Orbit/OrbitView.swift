//
//  OrbitView.swift
//  Orbit
//
//  Created by Lijie on 16/9/20.
//  Copyright © 2016年 HuatengIOT. All rights reserved.
//

import UIKit
//import Foundation

class OrbitView: UIView {
    
    fileprivate var displayLink: CADisplayLink? // 定时器
    fileprivate var starView: UIView? // 主行星
    fileprivate var satelliteAB: UIView?
    fileprivate var satelliteCD: UIView?
    fileprivate var axisLineAB: Array<CGPoint>?
    fileprivate var axisLineCD: Array<CGPoint>?
    
    fileprivate weak var starLayer: CAShapeLayer?
    fileprivate weak var sateABLayer: CAShapeLayer?
    fileprivate weak var sateCDLayer: CAShapeLayer?
    
    fileprivate var angle = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initilize()
    }
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        if let link = self.displayLink {
            aCoder.encode(link, forKey: "displayLink")
        }
        if let star = self.starView {
            aCoder.encode(star, forKey: "starView")
        }
        if let ab = self.satelliteAB {
            aCoder.encode(ab, forKey: "satelliteAB")
        }
        if let cd = self.satelliteCD {
            aCoder.encode(cd, forKey: "satelliteCD")
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.displayLink = aDecoder.decodeObject(forKey: "displayLink") as? CADisplayLink
        self.starView = aDecoder.decodeObject(forKey: "starView") as? UIView
        self.satelliteAB = aDecoder.decodeObject(forKey: "satelliteAB") as? UIView
        self.satelliteCD = aDecoder.decodeObject(forKey: "satelliteCD") as? UIView
        self.axisLineAB = aDecoder.decodeObject(forKey: "axisLineAB") as? Array<CGPoint>
        self.axisLineCD = aDecoder.decodeObject(forKey: "axisLineCD") as? Array<CGPoint>
        self.initilize()
    }
    fileprivate func initilize() {
        let f = self.frame
        let o = self.center
        let b = self.bounds

        assert(b.width >= 120 && b.height >= 120, "frame too small...")
        
        self.axisLineAB = [CGPoint(x: f.minX, y: o.y),CGPoint(x: f.maxX, y: o.y)]
        self.axisLineCD = [CGPoint(x: o.x, y: f.minY),CGPoint(x: o.x, y: f.maxY)]
        
        self.backgroundColor = UIColor.lightGray
        
        if self.starView == nil {
            self.starLayer = self.circleShapeLayer(60.0)
            self.starView = UIView(frame: CGRect(x: b.width / 2.0 - 60, y: b.height / 2.0 - 60, width: 120, height: 120))
            self.starView?.backgroundColor = UIColor.clear
            self.starView?.layer.addSublayer(self.starLayer!)
            self.addSubview(starView!)
        }
        if self.satelliteAB == nil {
            self.sateABLayer = self.circleShapeLayer(90.0)
            self.satelliteAB = UIView(frame: CGRect(x: b.width / 2.0 - 90, y: b.height / 2.0 - 90, width: 180, height: 180))
            self.satelliteAB?.backgroundColor = UIColor.clear
            self.satelliteAB?.layer.addSublayer(self.sateABLayer!)
            self.addSubview(satelliteAB!)
        }
        if self.satelliteCD == nil {
            self.sateCDLayer = self.circleShapeLayer(90.0)
            self.satelliteCD = UIView(frame: CGRect(x: b.width / 2.0 - 90, y: b.height / 2.0 - 90, width: 180, height: 180))
            self.satelliteCD?.layer.addSublayer(self.sateCDLayer!)
            self.addSubview(satelliteCD!)
        }
        self.animateStarView()
        self.animateSatelliteAB()
        self.animateSatelliteCD()
    }
    
    //
    
    fileprivate func startDisplayLink() {
        if let _ = self.displayLink {
            self.stopDisplayLink()
        }
        self.displayLink = CADisplayLink(target: self, selector: #selector(OrbitView.fireDisplayLink))
        self.displayLink?.frameInterval = 5
        self.displayLink?.add(to: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
    }
    fileprivate func pauseDisplayLink() {
        if let link = self.displayLink {
            link.isPaused = true
        }
    }
    fileprivate func stopDisplayLink() {
        if let link = self.displayLink {
            link.invalidate()
            self.displayLink = nil
        }
    }
    
    func fireDisplayLink() {
        angle = (angle + 1) % 10
//        let ang = CGFloat(angle) / 10.0
//        let fromValue = CATransform3DMakeRotation(0, ang, 0, 0)
//        let toValue = CATransform3DMakeRotation(CGFloat(M_PI), 1, 1, 0)
//        self.sateABLayer?.transform = fromValue
        
    }
    
    //
    
    fileprivate func circleShapeLayer(_ radius: CGFloat) -> CAShapeLayer {
        let cpoint = CGPoint(x: radius, y: radius)
        let cpath = UIBezierPath(arcCenter: cpoint, radius: radius, startAngle: 0, endAngle: 2 * CGFloat(M_PI), clockwise: true)
        let circle = CAShapeLayer()
        circle.path = cpath.cgPath
        circle.fillColor = UIColor.clear.cgColor
        circle.strokeColor = UIColor.darkGray.cgColor
        circle.lineWidth = 1.0
        circle.strokeStart = 0
        circle.strokeEnd = 2 * CGFloat(M_PI)
        return circle
    }
    
    //
    
    fileprivate func animateStarView() {
        let endanimate = CABasicAnimation(keyPath: "strokeEnd")
        endanimate.fromValue = 0
        endanimate.toValue = 1
        endanimate.duration = 4
        endanimate.repeatCount = MAXFLOAT
        endanimate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        self.starLayer?.add(endanimate, forKey: "star_strokeEnd")
        
        let startanimate = CABasicAnimation(keyPath: "strokeStart")
        startanimate.fromValue = 0
        startanimate.toValue = 1
        startanimate.duration = 4
        startanimate.repeatCount = MAXFLOAT
        startanimate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        self.starLayer?.add(startanimate, forKey: "star_strokeStart")
    }
    
    fileprivate func animateSatelliteAB() {
        let rotationX = CABasicAnimation(keyPath: "transform.rotation.x")
        rotationX.fromValue = -CGFloat(M_PI_2)
        rotationX.toValue = CGFloat(M_PI_2)
        rotationX.repeatCount = MAXFLOAT
        rotationX.duration = 5
        rotationX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        self.satelliteAB?.layer.add(rotationX, forKey: "sateAB_x")
        
        let animateZ = CABasicAnimation(keyPath: "transform.rotation.z")
        animateZ.fromValue = -CGFloat(M_PI) * 30.0 / 180
        animateZ.toValue = CGFloat(M_PI) * 30.0 / 180
        animateZ.repeatCount = MAXFLOAT
        animateZ.duration = 5
        animateZ.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.satelliteAB?.layer.add(animateZ, forKey: "sateAB_z")
        
        let animateY = CABasicAnimation(keyPath: "transform.rotation.y")
        animateY.fromValue = -CGFloat(M_PI) * 30.0 / 180
        animateY.toValue = CGFloat(M_PI) * 30.0 / 180
        animateY.repeatCount = MAXFLOAT
        animateY.duration = 5
        animateY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.satelliteAB?.layer.add(animateY, forKey: "sateAB_y")
    }
    
    fileprivate func animateSatelliteCD() {
        let rotationY = CABasicAnimation(keyPath: "transform.rotation.y")
        rotationY.fromValue = CGFloat(M_PI_2) * 90.0 / 180
        rotationY.toValue = CGFloat(M_PI_2) * 120.0 / 180
        rotationY.repeatCount = MAXFLOAT
        rotationY.autoreverses = true
        rotationY.duration = 7
        rotationY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.satelliteCD?.layer.add(rotationY, forKey: "sateCD_y")
        
        let rotationZ = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationZ.fromValue = -CGFloat(M_PI) * 20.0 / 180
        rotationZ.toValue = CGFloat(M_PI) * 20.0 / 180
        rotationZ.repeatCount = MAXFLOAT
        rotationZ.autoreverses = true
        rotationZ.duration = 7
        rotationZ.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.satelliteCD?.layer.add(rotationZ, forKey: "sateCD_z")
        
        let rotationX = CABasicAnimation(keyPath: "transform.rotation.x")
        rotationX.fromValue = -CGFloat(M_PI) * 20.0 / 180
        rotationX.toValue = CGFloat(M_PI) * 20.0 / 180
        rotationX.repeatCount = MAXFLOAT
        rotationX.autoreverses = true
        rotationX.duration = 7
        rotationX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.satelliteCD?.layer.add(rotationX, forKey: "sateCD_x")
    }
}
