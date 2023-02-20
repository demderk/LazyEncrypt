//
//  CesarsCipher.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 17.02.2023.
//

import Foundation

class CesarsCipher: TextEncyption{
    var englishAlphabet: [Character] = Array("abcdefghijklmnopqrstuvwxyz")
    var russianAlphabet: [Character] = Array("абвгдеёжзийклмнопрстуфхцчшщъыьэюя")
    public var shift = 1
    
    init(_ shift: Int) {
        self.shift = shift
    }
    
    func EncryptText(_ data: String) -> String {
        var result: String = ""
        for item in data {
            if let engIndex = englishAlphabet.firstIndex(of: Character(item.lowercased())){
                let enChar = englishAlphabet[(engIndex + shift) % englishAlphabet.count]
                result.append(item.isUppercase ? Character(enChar.uppercased()) : enChar)
                continue
            }
            if let ruIndex = russianAlphabet.firstIndex(of: Character(item.lowercased())){
                let ruChar = russianAlphabet[(ruIndex + shift) % russianAlphabet.count]
                result.append(item.isUppercase ? Character(ruChar.uppercased()) : ruChar)
                continue
            }
            result.append(item)
        }
        return result
    }
    
    func DecryptText(_ data: String) -> String {
        var result: String = ""
        for item in data {
            if let engIndex = englishAlphabet.firstIndex(of: Character(item.lowercased())){
                let index = (engIndex - shift) % englishAlphabet.count < 0 ? (engIndex - shift) % englishAlphabet.count + englishAlphabet.count: (engIndex - shift) % englishAlphabet.count
                let enChar = englishAlphabet[index]
                result.append(item.isUppercase ? Character(enChar.uppercased()) : enChar)
                continue
            }
            if let ruIndex = russianAlphabet.firstIndex(of: Character(item.lowercased())){
                let index = (ruIndex - shift) % russianAlphabet.count < 0 ? (ruIndex - shift) % russianAlphabet.count + russianAlphabet.count: (ruIndex - shift) % russianAlphabet.count
                let ruChar = russianAlphabet[index]
                result.append(item.isUppercase ? Character(ruChar.uppercased()) : ruChar)
                continue
            }
            result.append(item)
        }
        return result
    }
    
    
}
