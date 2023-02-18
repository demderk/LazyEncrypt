//
//  CesarsCipherMV.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 17.02.2023.
//

import Foundation
import SwiftUI

class CesarsCipherVM: ObservableObject {
    @Published var shift: Int = 3
    @Published var cipher: CesarsCipher
    @Published var inputText: String = ""
    @Published var outputText: String = ""
    
    
    
    init() {
        let shift = 3
        self.shift = shift
        cipher = CesarsCipher(shift)
    }
}
