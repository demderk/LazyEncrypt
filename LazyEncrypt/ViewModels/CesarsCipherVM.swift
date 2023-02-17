//
//  CesarsCipherMV.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 17.02.2023.
//

import Foundation

class CesarsCipherVM: ObservableObject {
    @Published var shift: Int
    @Published var cipher: CesarsCipher
    @Published var inputText: String = ""
    @Published var outputText: String = ""
    
    
    init() {
        shift = 3
        cipher = CesarsCipher(3)
    }
}
