//
//  RichelieuCipher.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 18.02.2023.
//

import Foundation

enum RichelieuError: EncryptionError {
    // Keypart Errors
    case keyKeypartSymbolIsUnreachable(atPosition: Int, blockLength: Int, maxValue: Int)
    case keyKeypartSymbolLessThanZero(atPosition: Int)
    case keyKeypartIsIncomplete(atPosition: Int)
    case keyKeyPartIsAsymetric(atPosition: Int)
    case keyKeyPartSymbolsNotUnique(atPosition: Int)
    case keySyntaxError
    // Parser Errors
    case keyIsLongerThanData(dataCount: Int, keyLength: Int)
    
    var errorDescription: String? {
        switch self {
        case .keySyntaxError:
            return String(localized: "Syntax error")
        case .keyKeypartIsIncomplete(atPosition: let pos):
            return String(localized: "Key in incomplete at position: \(pos)")
        case .keyKeypartSymbolIsUnreachable(atPosition: let pos, blockLength: let exp, maxValue: let cur):
            return String(localized: "Keypart symbol is unreachable in keypart №\(pos). Maximum value: \(cur), expected \(exp).")
        case .keyKeyPartIsAsymetric(atPosition: let pos):
            return String(localized: "Keypart №\(pos) is asymetric.")
        case .keyKeyPartSymbolsNotUnique(atPosition: let pos):
            return String(localized: "Symbols in keypart №\(pos) not unique.")
        case .keyKeypartSymbolLessThanZero(atPosition: let pos):
            return String(localized: "Symbols in keypart №\(pos) less than zero or equal.")
        case .keyIsLongerThanData(dataCount: let cur, keyLength: let exp):
            return String(localized: "Key is longer than data. Data length: \(cur), expected(key length): \(exp)")
        }
    }
}
    class RichelieuCipher: TextEncyption, KeyEncryption {
        private let regexKey = "([(](\\d+[,]*)+[)])"
        private var key: [[Int]] = []
        
        func EncryptText(_ data: String) throws -> String {
            let keyLength = key.compactMap({$0.count}).reduce(0, +)
            guard keyLength <= data.count else {
                throw RichelieuError.keyIsLongerThanData(dataCount: data.count, keyLength: keyLength)
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
        
        func DecryptText(_ data: String) throws -> String {
            return try EncryptText(data)
        }
        
        func setKey(_ key: String) throws {
            let regex = try! NSRegularExpression(pattern: regexKey)
            let results = regex.matches(in: key, range: NSRange(location: 0, length: key.count))
            let x = results.map {String(key[Range($0.range, in: key)!])}
            var dataParsed: [[Int]] = []

            for item in x {
                let checkin = item.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted)
                let numbers = checkin.split(separator: ",")
                var tempResult: [Int] = []
                for char in numbers {
                    if let number = Int(String(char)) {
                        tempResult.append(number)
                    }
                }
                dataParsed.append(tempResult)
            }
            
            guard (x.joined() == key) else{
                throw RichelieuError.keySyntaxError
            }
            
            for (n,item) in dataParsed.enumerated(){
                //MARK: Unreachable
                let maxValue = item.max()!
                if maxValue > item.count {
                    throw RichelieuError.keyKeypartSymbolIsUnreachable(atPosition: n,blockLength: item.count, maxValue: maxValue)
                }
                
                //MARK: KEYPART Symbols is unique
                var seenNumbers: [Int] = []
                for uniqItem in item {
                    if (seenNumbers.contains(uniqItem))
                    {
                        throw RichelieuError.keyKeyPartSymbolsNotUnique(atPosition: n)
                    }
                    seenNumbers.append(uniqItem)
                }
                
                //MARK: KEY PART ITEM IS LESS THAN ZERO
                if (item.filter({$0 <= 0}).count > 0) {
                    throw RichelieuError.keyKeypartSymbolLessThanZero(atPosition: n)
                }
                
                //MARK: KEYPART IS ASYMETRIC
                for (i,xItem) in item.enumerated() {
                    if (i+1 != item[xItem-1]) {
                        throw RichelieuError.keyKeyPartIsAsymetric(atPosition: n)
                    }
                }
                
                guard item.sorted() == Array(1...item.count) else {
                    throw RichelieuError.keyKeypartIsIncomplete(atPosition: n)
                }
            }
            self.key = dataParsed
        }
    }
