//
//  AtbashCipherVM.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 15.02.2023.
//

import Foundation

class EncryptedTextEditVM: ObservableObject {
    @Published var inputText: String = ""
    @Published var outputText: String = ""
    @Published var selected: Int = 1
    @Published var firstModeName: String = String(localized: "Original Text")
    @Published var secondModeName: String = String(localized: "Encrypted Text")
    @Published var isEncrypting: Bool = true
    @Published var errorMessage: String?
    
    public var encryptProvider: TextEncyption
    
    init(encryptProvider: TextEncyption){
        self.encryptProvider = encryptProvider
    }
    
    public func translate() {
        if (isEncrypting) {
            performEncrypt()
        }
        else{
            performDecrypt()
        }
    }
    
    public func performEncrypt() {
        do {
            outputText = try encryptProvider.EncryptText(inputText)
            errorMessage = nil
        } catch {
            outputText = error.localizedDescription
            errorMessage = error.localizedDescription
        }
    }
    
    public func performDecrypt() {
        do {
            outputText = try encryptProvider.DecryptText(inputText)
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
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
