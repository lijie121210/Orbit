//
//  OrbitViewController.swift
//  Orbit
//
//  Created by Lijie on 16/9/20.
//  Copyright © 2016年 HuatengIOT. All rights reserved.
//

import UIKit

class OrbitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let disX = (view.bounds.width - 200) / 2.0
        let disY = (view.bounds.height - 200) / 2.0
        
        let vi = UIView(frame: CGRect(x: disX, y: disY, width: 200.0, height: 200.0))
        vi.layer.cornerRadius = 100.0
        view.addSubview(vi)
        
        let vx = UIView(frame: CGRect(x: disX - 20.0, y: disY - 20.0, width: 200.0 + 40.0, height: 200.0 + 40.0))
        vx.layer.cornerRadius = 100.0 + 20.0
        view.addSubview(vx)
        
        let vy = UIView(frame: CGRect(x: disX - 20.0, y: disY - 20.0, width: 200.0 + 40.0, height: 200.0 + 40.0))
        vy.layer.cornerRadius = 100.0 + 20.0
        view.addSubview(vy)
        
        let cpoint = CGPoint(x: 100, y: 100)
        let cpath = UIBezierPath(arcCenter: cpoint, radius: 100, startAngle: 0, endAngle: 2 * CGFloat(M_PI), clockwise: true)
        let circle = CAShapeLayer()
        circle.path = cpath.cgPath
        circle.fillColor = UIColor.clear.cgColor
        circle.strokeColor = UIColor.black.cgColor
        circle.lineWidth = 2.0
        circle.strokeStart = 0
        circle.strokeEnd = 2 * CGFloat(M_PI)
        vi.layer.addSublayer(circle)
        
        
        let cxpoint = CGPoint(x: 100.0 + 20.0, y: 100.0 + 20.0)
        let cxpath = UIBezierPath(arcCenter: cxpoint, radius: 100.0 + 20.0, startAngle: 0, endAngle: 2 * CGFloat(M_PI), clockwise: false)
        
        let cxcircle = CAShapeLayer()
        cxcircle.path = cxpath.cgPath
        cxcircle.fillColor = UIColor.clear.cgColor
        cxcircle.strokeColor = UIColor.black.cgColor
        cxcircle.lineWidth = 1.0
        cxcircle.strokeStart = 0
        cxcircle.strokeEnd = CGFloat(M_PI)
        vx.layer.addSublayer(cxcircle)
        
        let cypoint = CGPoint(x: 100.0 + 20.0, y: 100.0 + 20.0)
        let cypath = UIBezierPath(arcCenter: cypoint, radius: 100.0 + 20.0, startAngle: 0, endAngle: 2 * CGFloat(M_PI), clockwise: true)
        
        let cycircle = CAShapeLayer()
        cycircle.path = cypath.cgPath
        cycircle.fillColor = UIColor.clear.cgColor
        cycircle.strokeColor = UIColor.black.cgColor
        cycircle.lineWidth = 1.0
        cycircle.strokeStart = 0
        cycircle.strokeEnd = 2 * CGFloat(M_PI)
        vy.layer.addSublayer(cycircle)
        
        let rotationXX = CABasicAnimation(keyPath: "transform.rotation.x")
        rotationXX.fromValue = -CGFloat(M_PI_2)
        rotationXX.toValue = CGFloat(M_PI_2)
        rotationXX.repeatCount = MAXFLOAT
        rotationXX.duration = 16.0
        rotationXX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        vx.layer.add(rotationXX, forKey: "vxx")
        
        let rotationXZ = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationXZ.fromValue = CGFloat(-M_PI_4 / 2.0)
        rotationXZ.toValue = CGFloat(M_PI_4 / 2.0)
        rotationXZ.repeatCount = MAXFLOAT
        rotationXZ.duration = 8.0
        rotationXZ.autoreverses = true
        rotationXZ.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        vx.layer.add(rotationXZ, forKey: "vxz")
        
        let rotationYY = CABasicAnimation(keyPath: "transform.rotation.y")
        rotationYY.fromValue = CGFloat(M_PI) / 3.0
        rotationYY.toValue = CGFloat(M_PI) * 2.0 / 3.0
        rotationYY.repeatCount = MAXFLOAT
        rotationYY.duration = 8.0
        rotationYY.autoreverses = true
        rotationYY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        vy.layer.add(rotationYY, forKey: "vyy")
        
        let rotationYZ = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationYZ.fromValue = CGFloat(-M_PI / 6.0)
        rotationYZ.toValue = CGFloat(M_PI / 6.0)
        rotationYZ.repeatCount = MAXFLOAT
        rotationYZ.autoreverses = true
        rotationYZ.duration = 8.0
        rotationYZ.timeOffset = 4.0
        rotationYZ.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        vy.layer.add(rotationYZ, forKey: "vyz")
        
        
        
//        vy.layer.transform = CATransform3D(m11: <#T##CGFloat#>, m12: <#T##CGFloat#>, m13: <#T##CGFloat#>, m14: <#T##CGFloat#>, m21: <#T##CGFloat#>, m22: <#T##CGFloat#>, m23: <#T##CGFloat#>, m24: <#T##CGFloat#>, m31: <#T##CGFloat#>, m32: <#T##CGFloat#>, m33: <#T##CGFloat#>, m34: <#T##CGFloat#>, m41: <#T##CGFloat#>, m42: <#T##CGFloat#>, m43: <#T##CGFloat#>, m44: <#T##CGFloat#>)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
