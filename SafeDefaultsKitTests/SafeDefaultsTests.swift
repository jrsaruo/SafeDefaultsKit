//
//  SafeDefaultsTests.swift
//  SafeDefaultsTests
//
//  Created by Yusaku Nishi on 2017/12/19.
//

import XCTest
@testable import SafeDefaultsKit

class SafeDefaultsTests: XCTestCase {
    
    private struct TestDefaults: SafeDefaults {
        enum Keys: String, DefaultsKey {
            case test
            
            var uniqueValue: String {
                return "TestDefaults.\(Keys.self).\(self.rawValue)"
            }
        }
    }
    
    private let defaults = TestDefaults()
    
    // MARK: -
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: -
    func testArray() {
        let array: [Double] = [3.0, 2.0, 5.0]
        self.defaults.set(array, forKey: .test)
        guard let savedArray = self.defaults.array(forKey: .test) as? [Double] else {
            XCTFail()
            return
        }
        XCTAssertEqual(savedArray, array)
        
        self.defaults.removeObject(forKey: .test)
        XCTAssertNil(self.defaults.array(forKey: .test))
    }
    
    func testBool() {
        self.defaults.set(false, forKey: .test)
        XCTAssertFalse(self.defaults.bool(forKey: .test))
        
        self.defaults.set(true, forKey: .test)
        XCTAssertTrue(self.defaults.bool(forKey: .test))
        
        self.defaults.removeObject(forKey: .test)
        XCTAssertFalse(self.defaults.bool(forKey: .test))
        XCTAssertNil(self.defaults.object(forKey: .test))
    }
    
    func testData() {
        let data = "test data".data(using: .utf8)!
        self.defaults.set(data, forKey: .test)
        XCTAssertEqual(self.defaults.data(forKey: .test), data)
        
        self.defaults.removeObject(forKey: .test)
        XCTAssertNil(self.defaults.data(forKey: .test))
    }
    
    func testDouble() {
        let double: Double = 5.0
        self.defaults.set(double, forKey: .test)
        XCTAssertEqual(self.defaults.double(forKey: .test), double)
        
        self.defaults.removeObject(forKey: .test)
        XCTAssertNil(self.defaults.double(forKey: .test))
    }
    
    func testFloat() {
        let float: Float = 5.0
        self.defaults.set(float, forKey: .test)
        XCTAssertEqual(self.defaults.float(forKey: .test), float)
        
        self.defaults.removeObject(forKey: .test)
        XCTAssertNil(self.defaults.float(forKey: .test))
    }
    
    func testInteger() {
        let integer: Int = 5
        self.defaults.set(integer, forKey: .test)
        XCTAssertEqual(self.defaults.integer(forKey: .test), integer)
        
        self.defaults.removeObject(forKey: .test)
        XCTAssertNil(self.defaults.integer(forKey: .test))
    }
    
    func testString() {
        let string = "test string"
        self.defaults.set(string, forKey: .test)
        XCTAssertEqual(self.defaults.string(forKey: .test), string)
        
        self.defaults.removeObject(forKey: .test)
        XCTAssertNil(self.defaults.string(forKey: .test))
    }
    
    func testStringArray() {
        let stringArray: [String] = ["test", "string"]
        self.defaults.set(stringArray, forKey: .test)
        XCTAssertEqual(self.defaults.stringArray(forKey: .test) ?? [], stringArray)
        
        self.defaults.removeObject(forKey: .test)
        XCTAssertNil(self.defaults.stringArray(forKey: .test))
    }
    
    func testURL() {
        let url = URL(string: "https://example.com")!
        self.defaults.set(url, forKey: .test)
        XCTAssertEqual(self.defaults.url(forKey: .test), url)
        
        self.defaults.removeObject(forKey: .test)
        XCTAssertNil(self.defaults.url(forKey: .test))
    }
    
}
