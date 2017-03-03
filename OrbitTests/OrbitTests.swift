//
//  OrbitTests.swift
//  OrbitTests
//
//  Created by Lijie on 16/9/20.
//  Copyright © 2016年 HuatengIOT. All rights reserved.
//

import XCTest
@testable import Orbit

class OrbitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testPoint() {
        let x: CGFloat = 12.0
        let y: CGFloat = -5.0
        let z: CGFloat = 3.0
        
        let vector = OrbitPoint(x: -1.0, y: 2.0, z: 3.0)
        
        let point1 = OrbitPoint(x: x, y: y, z: z)
        
        let point2 = point1.rotated(by: CGFloat(M_PI_4 / 2.0), about: vector)
        
        print(point2.x, point2.y, point2.z)
    }
    
    func testCGFloat() {
        let from = CGFloat.pi.divided(by: 2)
        let to = CGFloat.pi.divided(by: -2)
        let repeatCount = Float.greatestFiniteMagnitude
        
        XCTAssertEqual(from, CGFloat(M_PI_2))
        XCTAssertEqual(to, CGFloat(-M_PI_2))
        XCTAssertEqual(repeatCount, MAXFLOAT)
        
        XCTAssertEqual(CGFloat.pi.multiplied(by: 2), CGFloat(M_PI * 2))
    }
    
}
