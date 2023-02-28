//
//  CesarsTests.swift
//  LazyEncryptTests
//
//  Created by Roman Zheglov on 28.02.2023.
//

import XCTest
@testable import LazyEncrypt

final class CesarsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRussianWikipedia() throws{
        let testClass = CesarsCipher(3)
        let result = testClass.EncryptText("Съешь же ещё этих мягких французских булок да выпей чаю.")
        XCTAssertEqual(result, "Фэзыя йз зьи ахлш пвёнлш чугрщцкфнлш дцосн жг еютзм ъгб.")
    }
    
    func testRussianDecrypt() throws{
        let testClass = CesarsCipher(3)
        let result = testClass.DecryptText("где")
        XCTAssertEqual(result, "абв")
    }
    
    func testRussianDecryptStepExceeded() throws{
        let testClass = CesarsCipher(1455)
        let result = testClass.DecryptText("где")
        XCTAssertEqual(result, "абв")
    }
    
    func testEnglishDecryptStepExceeded() throws{
        let testClass = CesarsCipher(1455)
        let result = testClass.DecryptText("zab")
        XCTAssertEqual(result, "abc")
    }

}
