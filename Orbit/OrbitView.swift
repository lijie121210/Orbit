//
//  OrbitView.swift
//  Orbit
//
//  Created by jie on 2016/12/7.
//  Copyright © 2016年 HuatengIOT. All rights reserved.
//

import UIKit


public extension CABasicAnimation {
    
    public convenience init(keyPath: String, from: CGFloat, to: CGFloat,
                            repeatCount: Float,
                            duration: CFTimeInterval,
                            timingFunction name: String,
                            autoreverses: Bool) {
        
        self.init(keyPath: keyPath)
        self.fromValue = from
        self.toValue = to
        self.repeatCount = repeatCount
        self.duration = duration
        self.autoreverses = autoreverses
        self.timingFunction = CAMediaTimingFunction(name: name)
    }
    
}

class OrbitView: UIView {
    
}

extension OrbitView {
    
    enum AnimKey: String {
        
        enum rotation: String {
            case x = "transform.rotation.x"
            case y = "transform.rotation.y"
            case z = "transform.rotation.z"
        }
        
        case strokeStart = "strokeStart"
        
        case strokeEnd = "strokeEnd"
    }
    
    struct Tailor {
        
        var baseSize: CGSize
        
        var shortLength: CGFloat {
            return (baseSize.width > baseSize.height) ? baseSize.height : baseSize.width
        }
        
        /// 计算背景圆参数
        var radiusOfCircle: CGFloat {
            return shortLength.divided(by: 3.0)
        }
        var xdistanceOfCircle: CGFloat {
            return (baseSize.width - radiusOfCircle * 2.0).divided(by: 2.0)
        }
        var ydistanceOfCircle: CGFloat {
            return (baseSize.height - radiusOfCircle * 2).divided(by: 2.0)
        }
        var widthOfCircle: CGFloat {
            return radiusOfCircle.multiplied(by: 2.0)
        }
        
        /// 计算环参数
        var spaceToRing: CGFloat {
            return shortLength.divided(by: 6.0).multiplied(by: 0.2)
        }
        var widthOfRing: CGFloat {
            return (radiusOfCircle + spaceToRing).multiplied(by: 2.0)
        }
        var xdistanceOfRing: CGFloat {
            return (baseSize.width - widthOfRing).divided(by: 2.0)
        }
        var ydistanceOfRing: CGFloat {
            return (baseSize.height - widthOfRing).divided(by: 2.0)
        }
        
        /// 计算点参数
        var spaceToStar: CGFloat {
            return shortLength.divided(by: 6.0).multiplied(by: 0.8)
        }
        var widthOfStar: CGFloat {
            return (radiusOfCircle + spaceToStar).multiplied(by: 2.0)
        }
        var xdistanceOfStar: CGFloat {
            return (baseSize.width - widthOfStar).divided(by: 2.0)
        }
        var ydistanceOfStar: CGFloat {
            return (baseSize.height - widthOfStar).divided(by: 2.0)
        }
        
        
        init(baseSize: CGSize) {
            
            self.baseSize = baseSize
            
            if baseSize.width < 60.0 || baseSize.height < 60.0 {
                print(self, #function, "maybe frame is too small")
            }
        }
        
    }
    
    /// 创建基础动画
    func animation(keyPath: String, from: CGFloat, to: CGFloat, repeatCount: Float, duration: CFTimeInterval,
                   timingFunction name: String, autoreverses: Bool) -> CABasicAnimation {
        
        return CABasicAnimation(keyPath: keyPath, from: from, to: to,
                                repeatCount: repeatCount,duration: duration, timingFunction: name, autoreverses: autoreverses)
    }
    
    /// 透视效果
    func perspective(on view: UIView, with value: CGFloat = 0.003) {
        var t = CATransform3DIdentity
        t.m34 = value
        view.layer.sublayerTransform = t
    }
    
    /// Crescent-like shadows
    func crescentShapeLayer(radius: CGFloat, fillColor: UIColor = UIColor(white: 0.96, alpha: 1)) -> CAShapeLayer {
        
        let path = UIBezierPath(arcCenter: CGPoint(x: radius, y: radius),
                                  radius: radius - 2.0,
                                  startAngle: CGFloat.pi.divided(by: -2.0),
                                  endAngle: CGFloat.pi.divided(by: 2.0),
                                  clockwise: true)
        
        let tpoint = CGPoint(x: radius, y: 2)
        path.addCurve(to: tpoint, controlPoint1: CGPoint(x: radius * 1.8, y: radius), controlPoint2: tpoint)
        path.close()
        
        let crescent = CAShapeLayer()
        crescent.path = path.cgPath
        crescent.fillRule = kCAFillRuleNonZero
        crescent.fillMode = kCAFillModeForwards
        crescent.fillColor = fillColor.cgColor
        
        return crescent
    }
    
    func backgroundCircle(tailor: Tailor) -> UIView {
        let vi = UIView(frame: CGRect(x: tailor.xdistanceOfCircle,
                                      y: tailor.ydistanceOfCircle,
                                      width: tailor.widthOfCircle,
                                      height: tailor.widthOfCircle))
        vi.backgroundColor = UIColor(white: 0.99, alpha: 1)
        vi.layer.cornerRadius = tailor.radiusOfCircle
        vi.layer.borderColor = UIColor.black.cgColor
        vi.layer.borderWidth = 2.0
        return vi
    }
    
    func ring(tailor: Tailor) -> UIView {
        let width = tailor.widthOfRing
        let ring = UIView(frame: CGRect(x: tailor.xdistanceOfRing, y: tailor.ydistanceOfRing, width: width, height: width))
        ring.layer.cornerRadius = width.divided(by: 2.0)
        return ring
    }
    
    func star(tailor: Tailor) -> UIView {
        let width = tailor.widthOfStar
        let star = UIView(frame: CGRect(x: tailor.xdistanceOfStar, y: tailor.ydistanceOfStar, width: width, height: width))
        star.layer.cornerRadius = width.divided(by: 2.0)
        return star
    }
    
    func launchOrbit() {
    
        let view = self
        
        perspective(on: self)
        
        // todo: using func
        // todo: recalculate radius based on fram
        
        let tailor = Tailor(baseSize: frame.size)
        
        
        let radius: CGFloat = 100.0
        let offset: CGFloat = 10.0
        let poffset: CGFloat = 40.0
        
        /// 创建两个200x200的矩形，并剪裁成圆, 
        /// 背景圆
        
        let crescent = crescentShapeLayer(radius: tailor.radiusOfCircle)
        let vi = backgroundCircle(tailor: tailor)
        vi.layer.addSublayer(crescent)
        view.addSubview(vi)
        
        /// 创建两个大环的父视图
        let vx = ring(tailor: tailor)
        let vy = ring(tailor: tailor)
        
        view.addSubview(vx)
        view.addSubview(vy)
        
        /// 创建两个点的父视图
        let vp = star(tailor: tailor)
        let vp2 = star(tailor: tailor)

        view.addSubview(vp)
        view.addSubview(vp2)
        
        
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
        let vxrx = animation(keyPath: AnimKey.rotation.x.rawValue, from: CGFloat.pi.divided(by: 2.0), to: CGFloat.pi.divided(by: -2.0), repeatCount: Float.greatestFiniteMagnitude, duration: 6.0, timingFunction: kCAMediaTimingFunctionLinear, autoreverses: false)
        
        vx.layer.add(vxrx, forKey: "vxx")
        
        let vxrz = animation(keyPath: AnimKey.rotation.z.rawValue, from: CGFloat.pi.divided(by: -6.0), to: CGFloat.pi.divided(by: 6.0), repeatCount: Float.greatestFiniteMagnitude, duration: 6.0, timingFunction: kCAMediaTimingFunctionLinear, autoreverses: true)

        vx.layer.add(vxrz, forKey: "vxz")
        
        /*
         * The rotation of the circle in the vertical direction
         */
        let vyry = animation(keyPath: AnimKey.rotation.y.rawValue, from: CGFloat.pi.multiplied(by: 3.0).divided(by: 8.0), to: CGFloat.pi.multiplied(by: 5.0).divided(by: 8.0), repeatCount: Float.greatestFiniteMagnitude, duration: 4.0, timingFunction: kCAMediaTimingFunctionEaseInEaseOut, autoreverses: true)

        vy.layer.add(vyry, forKey: "vyy")
        
        let vyrz = animation(keyPath: AnimKey.rotation.z.rawValue, from: CGFloat.pi.divided(by: -12.0), to: CGFloat.pi.divided(by: 12.0), repeatCount: Float.greatestFiniteMagnitude, duration: 4.0, timingFunction: kCAMediaTimingFunctionEaseInEaseOut, autoreverses: true)
        
        vy.layer.add(vyrz, forKey: "vyz")
        
        /*
         * change to Point
         */
        let circleStroke = animation(keyPath: AnimKey.strokeStart.rawValue, from: 0, to: 1, repeatCount: Float.greatestFiniteMagnitude, duration: 2, timingFunction: kCAMediaTimingFunctionLinear, autoreverses: false)
        
        cpcircle.add(circleStroke, forKey: "star_strokeStart")
        cpcircle2.add(circleStroke, forKey: "star_strokeStart2")
        
        let circleStrokeEnd = animation(keyPath: AnimKey.strokeEnd.rawValue, from: 0.008, to: 1.008, repeatCount: Float.greatestFiniteMagnitude, duration: 2, timingFunction: kCAMediaTimingFunctionLinear, autoreverses: false)
        
        cpcircle.add(circleStrokeEnd, forKey: "star_strokeEnd")
        cpcircle2.add(circleStrokeEnd, forKey: "star_strokeEnd2")
        
        /*
         * Point rotation
         */
        let vpz = animation(keyPath: AnimKey.rotation.z.rawValue, from: 0.0, to: CGFloat.pi.multiplied(by: 2.0), repeatCount: Float.greatestFiniteMagnitude, duration: 8.0, timingFunction: kCAMediaTimingFunctionLinear, autoreverses: false)
        
        vp.layer.add(vpz, forKey: "vpz")
        vp2.layer.add(vpz, forKey: "vpz2")
        
        let vpx = animation(keyPath: AnimKey.rotation.x.rawValue, from: CGFloat.pi.divided(by: 4.0).adding(-0.0001), to: CGFloat.pi.divided(by: 4.0).adding(0.0001), repeatCount: Float.greatestFiniteMagnitude, duration: 8.0, timingFunction: kCAMediaTimingFunctionLinear, autoreverses: true)
        
        vp.layer.add(vpx, forKey: "vpx")
        
        let vpy = animation(keyPath: AnimKey.rotation.y.rawValue, from: CGFloat.pi.divided(by: 4.0).multiplied(by: 3.0).adding(-0.0001), to: CGFloat.pi.divided(by: 4.0).multiplied(by: 3.0).adding(0.0001), repeatCount: Float.greatestFiniteMagnitude, duration: 8.0, timingFunction: kCAMediaTimingFunctionLinear, autoreverses: true)
        
        vp2.layer.add(vpy, forKey: "vpy")
        
    }
}
