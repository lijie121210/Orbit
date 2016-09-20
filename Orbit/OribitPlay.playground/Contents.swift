//: Playground - noun: a place where people can play

import UIKit

let angle = CGFloat(M_PI / 180 * 0.8)

class OrbitView: UIView {
    
    var display: CADisplayLink?
    
    func start() {
        self.display = CADisplayLink(target: vi, selector: #selector(OrbitView.fireDisplayLink))
        self.display?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
    }
    func fireDisplayLink() {
        self.transform = CGAffineTransformMakeRotation(angle)
        print("firing...")
    }
}

var vi = OrbitView(frame: CGRect(x: 100,y: 100,width: 300,height: 300))
vi.backgroundColor = UIColor.blackColor()
vi.layer.cornerRadius = 150.0
vi.layer.borderColor = UIColor.purpleColor().CGColor
vi.layer.borderWidth = 1.0

var line = UIView(frame: CGRect(x: 10,y: 149,width: 280,height: 2))
line.backgroundColor = UIColor.whiteColor()
vi.addSubview(line)

vi.start()

//vi.layer.transform = CATransform3DMakeRotation(<#T##angle: CGFloat##CGFloat#>, <#T##x: CGFloat##CGFloat#>, <#T##y: CGFloat##CGFloat#>, <#T##z: CGFloat##CGFloat#>)