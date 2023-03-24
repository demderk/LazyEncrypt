//
//  SelectedViewItem.swift
//  Crypt1
//
//  Created by Roman Zheglov on 15.02.2023.
//

import Foundation
import SwiftUI

struct SelectedViewItem: Identifiable, Hashable{
    static func == (lhs: SelectedViewItem, rhs: SelectedViewItem) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID()
    var name: String
    var image: Image
    var body: AnyView = AnyView(Text("No Editor"))
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}
