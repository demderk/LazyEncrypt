import SwiftUI

struct GronsfeldCipherView: View {
    @State var skipEnabled = true
    @State var cipher = GronsfeldCipher()
    
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

struct GronsfeldCipherView_Previews: PreviewProvider {
    static var previews: some View {
        RichelieuCipherView()
    }
}
