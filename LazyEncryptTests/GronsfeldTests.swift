//
//  GronsfeldTests.swift
//  LazyEncryptTests
//
//  Created by Roman Zheglov on 06.03.2023.
//

import XCTest

@testable import LazyEncrypt

final class GronsfeldTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEncryptWikipedia() throws {
        let testClass = GronsfeldCipher()
        try testClass.setKey("2 0 1 5")
        let result = try testClass.EncryptText("GRONSFELD")
        XCTAssertEqual("IRPSUFFQF", result)
    }
    
    func testDecryptWikipedia() throws {
        let testClass = GronsfeldCipher()
        try testClass.setKey("2 0 1 5")
        let result = try testClass.DecryptText("IRPSUFFQF")
        XCTAssertEqual("GRONSFELD", result)
    }

}
