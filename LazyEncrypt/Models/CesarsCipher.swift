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
    
    private func EncryptWithShift(_ data: String, _ customShift: Int) -> String {
        var result: String = ""
        for item in data {
            if let engIndex = englishAlphabet.firstIndex(of: Character(item.lowercased())){
                let index = (engIndex + customShift) % englishAlphabet.count < 0 ? (engIndex + customShift) % englishAlphabet.count + englishAlphabet.count: (engIndex + customShift) % englishAlphabet.count
                let enChar = englishAlphabet[index]
                result.append(item.isUppercase ? Character(enChar.uppercased()) : enChar)
                continue
            }
            if let ruIndex = russianAlphabet.firstIndex(of: Character(item.lowercased())){
                let index = (ruIndex + customShift) % russianAlphabet.count < 0 ? (ruIndex + customShift) % russianAlphabet.count + russianAlphabet.count: (ruIndex + customShift) % russianAlphabet.count
                let ruChar = russianAlphabet[index]
                result.append(item.isUppercase ? Character(ruChar.uppercased()) : ruChar)
                continue
            }
            result.append(item)
        }
        return result
    }
    
    func EncryptText(data: String) -> String {
        EncryptWithShift(data, shift)
    }
    
    func DecryptText(data: String) -> String {
        EncryptWithShift(data, -shift)
    }
    
    
}
