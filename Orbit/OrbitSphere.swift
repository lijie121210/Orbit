//
//  OrbitSphere.swift
//  Orbit
//
//  Created by jie on 2016/12/8.
//  Copyright © 2016年 HuatengIOT. All rights reserved.
//

import UIKit

class OrbitSphere3D {
    var orbitPoint: OrbitPoint?
    var view: UIView
    
    init(_ vi: UIView) {
        view = vi
    }
    init(_ vi: UIView, at center: CGPoint) {
        view = vi
        view.center = center
    }
}

public class OrbitSphere: UIView {
    
    var elements: [OrbitSphere3D]
    private var defaultVector: OrbitPoint
    private var timer: CADisplayLink!
    private var inertiaTimer: CADisplayLink!
    private var velocity: CGFloat
    
    public override init(frame: CGRect) {
        let x = Int(arc4random()) % 10 - 5
        let y = Int(arc4random()) % 10 - 5
        defaultVector = OrbitPoint(x: CGFloat(x), y: CGFloat(y), z: 0)
        elements = []
        velocity = 4.0
        
        super.init(frame: frame)
        
        timer = CADisplayLink(target: self, selector: #selector(OrbitSphere.turnRotation))
        timer.add(to: .main, forMode: .defaultRunLoopMode)
        timer.isPaused = true
        
        inertiaTimer = CADisplayLink(target: self, selector: #selector(OrbitSphere.inertiaRotation))
        inertiaTimer.add(to: .main, forMode: .defaultRunLoopMode)
        inertiaTimer.isPaused = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     * Timer's method
     */
    func turnRotation() {
        guard elements.count > 0 else {
            return
        }
        var angle: CGFloat = 0.01
        if velocity > 0 {
            angle = velocity / bounds.width * 2.0
        }
        for obv in elements {
            updateView(obv, by: angle, about: defaultVector)
        }
    }
    
    func inertiaRotation() {
        // todo
    }
    
    /* api
     * @discussion
     * @param eles A set of UIView u want to be dispersed
     */
    public func disperse(views eles: [UIView], withRotationVelocity vel: CGFloat = 0.0) {
        
        func setElements(_ eles: [UIView]) {
            elements.removeAll()
            
            let cent: CGPoint = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)
            
            for vi in eles {
                addSubview(vi)
                
                elements.append( OrbitSphere3D(vi, at: cent) )
            }
        }
        
        func scatterToSphere(_ index: Int, of count: Int) -> OrbitPoint {
            let i = CGFloat(index)
            let p1 = CGFloat( M_PI * ( 3 - sqrt(5) ) )
            let p2 = CGFloat( 2.0 / CGFloat(count) )
            let y = i * p2 - 1.0 + p2 * 0.5
            let r = CGFloat( sqrt( 1 - y * y ) )
            let w = i * p1
            let x = cos(w) * r
            let z = sin(w) * r
            let p = OrbitPoint(x: x, y: y, z: z)
            return p
        }
        
        func animateTransform(with obv: OrbitSphere3D) {
            guard let point = obv.orbitPoint else {
                return
            }
            let view = obv.view
            let duration = ( Double( arc4random() % 10 ) + 10.0 ) / 20.0
            let animation = { () -> Void in
                self.transform(view, to: point)
            }
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: animation, completion: nil)
        }
        
        /*********/
        
        guard eles.count > 0 else {
            return
        }
        if vel > 0.0 {
            velocity = vel
        }
        setElements(eles)
        
        let count = elements.count
        
        for i in 0..<count {
            let obv = elements[i]
            obv.orbitPoint = scatterToSphere(i, of: count)
            animateTransform(with: obv)
        }
        
        timer.isPaused = false
    }
    
    /*
     * Help method
     */
    
    /*
     * @param view The view needs to be changed
     * @param point Resets the view's characteristics based on this coordinate
     */
    fileprivate func transform(_ view: UIView, to point: OrbitPoint) {
        let cx = (point.x + 1.0) * bounds.width * 0.5
        let cy = (point.y + 1.0) * bounds.height * 0.5
        let ts = (point.z + 2.0) / 3.0
        
        view.center = CGPoint(x: cx, y: cy)
        view.transform = CGAffineTransform.identity.scaledBy(x: ts, y: ts)
        view.layer.zPosition = ts
        view.alpha = ts
        view.isUserInteractionEnabled = (point.z >= 0)
    }
    
    /*
     * @discussion This method will calculate new position of obv, update this obv, and update obv.view.
     It will rotate obv.point by 'angle' radians about vector
     */
    fileprivate func updateView(_ obv: OrbitSphere3D, by angle: CGFloat, about vector: OrbitPoint) {
        guard let point = obv.orbitPoint else {
            return
        }
        let newPoint = point.rotated(by: angle, about: vector)
        
        obv.orbitPoint = newPoint
        
        transform(obv.view, to: newPoint)
    }
}
