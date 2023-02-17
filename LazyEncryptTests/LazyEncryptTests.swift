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

    func testAtbashEnglishCapitalize() throws {
        let testClass = AtbashCipher()
        let result = testClass.EncryptText(data: "AbC")
        XCTAssertEqual(result, "ZyX")
    }

    func testAtbashRussianCapitalize() throws {
        let testClass = AtbashCipher()
        let result = testClass.EncryptText(data: "АбВ")
        XCTAssertEqual(result, "ЯюЭ")
    }
    
    func testCesarsRussianWikipedia() throws{
        let testClass = CesarsCipher(3)
        let result = testClass.EncryptText(data: "Съешь же ещё этих мягких французских булок да выпей чаю.")
        XCTAssertEqual(result, "Фэзыя йз зьи ахлш пвёнлш чугрщцкфнлш дцосн жг еютзм ъгб.")
    }
    
    func testCesarsRussianDecrypt() throws{
        let testClass = CesarsCipher(3)
        let result = testClass.DecryptText(data: "где")
        XCTAssertEqual(result, "абв")
    }
    
}
