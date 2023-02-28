//
//  RichelieuCipher.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 18.02.2023.
//

import Foundation

enum RichelieuError: Error {
    // KEYPART Errors
    case keypartIsEmpty(atPosition: Int)
    case keyKeypartSymbolIsUnreachable(atPosition: Int, blockLength: Int, maxValue: Int)
    case keyKeypartSymbolLessThanZero(atPosition: Int)
    case keyKeypartIsIncomplete(atPosition: Int)
    case keyKeyPartIsAsymetric(atPosition: Int)
    case keyKeyPartSymbolsNotUnique(atPosition: Int)
//    case keyLengthIncorrect(expectedLength: Int ,currentLength: Int)
    // PArser
    case keySyntaxError(atPostion: Int)
    case dataIsLongerThanKey(dataCount: Int, keyLength: Int)
}

class RichelieuCipher: TextEncyption {
    
    private let regexKey = "([(](\\d+[,]*)+[)])"
    
    private var key: [[Int]] = []
    
    func EncryptText(_ data: String) throws -> String {
        let keyLength = key.compactMap({$0.count}).reduce(0, +)
        guard keyLength <= data.count else {
            throw RichelieuError.dataIsLongerThanKey(dataCount: data.count, keyLength: keyLength)
        }
        var parts: [String] = []
        var parsedString = data
        for keyPart in key {
            let originalKeyPart = String(parsedString.prefix(keyPart.count))
            var encryptedKeypart = ""
            parsedString = String(parsedString.suffix(from: parsedString.index(parsedString.startIndex, offsetBy: keyPart.count)))
            for i in keyPart {
                encryptedKeypart.append(originalKeyPart[i-1])
            }
            parts.append(encryptedKeypart)
        }
        let tailCount = data.count - parts.compactMap({$0.count}).reduce(0, +)
        if (tailCount > 0) {
            parts.append(String(data.suffix(tailCount)))
        }
        return parts.joined()
    }
    
    func DecryptText(_ data: String) -> String {
        return "Error"
    }
    
    func parseKey(_ data: String) throws {
        let regex = try! NSRegularExpression(pattern: regexKey)
        let results = regex.matches(in: data, range: NSRange(location: 0, length: data.count))
        let x = results.map {String(data[Range($0.range, in: data)!])}
        
        var dataParsed: [[Int]] = []
        
        for item in x {
            var tempResult: [Int] = []
            for char in item {
                if let number = Int(String(char)) {
                    tempResult.append(number)
                }
            }
            dataParsed.append(tempResult)
        }
        
        //TODO: Position detection
        guard (x.joined() == data) else{
            throw RichelieuError.keySyntaxError(atPostion: -1)
        }
        
        for (n,item) in dataParsed.enumerated(){
            // Empty KEYPART
            if item.count == 0 {
                throw RichelieuError.keypartIsEmpty(atPosition: n)
            }
            // Это надо?
//            if item[0] != item.count {
//                throw RichelieuCipherError.keyLengthIncorrect(expectedLength: item.count, currentLength: item[0])
//            }
            
            // Unreachable
            let maxValue = item.max()!
            if maxValue > item.count {
                throw RichelieuError.keyKeypartSymbolIsUnreachable(atPosition: n,blockLength: item.count, maxValue: maxValue)
            }
            
            
            // KEYPART Symbols is unique
            var seenNumbers: [Int] = []
            for uniqItem in item {
                if (seenNumbers.contains(uniqItem))
                {
                    throw RichelieuError.keyKeyPartSymbolsNotUnique(atPosition: n)
                }
                seenNumbers.append(uniqItem)
            }
            
            // KEY PART ITEM IS LESS THAN ZERO
            if (item.filter({$0 <= 0}).count > 0) {
                throw RichelieuError.keyKeypartSymbolLessThanZero(atPosition: n)
            }
            
            // KEYPART IS ASYMETRIC
            for (i,xItem) in item.enumerated() {
                if (i+1 != item[xItem-1]) {
                    throw RichelieuError.keyKeyPartIsAsymetric(atPosition: n)
                }
            }
            
            guard item.sorted() == Array(1...item.count) else {
                throw RichelieuError.keyKeypartIsIncomplete(atPosition: n)
            }
        //TODO: REALIZE keyKeypartIsIncomplete
        }
        key = dataParsed
    }
}
