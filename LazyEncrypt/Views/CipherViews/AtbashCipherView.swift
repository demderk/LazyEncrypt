//
//  AtbashCipher.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 11.03.2023.
//

import SwiftUI

struct AtbashCipherView: View {
    var body: some View {
        EncryptedTextEdit(AtbashCipher(),settingsHidden: true)
    }
}

struct AtbashCipher_Previews: PreviewProvider {
    static var previews: some View {
        AtbashCipherView()
    }
}
