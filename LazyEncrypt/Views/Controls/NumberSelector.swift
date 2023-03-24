//
//  NumberSelector.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 08.03.2023.
//

import SwiftUI

struct NumberSelector: View, Identifiable {
    var id = UUID()
    
    
    var title: String
    @Binding var number: Int
    
    var onNumberChange: (() -> Void)?
    
    var body: some View {
        HStack(){
            Text(title)
                .font(.caption)
            Spacer().frame(width: 4)
            TextField("\(number)", value: $number, formatter: NumberFormatter())
                .frame(width: 48)
                .multilineTextAlignment(.trailing)
                .onChange(of: number, perform: {_ in
                    onNumberChange?()
                })
            Spacer().frame(width: 0)
            Stepper(value: $number, label: {}).offset(y: -1)
        }.frame(minWidth: 200,alignment: .trailing)
    }
}

struct NumberSelector_Previews: PreviewProvider {
    static var previews: some View {
        NumberSelector(title: "Cipher Shift", number: .constant(15))
    }
}
