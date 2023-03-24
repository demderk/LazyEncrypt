//
//  AtbashCipherView.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 15.02.2023.
//

import SwiftUI

struct EncryptedTextEdit<SettingsContent: View>: View {
    @StateObject private var vm: EncryptedTextEditVM
    @State private var rightBarOffset: CGFloat = 256
    /*
     (EncryptedTextEditVM) -> SettingsContent is necessary (contain func not View). We need to send updated viewmodel every time when settingsPaneContent updated.
     Look's like bug. Will be solved in new versions.
     */
    @ViewBuilder private var settingsPaneContent: (EncryptedTextEditVM) -> SettingsContent
    @State var settingsPaneDisabled: Bool = false
    
    init(_ encryptionProvider: TextEncyption, @ViewBuilder settingsPane: @escaping (EncryptedTextEditVM) -> SettingsContent) {
        let viewModel = EncryptedTextEditVM(encryptProvider: encryptionProvider)
        _vm = StateObject(wrappedValue: viewModel)
        self.settingsPaneContent = settingsPane
    }
    
    var body: some View {
        HStack {
            VStack{
                HStack{
                    Text(vm.firstModeName)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .frame(minWidth: 256, maxWidth: .infinity)
                        .transition(.opacity)
                    Spacer()
                    Button(action: changeMode){
                        Image(systemName: "arrow.left.arrow.right")
                            .font(.body)
                            .padding(.horizontal,12)
                            .padding(.vertical,4)
                            .background(Color("lightGrayPlainButton"))
                            .cornerRadius(8)
                    }.frame(alignment: .center)
                        .buttonStyle(.plain)
                    Spacer()
                    Text(vm.secondModeName)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .frame(minWidth: 256, maxWidth: .infinity)
                    Spacer()
                }.padding(16)
                    .background(Color(nsColor: .controlBackgroundColor))
                Spacer().frame(height: 0)
                // Divider
                Rectangle()
                    .fill(.gray)
                    .opacity(0.3)
                    .frame(minWidth: 608, minHeight: 1, maxHeight: 1)
                    .edgesIgnoringSafeArea(.horizontal)
                Spacer().frame(height: 0)
                HStack{
                    TextEditor(text: $vm.inputText)
                        .font(.body)
                        .padding(16)
                        .scrollContentBackground(.hidden)
                        .background(Color(nsColor: .controlBackgroundColor))
                        .frame(minWidth: 304)
                        .onChange(of: vm.inputText, perform: { _ in
                            vm.translate()
                        })
                    Spacer()
                        .frame(width: 0)
                    ZStack{
                        ScrollView{
                            Text(vm.errorMessage == nil ? vm.outputText : "")
                                .font(.body)
                                .textSelection(.enabled)
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .animation(nil, value: UUID())
                                .frame(alignment: .topLeading)
                        }.padding(16)
                            .background(vm.errorMessage == nil ? Color("lightGrayBackground") : Color("lightGrayBackgroundError"))
                            .frame(minWidth: 304)
                        if let errorMsg = vm.errorMessage{
                            HStack(alignment: .top){
                                Image(systemName: "xmark.octagon.fill")
                                    .font(.system(size: 32))
                                    .padding(.top,2)
                                Spacer().frame(width: 8)
                                VStack(alignment: .leading){
                                    Text("An error has occurred")
                                        .font(.title)
                                    Text(errorMsg)
                                        .font(.body)
                                }
                                Spacer()
                            }.foregroundColor(Color("LabelRed"))
                                .padding(.bottom,64)
                                .padding(.horizontal,16)
                                .frame(alignment: .leading)
                                .frame(minWidth: 280, alignment: .leading)
                        }
                    }
                }
            }
            Spacer().frame(width: 0)
            Divider()
            Spacer().frame(width: 0)
            if (!settingsPaneDisabled) {
                VStack() {
                    if let keyEncryption = vm.encryptProvider as? KeyEncryption{
                        SettingsGroup(title: "Cipher Key"){
                            KeyEdit(keyEncryption: keyEncryption) {
                                vm.translate()
                            }
                        }.padding([.horizontal,.top],8)
                    }
                    settingsPaneContent(vm).padding(.horizontal,8)
                    Spacer()
                }.offset(x: 256-rightBarOffset).frame(width: rightBarOffset)
            }
        }.toolbar{
            if (!settingsPaneDisabled) {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.2)){
                        if (rightBarOffset > 0) {
                            rightBarOffset = 0
                        }
                        else {
                            rightBarOffset = 256
                        }
                    }
                }, label: {Image(systemName: "sidebar.trailing")})
            }
        }
    }
    
    func settingsPaneIsHidden(_ disabled: Bool) -> some View {
        self.settingsPaneDisabled = true
        return self
    }
    
    func changeMode() {
        withAnimation(.easeOut(duration: 0.2))
        {
            vm.swapMode()
            vm.isEncrypting = !vm.isEncrypting
        }
    }
}

extension EncryptedTextEdit where SettingsContent == EmptyView{
    init(_ encyptionProvider: TextEncyption) {
        self.init(encyptionProvider) {_ in
            
        }
    }
    
    init(_ encyptionProvider: TextEncyption, settingsHidden: Bool) {
        self.init(encyptionProvider) {_ in
            
        }
        self.settingsPaneDisabled = settingsHidden
    }
}

struct EncryptedTextEditView_Previews: PreviewProvider {
    static var previews: some View {
        EncryptedTextEdit(RichelieuCipher())
    }
}
