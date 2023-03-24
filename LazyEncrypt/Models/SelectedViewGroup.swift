//
//  SelectedViewGroup.swift
//  Crypt1
//
//  Created by Roman Zheglov on 15.02.2023.
//

import Foundation

struct SelectedViewGroup: Identifiable{
    var id = UUID()
    var name: String
    var items: [MainWindowPage]
}
