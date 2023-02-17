//
//  LazyEncryptTests.swift
//  LazyEncryptTests
//
//  Created by Roman Zheglov on 15.02.2023.
//

import XCTest
@testable import LazyEncrypt

final class AtbashTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAtbashEnglish() throws {
        let testClass = AtbashCipher()
        let result = testClass.EncryptText(data: "abcdefghijklmnopqrstuvwxyz")
        XCTAssertEqual(result, "zyxwvutsrqponmlkjihgfedcba")
    }
    
    func testAtbashRussian() throws {
        let testClass = AtbashCipher()
        let result = testClass.EncryptText(data: "абвгдеёжзийклмнопрстуфхцчшщъыьэюя")
        XCTAssertEqual(result, "яюэьыъщшчцхфутсрпонмлкйизжёедгвба")
    }
    
    func testAtbashEnglishRussian() throws {
        let testClass = AtbashCipher()
        let result = testClass.EncryptText(data: "abcdefghijklmnopqrstuvwxyzабвгдеёжзийклмнопрстуфхцчшщъыьэюя")
        XCTAssertEqual(result, "zyxwvutsrqponmlkjihgfedcbaяюэьыъщшчцхфутсрпонмлкйизжёедгвба")
    }
    
    func testAtbashUnknownSymbols() throws {
        let testClass = AtbashCipher()
        let result = testClass.EncryptText(data: "a7b5c")
        XCTAssertEqual(result, "z7y5x")
    }

}
