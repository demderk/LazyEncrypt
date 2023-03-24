//
//  RichelieuCipherView.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 11.03.2023.
//

import SwiftUI

struct RichelieuCipherView: View {
    var body: some View {
        EncryptedTextEdit(RichelieuCipher())
    }
}

struct RichelieuCipherView_Previews: PreviewProvider {
    static var previews: some View {
        RichelieuCipherView()
    }
}
