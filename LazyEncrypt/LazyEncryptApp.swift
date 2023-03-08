//
//  Crypt1App.swift
//  Crypt1
//
//  Created by Roman Zheglov on 07.02.2023.
//

import SwiftUI
import Foundation
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

@main
struct LazyEncryptApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainWindow()
        }.commands{
            SidebarCommands()
        }
    }
}
