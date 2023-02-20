//
//  AtbashCipherModel.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 15.02.2023.
//

import Foundation

class AtbashCipher: TextEncyption {
    var englishAlphabet: [Character] = Array("abcdefghijklmnopqrstuvwxyz")
    var russianAlphabet: [Character] = Array("абвгдеёжзийклмнопрстуфхцчшщъыьэюя")
    var englishAlphabetReversed: [Character]
    var russianAlphabetReversed: [Character]
    
    init() {
        englishAlphabetReversed = englishAlphabet.reversed()
        russianAlphabetReversed = russianAlphabet.reversed()
    }
    
    func EncryptText(_ data: String) -> String {
        var result: String = ""
        for item in data {
            if let engIndex = englishAlphabet.firstIndex(of: Character(item.lowercased())){
                result.append(item.isUppercase ? Character(englishAlphabetReversed[engIndex].uppercased()) : englishAlphabetReversed[engIndex] )
                continue
            }
            if let ruIndex = russianAlphabet.firstIndex(of: Character(item.lowercased())){
                result.append(item.isUppercase ? Character(russianAlphabetReversed[ruIndex].uppercased()) : russianAlphabetReversed[ruIndex])
                continue
            }
            result.append(item)
        }
        return result
    }
    func DecryptText(_ data: String) -> String {
        return EncryptText(data)
    }
}
