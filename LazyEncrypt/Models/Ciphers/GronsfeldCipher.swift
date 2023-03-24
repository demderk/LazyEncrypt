//
//  GronsfeldCipher.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 05.03.2023.
//

import Foundation

enum GronsfeldCipherError: EncryptionError {
    case notImplemented
    case keySyntaxError
    
    var errorDescription: String? {
        switch self {
        case .notImplemented:
            return "Function not implemented"
        case .keySyntaxError:
            return "Syntax error"
        }
    }
}

class GronsfeldCipher: AlphabetEncryption, KeyEncryption {
    
    public var skipNonAlphabetSymbols = true
    
    var alphabets: [[Character]] = [Array("abcdefghijklmnopqrstuvwxyz"), Array("абвгдеёжзийклмнопрстуфхцчшщъыьэюя")]
    private var key: [Int] = [0]
    
    private func EncryptWithKey(_ data: String, _ encryptKey: [Int]) -> String {
        var result = ""
        guard encryptKey.count > 0 else{
            return data
        }
        var at = 0
        for item in data {
            let currentKeyShift = encryptKey[at%encryptKey.count]
            if let alphabet = alphabets.first(where: {x in x.contains(Character(item.lowercased()))}) {
                if let charIndex = alphabet.firstIndex(of: Character(item.lowercased())) {
                    let index = (charIndex + currentKeyShift) % alphabet.count < 0 ?
                    (charIndex + currentKeyShift) % alphabet.count + alphabet.count :
                    (charIndex + currentKeyShift) % alphabet.count
                    result.append(item.isUppercase ? Character(alphabet[index].uppercased()) : alphabet[index])
                    at += 1
                }
            }
            else {
                result.append(item)
                at += skipNonAlphabetSymbols ? 0 : 1
            }
        }
        return result
    }
    
    func setKey(_ key: String) throws {
        try setKey(key, splitBy: " ")
    }
    
    func setKey(_ key: String, splitBy: String) throws {
        var result: [Int] = []
        let splited = key.split(separator: splitBy)
        for item in splited {
            if let number = Int(item) {
                result.append(number)
            }
        }
        guard key == String(result.map({String($0)}).joined(separator: splitBy)) else {
            throw GronsfeldCipherError.keySyntaxError
        }
        self.key = result
    }
    
    func EncryptText(_ data: String) throws -> String {
        return EncryptWithKey(data, key)
    }
    
    func DecryptText(_ data: String) throws -> String {
        return EncryptWithKey(data, key.map({$0 * -1}))
    }
    
}
