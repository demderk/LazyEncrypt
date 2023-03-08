//
//  SwiftUIView.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 03.03.2023.
//

import SwiftUI

struct RichelieuCipherView: View {
    private var encryption = RichelieuCipher()
    private var evm: EncryptedTextEditVM
    @State var keyCheckTimer: Timer?
    @State var rightBarOffset: CGFloat = 214
    @State var editorKey = ""
    @State var keyError: String?
    @State var wrongAttempts: Double = 0
    
    init() {
        evm = EncryptedTextEditVM(encryptProvider: encryption)
        
    }
    
    var body: some View {
        HStack {
            EncryptedTextEditView(vm: evm)
            Spacer().frame(width: 0)
            Divider()
            Spacer().frame(width: 0)
            VStack() {
                Text("Cipher Key")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .frame(minWidth: 200,alignment: .leading)
                    .padding(8)
                Spacer().frame(height: 0)
                VStack(){
                    VStack{
                        TextEditor(text: $editorKey)
                            .frame(height: 96)
                            .padding(.horizontal,2)
                            .padding(.vertical,5)
                            .font(.body)
                            .onChange(of: editorKey, perform: { _ in
                                keyCheckTimer?.invalidate()
                                keyCheckTimer = .scheduledTimer(withTimeInterval: 1.0, repeats: false, block: timerTest)
                                keyCheckTimer?.tolerance = 0.5
                                
                            })
                    }.border(.gray)
                        .background(.white)
                        .padding(.horizontal, 8)
                    Spacer().frame(height: 4)
                    HStack(alignment: .center){
                        Text(keyError ?? "Key is correct")
                            .foregroundColor(keyError == nil ? .black : Color("LabelRed"))
                        Spacer()
                        Image(systemName: keyError == nil ? "checkmark" : "xmark")
                            .font(.system(size: 11,weight: .medium))
                            .foregroundColor(keyError == nil ? Color("LabelGreen") : Color("LabelRed"))
                    }
                    .frame(width: 200)
                    .modifier(Shake(amount: 8, shakesPerUnit: 3, animatableData: CGFloat(wrongAttempts)))
                    
                }.frame(minWidth: 200,alignment: .trailing)
                Rectangle()
                    .fill(.gray)
                    .opacity(0.3)
                    .frame(minWidth: 214, minHeight: 1, maxHeight: 1)
                    .edgesIgnoringSafeArea(.horizontal)
                Spacer()
            }.offset(x: 214-rightBarOffset).frame(width: rightBarOffset)
        }.toolbar{
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)){
                    if (rightBarOffset > 0) {
                        rightBarOffset = 0
                    }
                    else {
                        rightBarOffset = 214
                    }
                }
            }, label: {Image(systemName: "sidebar.trailing")})
        }
    }
    
    func timerTest(t: Timer) {
        withAnimation(.linear(duration: 0.20)){
            do{
                try encryption.parseKey(editorKey)
                keyError = nil
                evm.translate()
            } catch let error as RichelieuError{
                wrongAttempts += 1
                keyError = error.localizedDescription
            }
            catch {
                keyError = String(localized: "Unexpected error")
            }
        }
    }
}
struct RichelieuCipherView_Previews: PreviewProvider {
    static var previews: some View {
        RichelieuCipherView()
    }
}
