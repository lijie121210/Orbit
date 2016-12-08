//
//  OrbitView.swift
//  Orbit
//
//  Created by jie on 2016/12/7.
//  Copyright © 2016年 HuatengIOT. All rights reserved.
//

import UIKit


class OrbitView: UIView {
    
}

extension OrbitView {
    
    func launchOrbit() {
        let view = self
        
        func perspective(on view: UIView, with value: CGFloat = 0.003) {
            var t = CATransform3DIdentity
            t.m34 = value
            view.layer.sublayerTransform = t
        }
        
        perspective(on: self)
        
        // todo: using func
        // todo: recalculate radius based on fram
        
        let radius: CGFloat = 100.0
        let dradius: CGFloat = radius * 2.0
        let offset: CGFloat = 10.0
        let doffset: CGFloat = offset * 2.0
        let poffset: CGFloat = 40.0
        let dpoffset: CGFloat = poffset * 2.0
        let disX = (view.bounds.width - 200) / 2.0
        let disY = (view.bounds.height - 200) / 2.0
        
        let vi = UIView(frame: CGRect(x: disX, y: disY, width: dradius, height: dradius))
        vi.layer.cornerRadius = radius
        view.addSubview(vi)
        
        let vr = UIView(frame: CGRect(x: disX, y: disY, width: dradius, height: dradius))
        vr.layer.cornerRadius = radius
        view.addSubview(vr)
        
        let vx = UIView(frame: CGRect(x: disX - offset, y: disY - offset, width: dradius + doffset, height: dradius + doffset))
        vx.layer.cornerRadius = radius + offset
        view.addSubview(vx)
        
        let vy = UIView(frame: CGRect(x: disX - offset, y: disY - offset, width: dradius + doffset, height: dradius + doffset))
        vy.layer.cornerRadius = radius + offset
        view.addSubview(vy)
        
        let vp = UIView(frame: CGRect(x: disX - poffset, y: disY - poffset, width: dradius + dpoffset, height: dradius + dpoffset))
        vp.layer.cornerRadius = radius + poffset
        view.addSubview(vp)
        
        let vp2 = UIView(frame: CGRect(x: disX - poffset, y: disY - poffset, width: dradius + dpoffset, height: dradius + dpoffset))
        vp2.layer.cornerRadius = radius + poffset
        view.addSubview(vp2)
        
        /*
         * Static circle
         */
        let cpoint = CGPoint(x: radius, y: radius)
        let cpath = UIBezierPath(arcCenter: cpoint, radius: radius, startAngle: 0, endAngle: 2 * CGFloat(M_PI), clockwise: true)
        let circle = CAShapeLayer()
        circle.path = cpath.cgPath
        circle.fillColor = UIColor.clear.cgColor
        circle.strokeColor = UIColor.black.cgColor
        circle.lineWidth = 2.0
        vi.layer.addSublayer(circle)
        
        /*
         * Shadow of the static circle
         */
        let cr2point = CGPoint(x: radius, y: radius)
        let sr2angle = CGFloat(0)
        let er2angle = CGFloat(M_PI * 2.0)
        let cr2path = UIBezierPath(arcCenter: cr2point, radius: radius - 2.0, startAngle: sr2angle, endAngle: er2angle, clockwise: true)
        let cr2circle = CAShapeLayer()
        cr2circle.path = cr2path.cgPath
        cr2circle.fillRule = kCAFillRuleNonZero
        cr2circle.fillMode = kCAFillModeForwards
        cr2circle.fillColor = UIColor(white: 0.98, alpha: 1).cgColor
        vr.layer.addSublayer(cr2circle)
        
        let crpoint = CGPoint(x: radius, y: radius)
        let srangle = CGFloat(-M_PI_2)
        let erangle = CGFloat(M_PI_2)
        let crpath = UIBezierPath(arcCenter: crpoint, radius: radius - 2.0, startAngle: srangle, endAngle: erangle, clockwise: true)
        let tpoint = CGPoint(x: radius, y: 2)
        let ctpoint = CGPoint(x: radius * 1.8, y: radius)
        crpath.addCurve(to: tpoint, controlPoint1: ctpoint, controlPoint2: tpoint)
        crpath.close()
        
        let crcircle = CAShapeLayer()
        crcircle.path = crpath.cgPath
        crcircle.fillRule = kCAFillRuleNonZero
        crcircle.fillMode = kCAFillModeForwards
        crcircle.fillColor = UIColor(white: 0.96, alpha: 1).cgColor
        vr.layer.addSublayer(crcircle)
        
        /*
         * Circle of the horizontal direction
         */
        let cxpoint = CGPoint(x: radius + offset, y: radius + offset)
        let sxangle = CGFloat(0)
        let exangle = CGFloat(M_PI * 2.0)
        let cxpath = UIBezierPath(arcCenter: cxpoint, radius: radius + offset, startAngle: sxangle, endAngle: exangle, clockwise: false)
        let cxcircle = CAShapeLayer()
        cxcircle.path = cxpath.cgPath
        cxcircle.fillColor = UIColor.clear.cgColor
        cxcircle.strokeColor = UIColor.black.cgColor
        cxcircle.lineWidth = 1.0
        vx.layer.addSublayer(cxcircle)
        
        /*
         * Circle of the vertical direction
         */
        let cypoint = CGPoint(x: radius + offset, y: radius + offset)
        let syangle = CGFloat(0.0)
        let eyangle = CGFloat(M_PI * 2.0)
        let cypath = UIBezierPath(arcCenter: cypoint, radius: radius + offset, startAngle: syangle, endAngle: eyangle, clockwise: true)
        let cycircle = CAShapeLayer()
        cycircle.path = cypath.cgPath
        cycircle.fillColor = UIColor.clear.cgColor
        cycircle.strokeColor = UIColor.black.cgColor
        cycircle.lineWidth = 1.0
        vy.layer.addSublayer(cycircle)
        
        
        /*
         * Point
         */
        let cppoint = CGPoint(x: radius + poffset, y: radius + poffset)
        let spangle = CGFloat(0.0)
        let epangle = CGFloat(M_PI * 2.0)
        let cppath = UIBezierPath(arcCenter: cppoint, radius: radius + poffset, startAngle: spangle, endAngle: epangle, clockwise: true)
        let cpcircle = CAShapeLayer()
        cpcircle.path = cppath.cgPath
        cpcircle.fillColor = UIColor.clear.cgColor
        cpcircle.strokeColor = UIColor.black.cgColor
        cpcircle.lineWidth = 4.0
        vp.layer.addSublayer(cpcircle)
        
        let cppoint2 = CGPoint(x: radius + poffset, y: radius + poffset)
        let spangle2 = CGFloat(0.0)
        let epangle2 = CGFloat(M_PI * 2.0)
        let cppath2 = UIBezierPath(arcCenter: cppoint2, radius: radius + poffset, startAngle: spangle2, endAngle: epangle2, clockwise: true)
        let cpcircle2 = CAShapeLayer()
        cpcircle2.path = cppath2.cgPath
        cpcircle2.fillColor = UIColor.clear.cgColor
        cpcircle2.strokeColor = UIColor.black.cgColor
        cpcircle2.lineWidth = 4.0
        vp2.layer.addSublayer(cpcircle2)
        
        /* Animation */
        
        
        /*
         * The rotation of the circle in the horizontal direction
         */
        let rotationXX = CABasicAnimation(keyPath: "transform.rotation.x")
        rotationXX.fromValue = CGFloat(M_PI_2)
        rotationXX.toValue = CGFloat(-M_PI_2)
        rotationXX.repeatCount = MAXFLOAT
        rotationXX.duration = 6.0
        rotationXX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        vx.layer.add(rotationXX, forKey: "vxx")
        
        let rotationXZ = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationXZ.fromValue = CGFloat(-M_PI / 6.0)
        rotationXZ.toValue = CGFloat(M_PI / 6.0)
        rotationXZ.repeatCount = MAXFLOAT
        rotationXZ.duration = 6.0
        rotationXZ.autoreverses = true
        rotationXZ.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        vx.layer.add(rotationXZ, forKey: "vxz")
        
        /*
         * The rotation of the circle in the vertical direction
         */
        let rotationYY = CABasicAnimation(keyPath: "transform.rotation.y")
        rotationYY.fromValue = CGFloat(M_PI * 3.0 / 8.0)
        rotationYY.toValue = CGFloat(M_PI * 5.0 / 8.0)
        rotationYY.repeatCount = MAXFLOAT
        rotationYY.duration = 4.0
        rotationYY.autoreverses = true
        rotationYY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        vy.layer.add(rotationYY, forKey: "vyy")
        
        let rotationYZ = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationYZ.fromValue = CGFloat(-M_PI / 12.0)
        rotationYZ.toValue = CGFloat(M_PI / 12.0)
        rotationYZ.repeatCount = MAXFLOAT
        rotationYZ.autoreverses = true
        rotationYZ.duration = 4.0
        rotationYZ.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        vy.layer.add(rotationYZ, forKey: "vyz")
        
        /*
         * change to Point
         */
        let startanimate = CABasicAnimation(keyPath: "strokeStart")
        startanimate.fromValue = 0
        startanimate.toValue = 1
        startanimate.duration = 2
        startanimate.repeatCount = MAXFLOAT
        startanimate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        cpcircle.add(startanimate, forKey: "star_strokeStart")
        cpcircle2.add(startanimate, forKey: "star_strokeStart2")
        
        let endanimate = CABasicAnimation(keyPath: "strokeEnd")
        endanimate.fromValue = 0.008
        endanimate.toValue = 1.008
        endanimate.duration = 2
        endanimate.repeatCount = MAXFLOAT
        endanimate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        cpcircle.add(endanimate, forKey: "star_strokeEnd")
        cpcircle2.add(endanimate, forKey: "star_strokeEnd2")
        
        /*
         * Point rotation
         */
        let rotationPZ = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationPZ.fromValue = CGFloat(0.0)
        rotationPZ.toValue = CGFloat(M_PI * 2.0)
        rotationPZ.repeatCount = MAXFLOAT
        rotationPZ.duration = 8.0;
        rotationPZ.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        vp.layer.add(rotationPZ, forKey: "vpz")
        vp2.layer.add(rotationPZ, forKey: "vpz2")
        
        let rotationPX = CABasicAnimation(keyPath: "transform.rotation.x")
        rotationPX.fromValue = CGFloat(M_PI_4 - 0.0001)
        rotationPX.toValue = CGFloat(M_PI_4 + 0.0001)
        rotationPX.repeatCount = MAXFLOAT
        rotationPX.autoreverses = true
        rotationPX.duration = 8.0
        rotationPX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        vp.layer.add(rotationPX, forKey: "vpx")
        
        let rotationPY = CABasicAnimation(keyPath: "transform.rotation.y")
        rotationPY.fromValue = CGFloat(M_PI_4 * 3.0 - 0.0001)
        rotationPY.toValue = CGFloat(M_PI_4 * 3.0 + 0.0001)
        rotationPY.repeatCount = MAXFLOAT
        rotationPY.autoreverses = true
        rotationPY.duration = 8.0
        rotationPY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        vp2.layer.add(rotationPY, forKey: "vpy")
        
        
    }
}
