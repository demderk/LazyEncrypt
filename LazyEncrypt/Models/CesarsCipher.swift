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
    
    func EncryptText(data: String) -> String {
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
    
    func DecryptText(data: String) -> String {
        var result: String = ""
        for item in data {
            if let engIndex = englishAlphabet.firstIndex(of: Character(item.lowercased())){
                let enChar = englishAlphabet[(engIndex - shift) < 0 ? (engIndex - shift) + englishAlphabet.count : (engIndex - shift) % englishAlphabet.count]
                result.append(item.isUppercase ? Character(enChar.uppercased()) : enChar)
                continue
            }
            if let ruIndex = russianAlphabet.firstIndex(of: Character(item.lowercased())){
                let ruChar = russianAlphabet[(ruIndex - shift) < 0 ? (ruIndex - shift) + russianAlphabet.count : (ruIndex - shift) % russianAlphabet.count]
                result.append(item.isUppercase ? Character(ruChar.uppercased()) : ruChar)
                continue
            }
            result.append(item)
        }
        return result
    }
    
    
}
