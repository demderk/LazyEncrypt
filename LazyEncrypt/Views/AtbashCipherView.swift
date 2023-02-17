//
//  AtbashCipherView.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 15.02.2023.
//

import SwiftUI

struct AtbashCipherView: View {
    @ObservedObject var vm = AtbashCipherVM()
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Text(vm.firstModeName)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(width: 256)
                    .transition(.opacity)
                Spacer()
                Button(action: changeMode){
                    Image(systemName: "arrow.left.arrow.right")
                        .font(.body)
                        .padding(.horizontal,12)
                        .padding(.vertical,4)
                        .background(Color(CGColor(gray: 0.925, alpha: 1)))
                        .cornerRadius(8)
                }
                .buttonStyle(.plain)
                Spacer()
                Text(vm.secondModeName)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(width: 256)
                Spacer()
            }.padding(16).background(.white)
            
            Spacer().frame(height: 0)
            Divider()
            Spacer().frame(height: 0)
            HStack{
                TextEditor(text: $vm.inputText)
                    .font(.body)
                    .padding(16)
                    .background(.white)
                    .onChange(of: vm.inputText, perform: { _ in
                        vm.performEncrypt()
                    })
                Spacer()
                    .frame(width: 0)
                ScrollView{
                    Text(vm.outputText)
                        .font(.body)
                        .textSelection(.enabled)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .animation(nil, value: UUID())
                }.padding(16)
                    .background(Color(CGColor(gray: 0.97, alpha: 1)))
            }
        }
    }
    
    func changeMode() {
        withAnimation(.easeOut(duration: 0.2))
        {
            vm.swapMode()
        }
    }
}


struct AtbashCipherView_Previews: PreviewProvider {
    static var previews: some View {
        AtbashCipherView()
    }
}
