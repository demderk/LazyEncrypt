//
//  AtbashCipherModel.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 15.02.2023.
//

import Foundation

class AtbashCipher {
    var englishAlphabet: [Character] = Array("abcdefghijklmnopqrstuvwxyz")
    var russianAlphabet: [Character] = Array("абвгдеёжзийклмнопрстуфхцчшщъыьэюя")
    var englishAlphabetReversed: [Character]
    var russianAlphabetReversed: [Character]
    
    init() {
        englishAlphabetReversed = englishAlphabet.reversed()
        russianAlphabetReversed = russianAlphabet.reversed()
    }
    
    func EncryptText(data: String) -> String {
        var result: String = ""
        for item in data {
            if let engIndex = englishAlphabet.firstIndex(of: Character(item.lowercased())){
                result.append(englishAlphabetReversed[engIndex])
                continue
            }
            if let ruIndex = russianAlphabet.firstIndex(of: Character(item.lowercased())){
                result.append(russianAlphabetReversed[ruIndex])
                continue
            }
            result.append(item)
        }
        return result
    }
    func DecryptText(data: String) {
        EncryptText(data: data)
    }
}
