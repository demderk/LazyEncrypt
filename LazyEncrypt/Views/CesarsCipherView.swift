//
//  CesarsCipherView.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 17.02.2023.
//

import SwiftUI

struct CesarsCipherView: View {
    @ObservedObject var vm: CesarsCipherVM
    @ObservedObject var evm: EncryptedTextEditVM
    
    init() {
        let x = CesarsCipherVM()
        vm = x
        evm = EncryptedTextEditVM(encryptProvider: x.cipher)
    }
    
    @State var isEncrypting = true
    
    var body: some View {
        HStack {
            EncryptedTextEditView(vm: evm)
                
            Spacer().frame(width: 0)
            Divider()
            Spacer().frame(width: 0)
            VStack() {
                Text("Cesars Cipher Config")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .frame(minWidth: 208,alignment: .leading)
                    .padding(8)
                Spacer().frame(height: 0)
                HStack(){
                    Text("Cipher Shift")
                        .font(.caption)
                    Spacer().frame(width: 4)
                    TextField("", text: .constant(String(vm.shift)))
                        .frame(width: 40)
                        .multilineTextAlignment(.trailing)
                        .onChange(of: vm.shift, perform: {_ in
                            vm.cipher.shift = vm.shift
                            evm.translate()
                        })
                    Spacer().frame(width: 2)
                    Stepper(value: $vm.shift, label: {})
                }.frame(minWidth: 208,alignment: .trailing)
                Rectangle()
                    .fill(.gray)
                    .opacity(0.3)
                    .frame(minWidth: 224, minHeight: 1, maxHeight: 1)
                    .edgesIgnoringSafeArea(.horizontal)
                Spacer()
            }.frame(width: 224)
        }
    }
}

struct CesarsCipherView_Previews: PreviewProvider {
    static var previews: some View {
        CesarsCipherView()
    }
}
