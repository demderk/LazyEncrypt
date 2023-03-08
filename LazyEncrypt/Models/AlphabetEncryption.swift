//
//  AlphabetEncryption.swift
//  LazyEncrypt
//
//  Created by Roman Zheglov on 05.03.2023.
//

import Foundation

protocol AlphabetEncryption : TextEncyption {
    var alphabets: [[Character]] {get set}
}

