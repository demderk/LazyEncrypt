//
//  MainWindowVM.swift
//  Crypt1
//
//  Created by Roman Zheglov on 15.02.2023.
//

import Foundation
import SwiftUI

struct MainViewGroup: Identifiable{
    var id = UUID()
    var name: String
    var items: [MainWindowPage]
}

class MainWindowVM: ObservableObject {
    
    
    @Published private(set) var list: [MainViewGroup]
    @Published public var sidebarSelectedItem: MainWindowPage = .home
    @Published var cesarsShift: Int = 3
    
    public var windowTitle:String {
        return sidebarSelectedItem.name 
    }
    
    init() {
        list = [MainViewGroup(name: "", items: [.home]),
                MainViewGroup(name: "Base cryptography", items: [.atbash,.cesars,.richelieu]),
                MainViewGroup(name: "Advanced cryptography", items: [.gronsfeld, .vigenere])]
    }
    
}
