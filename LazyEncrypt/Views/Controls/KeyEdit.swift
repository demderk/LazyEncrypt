//
//  KeyEdit.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 08.03.2023.
//

import SwiftUI

struct KeyEdit: View {
    var keyEncryption: KeyEncryption
    
    var onSuccess: (() -> Void)?
    
    @State private var key: String = ""
    @State private var keyError: String?
    @State private var wrongAttempts: Double = 0
    @State private var keyCheckTimer: Timer?

    var body: some View {
        VStack(){
            VStack{
                TextEditor(text: $key)
                    .frame(height: 96)
                    .padding(.horizontal,2)
                    .padding(.vertical,5)
                    .font(.body)
                    .onChange(of: key, perform: { _ in
                        keyCheckTimer?.invalidate()
                        keyCheckTimer = .scheduledTimer(withTimeInterval: 1.0, repeats: false, block: timerTest)
                        keyCheckTimer?.tolerance = 0.5
                        
                    })
            }.border(.gray)
                .background(.white)
            Spacer().frame(height: 4)
            HStack(alignment: .center){
                Text(keyError ?? "Key is correct")
                    .foregroundColor(keyError == nil ? .black : Color("LabelRed"))
                Spacer()
                Image(systemName: keyError == nil ? "checkmark" : "xmark")
                    .font(.system(size: 11,weight: .medium))
                    .foregroundColor(keyError == nil ? Color("LabelGreen") : Color("LabelRed"))
            }

            .modifier(Shake(amount: 8, shakesPerUnit: 3, animatableData: CGFloat(wrongAttempts)))
            
        }.frame(minWidth: 200,alignment: .trailing)
    }
    
    func timerTest(t: Timer) {
        withAnimation(.linear(duration: 0.20)){
            do{
                try keyEncryption.setKey(key)
                keyError = nil
                onSuccess?()
            } catch let error as EncryptionError{
                wrongAttempts += 1
                keyError = error.localizedDescription
            }
            catch {
                keyError = String(localized: "Unexpected error")
            }
        }
    }
    
}


struct KeyEdit_Previews: PreviewProvider {
    static var previews: some View {
        KeyEdit(keyEncryption: RichelieuCipher())
    }
}
