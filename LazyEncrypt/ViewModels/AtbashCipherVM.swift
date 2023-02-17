//
//  AtbashCipherVM.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 15.02.2023.
//

import Foundation

class AtbashCipherVM: ObservableObject {
    @Published var inputText: String = ""
    @Published var outputText: String = ""
    @Published var selected: Int = 1
    @Published var firstModeName: String = "Original Text"
    @Published var secondModeName: String = "Encrypted Text"
    
    public func performEncrypt() {
        let atbash = AtbashCipher()
        outputText = atbash.EncryptText(data: inputText)
    }
    
    public func swapMode() {
            let tempModeName = firstModeName
            firstModeName = secondModeName
            secondModeName = tempModeName
            let tempInput = inputText
            inputText = outputText
            outputText = tempInput
    }
}
