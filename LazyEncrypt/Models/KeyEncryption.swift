//
//  KeyEncryption.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 08.03.2023.
//

import Foundation

protocol KeyEncryption {
    func setKey(_ key: String) throws
}
