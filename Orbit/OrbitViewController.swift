//
//  OrbitViewController.swift
//  Orbit
//
//  Created by Lijie on 16/9/20.
//  Copyright © 2016年 HuatengIOT. All rights reserved.
//

import UIKit

class OrbitViewController: UIViewController {
    
    
    func test2() {
        let vi = OrbitSphere(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: view.bounds.width))
        
        var vs = [UIView]()
        
        for i in 0...10 {
            let btn = UIButton(type: UIButtonType.system)
            btn.setTitle("P\(i)", for: .normal)
            btn.setTitleColor(UIColor.blue, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            btn.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
            btn.backgroundColor = UIColor.black
            btn.layer.cornerRadius = 30
            vs.append(btn)
        }
        vi.disperse(views: vs)
        vi.backgroundColor = UIColor.white
        view.addSubview(vi)
    }
    
    func test1() {
        let vi = OrbitView(frame: CGRect(x: 10, y: 100, width: 300, height: 300))
        view.addSubview(vi)
        vi.launchOrbit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        test1()
        
        
        
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
