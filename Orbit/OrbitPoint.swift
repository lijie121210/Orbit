//
//  OrbitTransform.swift
//  Orbit
//
//  Created by jie on 2016/12/7.
//  Copyright © 2016年 HuatengIOT. All rights reserved.
//

import Foundation
import QuartzCore

func printt(_ t: CATransform3D) {
    print("")
    print("| ", t.m11, t.m12, t.m13, t.m14, " |")
    print("| ", t.m21, t.m22, t.m23, t.m23, " |")
    print("| ", t.m31, t.m32, t.m33, t.m34, " |")
    print("| ", t.m41, t.m42, t.m43, t.m44, " |")
    print("")
}


public struct OrbitPoint {
    public var x: CGFloat
    public var y: CGFloat
    public var z: CGFloat
    
    public init() {
        x=0.0
        y=0.0
        z=0.0
    }
    public init(x xx: CGFloat, y yy: CGFloat, z zz: CGFloat) {
        x=xx
        y=yy
        z=zz
    }
    
    /*
     * @discussion Real values in the returned matrix are member variables
     * @return Returns a matrix that is padded by zeros
     */
    public func homogeneousMatrix() -> CATransform3D {
        var trans = CATransform3DIdentity
        
        // replace 1.0 with 0.0
        trans.m22 = 0.0
        trans.m33 = 0.0
        trans.m44 = 0.0
        
        // set value to first row of the matrix
        trans.m11 = x
        trans.m12 = y
        trans.m13 = z
        trans.m14 = 1.0
        
        return trans
    }
    
    /*
     * @discussion Only the first row in the matrix is meaningful
     */
    fileprivate func point(from matrix: CATransform3D) -> OrbitPoint {
        let point = OrbitPoint(x: matrix.m11, y: matrix.m12, z: matrix.m13)
        return point
    }
    
    /*
     * Rotate self by 'angle' radians about the vector '(x, y, z)' and return the result, which is the new coordinate.
     * If the vector has zero length the behavior is undefined: t' = rotation(angle, x, y, z) * matix.
     */
    public func rotated(by angle: CGFloat, about vector: OrbitPoint) -> OrbitPoint {
        
        // translate self into a matrice
        let matix = homogeneousMatrix()
        
        var trans = CATransform3DIdentity
        
        // calculate tranform matrice
        trans = CATransform3DRotate(trans, angle, vector.x, vector.y, vector.z)
        
        // calculate matrix * trans the result contrains new coordinate
        trans = CATransform3DConcat(matix, trans)
        
        // get new coordinate from the result above
        let p = point(from: trans)
        
        return p
    }
    
    public func translate(by offset: OrbitPoint) -> OrbitPoint {
        let matrix = homogeneousMatrix()
        var trans = CATransform3DIdentity
        trans = CATransform3DTranslate(trans, offset.x, offset.y, offset.z)
        trans = CATransform3DConcat(matrix, trans)
        return point(from: trans)
    }
    
    public func scale(by factor: OrbitPoint) -> OrbitPoint {
        let matrix = homogeneousMatrix()
        var trans = CATransform3DIdentity
        trans = CATransform3DScale(trans, factor.x, factor.y, factor.z)
        trans = CATransform3DConcat(matrix, trans)
        return point(from: trans)
    }
}
