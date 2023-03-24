//
//  CesarsCipherView.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 11.03.2023.
//

import SwiftUI

struct CesarsCipherView: View {
    @State var cesarsShift: Int
    private var cesarsEncryption: CesarsCipher
    
    init() {
        let shift = 3
        cesarsShift = shift
        cesarsEncryption = CesarsCipher(shift)
    }
    
    var body: some View {
        EncryptedTextEdit(cesarsEncryption) { vm in
            SettingsGroup(title: "Cipher config"){
                NumberSelector(title: "Cipher Shift", number: $cesarsShift) {
                    (vm.encryptProvider as! CesarsCipher).shift = cesarsShift
                    vm.translate()
                }
            }.padding(.top, 8)
        }
    }
}

struct CesarsCipherView_Previews: PreviewProvider {
    static var previews: some View {
        CesarsCipherView()
    }
}
