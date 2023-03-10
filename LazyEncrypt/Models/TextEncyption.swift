//
//  EditableEncyption.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 17.02.2023.
//

import Foundation

protocol TextEncyption{
    func EncryptText(_ data: String) throws -> String
    func DecryptText(_ data: String) throws -> String
}
