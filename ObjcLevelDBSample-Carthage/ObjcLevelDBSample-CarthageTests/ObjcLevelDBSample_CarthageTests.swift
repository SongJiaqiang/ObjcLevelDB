//
//  ObjcLevelDBSample_CarthageTests.swift
//  ObjcLevelDBSample-CarthageTests
//
//  Created by Jarvis on 20/08/2017.
//  Copyright © 2017 JQTech. All rights reserved.
//

import XCTest
@testable import ObjcLevelDBSample_Carthage

import ObjcLevelDB

class ObjcLevelDBSample_CarthageTests: XCTestCase {
    
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
    
    func testLevelDB() {
        
        // Define some parameters
        let id: Int = 2150
        let name: String = "Jarivs"
        let weight: Float = 59.8
        
        // Store infomation
        let db = LevelDB.databaseInLibrary(withName: "test.db")
        
        db!["info"] = ["id":id, "name":name, "weight":weight]
        
        // Fetch infomation
        let json = db!["info"]
        XCTAssertNotNil(json)
        
        let info = json as! [String:Any]
        XCTAssertEqual(info["id"] as! Int, id)
        XCTAssertEqual(info["name"] as! String, name)
        XCTAssertEqual(info["weight"] as! Float, weight)
        
    }

    func testFastCodingLevelDB() {
        // Define some parameters
        let id: Int = 2150
        let name: String = "Jarivs"
        let weight: Float = 59.8
        
        // Store infomation
        let db = LevelDB.databaseInLibrary(withName: "test.db")
        db!.fc_setObject(["id":id, "name":name, "weight":weight], forKey: "info")
        
        // Fetch infomation
        let json = db!.fc_object(forKey: "info")
        XCTAssertNotNil(json)
        
        let info = json as! [String:Any]
        XCTAssertEqual(info["id"] as! Int, id)
        XCTAssertEqual(info["name"] as! String, name)
        XCTAssertEqual(info["weight"] as! Float, weight)
        

    }
    
}


