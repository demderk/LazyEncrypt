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
    
    @State var temp: CGFloat = 214
    
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
                Text("Cipher Config")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .frame(minWidth: 200,alignment: .leading)
                    .padding(8)
                Spacer().frame(height: 0)
                HStack(){
                    Text("Cipher Shift")
                        .font(.caption)
                    Spacer().frame(width: 4)
                    TextField("\(vm.shift)", value: $vm.shift, formatter: NumberFormatter())
                        .frame(width: 48)
                        .multilineTextAlignment(.trailing)
                        .onChange(of: vm.shift, perform: {_ in
                            vm.cipher.shift = vm.shift
                            evm.translate()
                        })
                    Spacer().frame(width: 2)
                    Stepper(value: $vm.shift, label: {})
                }.frame(minWidth: 200,alignment: .trailing)
                Rectangle()
                    .fill(.gray)
                    .opacity(0.3)
                    .frame(minWidth: 214, minHeight: 1, maxHeight: 1)
                    .edgesIgnoringSafeArea(.horizontal)
                Spacer()
            }.offset(x: 214-temp).frame(width: temp)
        }.toolbar{
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)){
                    if (temp > 0) {
                        temp = 0
                    }
                    else {
                        temp = 214
                    }
                }
            }, label: {Image(systemName: "sidebar.trailing")})
        }
    }
}

struct CesarsCipherView_Previews: PreviewProvider {
    static var previews: some View {
        CesarsCipherView()
    }
}
