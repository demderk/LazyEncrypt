//
//  VigenereCipherView.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 24.03.2023.
//

import SwiftUI

struct VigenereCipherView: View {
    @State var skipEnabled = true
    @State var cipher = VigenereCipher()
    
    var body: some View {
        EncryptedTextEdit(cipher) { vm in
            SettingsGroup(title: "Cipher config"){
                Toggle(isOn: $skipEnabled) {
                    Text("Skip non alphabet characters")
                        .font(.caption)
                }.onChange(of: skipEnabled) { _ in
                    cipher.skipNonAlphabetSymbols = skipEnabled
                    vm.translate()
                }
            }
        }
    }
}

struct VigenereCipherView_Previews: PreviewProvider {
    static var previews: some View {
        RichelieuCipherView()
    }
}
