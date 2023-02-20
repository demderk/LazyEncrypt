//
//  RichelieuCipher.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 18.02.2023.
//

import Foundation

enum RichelieuKeyError: Error {
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
}

class RichelieuCipher: TextEncyption {
    
    private let regexKey = "([(](\\d+[,]*)+[)])"
    
    private var key: [[Int]] = []
    
    func EncryptText(_ data: String) -> String {
        return "Error"
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
            throw RichelieuKeyError.keySyntaxError(atPostion: -1)
        }
        
        for (n,item) in dataParsed.enumerated(){
            // Empty KEYPART
            if item.count == 0 {
                throw RichelieuKeyError.keypartIsEmpty(atPosition: n)
            }
            // Это надо?
//            if item[0] != item.count {
//                throw RichelieuCipherError.keyLengthIncorrect(expectedLength: item.count, currentLength: item[0])
//            }
            
            // Unreachable
            let maxValue = item.max()!
            if maxValue > item.count {
                throw RichelieuKeyError.keyKeypartSymbolIsUnreachable(atPosition: n,blockLength: item.count, maxValue: maxValue)
            }
            
            
            // KEYPART Symbols is unique
            var seenNumbers: [Int] = []
            for uniqItem in item {
                if (seenNumbers.contains(uniqItem))
                {
                    throw RichelieuKeyError.keyKeyPartSymbolsNotUnique(atPosition: n)
                }
                seenNumbers.append(uniqItem)
            }
            
            // KEY PART ITEM IS LESS THAN ZERO
            if (item.filter({$0 <= 0}).count > 0) {
                throw RichelieuKeyError.keyKeypartSymbolLessThanZero(atPosition: n)
            }
            
            // KEYPART IS ASYMETRIC
            for (i,xItem) in item.enumerated() {
                if (i+1 != item[xItem-1]) {
                    throw RichelieuKeyError.keyKeyPartIsAsymetric(atPosition: n)
                }
            }
            
        //TODO: REALIZE keyKeypartIsIncomplete
        }
        print(dataParsed)
    }
}
