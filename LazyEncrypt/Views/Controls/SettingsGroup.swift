//
//  SettingsGroup.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 08.03.2023.
//

import SwiftUI

struct SettingsGroup<Content: View>: View {
    var title:String
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        VStack(alignment: .trailing){
            HStack{
                Text(title)
                    .font(.headline)
                    .foregroundColor(.gray)
                    .frame(minWidth: 200,alignment: .leading)
                    .padding(.bottom,8)
                Spacer()
            }
            Spacer().frame(height: 0)
            content().frame(alignment: .trailing)
            Rectangle()
                .fill(.gray)
                .opacity(0.3)
                .frame(minWidth: 200, minHeight: 1, maxHeight: 1)
                .edgesIgnoringSafeArea(.horizontal)
        }
    }
}

struct SettingsGroup_Previews: PreviewProvider {
    static var previews: some View {
        SettingsGroup(title: "Settings Group Name"){
            
        }
    }
}
