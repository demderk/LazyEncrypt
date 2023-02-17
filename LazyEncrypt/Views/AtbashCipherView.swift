//
//  AtbashCipher.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 17.02.2023.
//

import SwiftUI

struct AtbashCipherView: View {
    @ObservedObject var evm: EncryptedTextEditVM = EncryptedTextEditVM(encryptProvider: AtbashCipher())
    
    var body: some View {
        EncryptedTextEditView(vm: evm)
    }
}

struct AtbashCipherView_Previews: PreviewProvider {
    static var previews: some View {
        AtbashCipherView()
    }
}
