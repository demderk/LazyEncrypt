//
//  RichelieuTests.swift
//  LazyEncryptTests
//
//  Created by Roman Zheglov on 28.02.2023.
//

import XCTest
@testable import LazyEncrypt

final class RichelieuTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testKeyParseUnreachable() throws {
        let testClass = RichelieuCipher()
        XCTAssertThrowsError(try testClass.parseKey("(4,2,1)")) { error in
            guard case RichelieuError.keyKeypartSymbolIsUnreachable(_,_,_) = error else{
                return XCTFail()
            }
        }
    }
    
    func testKeyParseASYMETRICRepeating() throws {
        let testClass = RichelieuCipher()
        XCTAssertThrowsError(try testClass.parseKey("(1,1)")) { error in
            guard case RichelieuError.keyKeyPartSymbolsNotUnique(_) = error else{
                return XCTFail()
            }
        }
    }
    
    func testKeyParseExampleKeyTest3() throws {
        let testClass = RichelieuCipher()
        XCTAssertThrowsError(try testClass.parseKey("(1,3)")) { error in
            guard case RichelieuError.keyKeypartSymbolIsUnreachable(_,_,_) = error else{
                return XCTFail()
            }
        }
    }
    
    func testKeyParseExampleKeyTest4() throws {
        let testClass = RichelieuCipher()
        XCTAssertThrowsError(try testClass.parseKey("(3,2,1)(4,3,2)")) { error in
            guard case RichelieuError.keyKeypartSymbolIsUnreachable(_,_,_) = error else{
                return XCTFail()
            }
        }
    }
    
    func testKeyParseASYMETRICIncorrect() throws {
        let testClass = RichelieuCipher()
        XCTAssertThrowsError(try testClass.parseKey("(4,1,2,3)")) { error in
            guard case RichelieuError.keyKeyPartIsAsymetric(_) = error else{
                return XCTFail()
            }
        }
    }
    
    func testKeyParseNonUnique() throws {
        let testClass = RichelieuCipher()
        XCTAssertThrowsError(try testClass.parseKey("(1,1,2,3)")) { error in
            guard case RichelieuError.keyKeyPartSymbolsNotUnique(_) = error else{
                return XCTFail()
            }
        }
    }
    
    func testKeyParseSymbolLessThanZero() throws {
        let testClass = RichelieuCipher()
        XCTAssertThrowsError(try testClass.parseKey("(4,0,2,3)")) { error in
            guard case RichelieuError.keyKeypartSymbolLessThanZero(_) = error else{
                return XCTFail()
            }
        }
    }
    
    
    func testKeyParseSymbolEmpty() throws {
        let testClass = RichelieuCipher()
        XCTAssertThrowsError(try testClass.parseKey("()")) { error in
            guard case RichelieuError.keySyntaxError(_) = error else{
                return XCTFail()
            }
        }
    }
    
    func testKeyParsekeySyntaxError() throws {
        let testClass = RichelieuCipher()
        XCTAssertThrowsError(try testClass.parseKey("(56656 ,das4)")) { error in
            guard case RichelieuError.keySyntaxError(_) = error else{
                return XCTFail()
            }
        }
    }
    
    func testKeyParsekeySyntaxError2() throws {
        let testClass = RichelieuCipher()
        XCTAssertThrowsError(try testClass.parseKey("(,0,2,)")) { error in
            guard case RichelieuError.keySyntaxError(_) = error else{
                return XCTFail()
            }
        }
    }
    
    func testEncryptSimple() throws {
        let testClass = RichelieuCipher()
        try testClass.parseKey("(2,1)")
        XCTAssertEqual(try testClass.EncryptText("ab"),"ba")
    }
    
    func testEncryptSimpleSuper() throws {
        let testClass = RichelieuCipher()
        try testClass.parseKey("(2,1)")
        XCTAssertEqual(try testClass.EncryptText("abc"),"bac")
    }
    
    func testEncryptSimpleLong() throws {
        let testClass = RichelieuCipher()
        try testClass.parseKey("(2,1)(2,1)(2,1)")
        XCTAssertEqual(try testClass.EncryptText("ababab"),"bababa")
    }
    
    func testEncryptExampleTest1() throws {
        let testClass = RichelieuCipher()
        try testClass.parseKey("(3,2,1)(4,2,3,1)(1)(2,1)(2,1)")
        XCTAssertEqual(try testClass.EncryptText("КРИПТОГРАФИЯ"),"ИРКГТОПРФАЯИ")
    }
    
    func testEncryptExampleTest2() throws {
        let testClass = RichelieuCipher()
        try testClass.parseKey("(3,2,1)")
        XCTAssertEqual(try testClass.EncryptText("КРИПТОГРАФИЯ"),"ИРКПТОГРАФИЯ")
    }

    func testEncryptExampleTest3() throws {
        let testClass = RichelieuCipher()
        try testClass.parseKey("(2,1)(2,1)(2,1)(2,1)(2,1)(2,1)")
        XCTAssertEqual(try testClass.EncryptText("КРИПТОГРАФИЯ"),"РКПИОТРГФАЯИ")
    }
    
    func testEncryptRandomTest() throws {
        let testClass = RichelieuCipher()
        try testClass.parseKey("(6,2,4,3,5,1)(3,2,1)")
        XCTAssertEqual(try testClass.EncryptText("КРИПТОГРАФИЯ"),"ОРПИТКАРГФИЯ")
    }
    
    func testEncryptKeyIsLonger() throws {
        let testClass = RichelieuCipher()
        try testClass.parseKey("(2,1)(2,1)(2,1)(2,1)(2,1)(2,1)(2,1)(2,1)(2,1)")
        XCTAssertThrowsError(try testClass.EncryptText("КРИПТОГРАФИЯ")) { error in
            guard case RichelieuError.keyIsLongerThanData(_, _) = error else {
                return XCTFail()
            }
        }
    }
    
}
