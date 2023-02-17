//
//  EditableEncyption.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 17.02.2023.
//

import Foundation

protocol TextEncyption{
    func EncryptText(data: String) -> String
    func DecryptText(data: String) -> String
}
