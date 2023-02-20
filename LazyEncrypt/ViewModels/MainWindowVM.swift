//
//  MainWindowVM.swift
//  Crypt1
//
//  Created by Roman Zheglov on 15.02.2023.
//

import Foundation
import SwiftUI

class MainWindowVM: ObservableObject {
    
    @Published private(set) var list: [SelectedViewGroup]
    @Published public var sidebarSelectedItem: SelectedViewItem? = nil
    
    
    public var windowTitle:String {
        return sidebarSelectedItem?.name ?? "LazyEncrypt"
    }
    
    init() {
        let mainWindowItem = SelectedViewItem(name: String(localized: "Home Page"), image: Image(systemName: "house"))
        list = [
            SelectedViewGroup(name: "", items: [
                mainWindowItem
            ]),
            SelectedViewGroup(name: String(localized: "Base cryptography"), items: [
                SelectedViewItem(name: String(localized: "The Atbash Cipher"), image: Image(systemName: "arrow.left.arrow.right")),
                SelectedViewItem(name: String(localized: "The Caesar's Cipher"), image: Image(systemName: "arrow.right.square")),
                //                SelectedViewItem(name: String(localized: "The Richelieu Cipher"), image: Image(systemName: "123.rectangle"))
            ])
        ]
    }
    
}
