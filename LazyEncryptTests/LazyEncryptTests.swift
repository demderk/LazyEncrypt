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
        let result = testClass.EncryptText("abcdefghijklmnopqrstuvwxyz")
        XCTAssertEqual(result, "zyxwvutsrqponmlkjihgfedcba")
    }
    
    func testAtbashRussian() throws {
        let testClass = AtbashCipher()
        let result = testClass.EncryptText("абвгдеёжзийклмнопрстуфхцчшщъыьэюя")
        XCTAssertEqual(result, "яюэьыъщшчцхфутсрпонмлкйизжёедгвба")
    }
    
    
    func testAtbashEnglishRussian() throws {
        let testClass = AtbashCipher()
        let result = testClass.EncryptText("abcdefghijklmnopqrstuvwxyzабвгдеёжзийклмнопрстуфхцчшщъыьэюя")
        XCTAssertEqual(result, "zyxwvutsrqponmlkjihgfedcbaяюэьыъщшчцхфутсрпонмлкйизжёедгвба")
    }
    
    func testAtbashUnknownSymbols() throws {
        let testClass = AtbashCipher()
        let result = testClass.EncryptText("a7b5c")
        XCTAssertEqual(result, "z7y5x")
    }
    
    func testAtbashEnglishCapitalize() throws {
        let testClass = AtbashCipher()
        let result = testClass.EncryptText("AbC")
        XCTAssertEqual(result, "ZyX")
    }
    
    func testAtbashRussianCapitalize() throws {
        let testClass = AtbashCipher()
        let result = testClass.EncryptText("АбВ")
        XCTAssertEqual(result, "ЯюЭ")
    }
    
    func testCesarsRussianWikipedia() throws{
        let testClass = CesarsCipher(3)
        let result = testClass.EncryptText("Съешь же ещё этих мягких французских булок да выпей чаю.")
        XCTAssertEqual(result, "Фэзыя йз зьи ахлш пвёнлш чугрщцкфнлш дцосн жг еютзм ъгб.")
    }
    
    func testCesarsRussianDecrypt() throws{
        let testClass = CesarsCipher(3)
        let result = testClass.DecryptText("где")
        XCTAssertEqual(result, "абв")
    }
    
    func testCesarsRussianDecryptStepExceeded() throws{
        let testClass = CesarsCipher(1455)
        let result = testClass.DecryptText("где")
        XCTAssertEqual(result, "абв")
    }
    
    func testCesarsEnglishDecryptStepExceeded() throws{
        let testClass = CesarsCipher(1455)
        let result = testClass.DecryptText("zab")
        XCTAssertEqual(result, "abc")
    }
    
    
    
    func testRichelieuKeyParseUnreachable() throws {
        let testClass = RichelieuCipher()
        XCTAssertThrowsError(try testClass.parseKey("(4,2,1)")) { error in
            guard case RichelieuKeyError.keyKeypartSymbolIsUnreachable(_,_,_) = error else{
                return XCTFail()
            }
        }
    }
    
    func testRichelieuKeyParseASYMETRICRepeating() throws {
        let testClass = RichelieuCipher()
        XCTAssertThrowsError(try testClass.parseKey("(1,1)")) { error in
            guard case RichelieuKeyError.keyKeyPartSymbolsNotUnique(_) = error else{
                return XCTFail()
            }
        }
    }
    
    func testRichelieuKeyParseASYMETRICIncorrect() throws {
        let testClass = RichelieuCipher()
        XCTAssertThrowsError(try testClass.parseKey("(4,1,2,3)")) { error in
            guard case RichelieuKeyError.keyKeyPartIsAsymetric(_) = error else{
                return XCTFail()
            }
        }
    }
    
    func testRichelieuKeyParseNonUnique() throws {
        let testClass = RichelieuCipher()
        XCTAssertThrowsError(try testClass.parseKey("(1,1,2,3)")) { error in
            guard case RichelieuKeyError.keyKeyPartSymbolsNotUnique(_) = error else{
                return XCTFail()
            }
        }
    }
    
    func testRichelieuKeyParseSymbolLessThanZero() throws {
        let testClass = RichelieuCipher()
        XCTAssertThrowsError(try testClass.parseKey("(4,0,2,3)")) { error in
            guard case RichelieuKeyError.keyKeypartSymbolLessThanZero(_) = error else{
                return XCTFail()
            }
        }
    }
    func testRichelieuKeyParseSymbolEmpty() throws {
        let testClass = RichelieuCipher()
        XCTAssertThrowsError(try testClass.parseKey("()")) { error in
            guard case RichelieuKeyError.keySyntaxError(_) = error else{
                return XCTFail()
            }
        }
    }
    func testRichelieuKeyParsekeySyntaxError() throws {
        let testClass = RichelieuCipher()
        XCTAssertThrowsError(try testClass.parseKey("(56656 ,das4)")) { error in
            guard case RichelieuKeyError.keySyntaxError(_) = error else{
                return XCTFail()
            }
        }
    }
}
