//
//  MainViewE.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 25.03.2023.
//

import Foundation
import SwiftUI

enum MainWindowPage: CaseIterable, Identifiable{
    case home
    case atbash
    case cesars
    case richelieu
    case gronsfeld
    case vigenere
    
    var id: Self{
        return self
    }
    
    @ViewBuilder var view: some View {
        switch self {
        case .atbash:
            AtbashCipherView()
        case .cesars:
            CesarsCipherView()
        case .richelieu:
            RichelieuCipherView()
        case .gronsfeld:
            GronsfeldCipherView()
        case .vigenere:
            VigenereCipherView()
        default:
            Text("No Editor")
                .foregroundColor(.gray)
                .font(.title2)
                .frame(minWidth: 512)
        }
    }
    
    var name: String {
        switch self {
        case .home:
            return "Home Page"
        case .atbash:
            return "The Atbash Cipher"
        case .cesars:
            return "The Caesar's Cipher"
        case .richelieu:
            return "The Richelieu's Cipher"
        case .gronsfeld:
            return "The Gronsfeld's Cipher"
        case .vigenere:
            return "The Vigenere's Cipher"
        }
    }
    
    var image: Image {
        switch self {
        case .home:
            return Image(systemName: "house")
        case .atbash:
            return Image(systemName: "arrow.left.arrow.right")
        case .cesars:
            return Image(systemName: "arrow.right.square")
        case .richelieu:
            return Image(systemName: "123.rectangle")
        case .gronsfeld:
            return Image(systemName: "arrow.down.app")
        case .vigenere:
            return Image(systemName: "abc")
        }
    }
}
