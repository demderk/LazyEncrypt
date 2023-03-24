import Foundation

enum VigenereCipherError: EncryptionError {
    case notImplemented
    case keySyntaxError
    case keySymbolUnsupported(char: Character)
    
    var errorDescription: String? {
        switch self {
        case .notImplemented:
            return "Function not implemented"
        case .keySyntaxError:
            return "Syntax error"
        case .keySymbolUnsupported(let char):
            return "Key symbol \"\(char)\" unsupported"
        }
        
    }
}

class VigenereCipher: AlphabetEncryption, KeyEncryption {
    
    public var skipNonAlphabetSymbols = true
    
    var alphabets: [[Character]] = [Array("abcdefghijklmnopqrstuvwxyz"), Array("абвгдеёжзийклмнопрстуфхцчшщъыьэюя")]
    private var key: [Int] = [0]
    
    private func EncryptWithKey(_ data: String, _ encryptKey: [Int]) -> String {
        var result = ""
        guard encryptKey.count > 0 else{
            return data
        }
        var at = 0
        for item in data {
            let currentKeyShift = encryptKey[at%encryptKey.count]
            if let alphabet = alphabets.first(where: {x in x.contains(Character(item.lowercased()))}) {
                if let charIndex = alphabet.firstIndex(of: Character(item.lowercased())) {
                    let index = (charIndex + currentKeyShift) % alphabet.count < 0 ?
                    (charIndex + currentKeyShift) % alphabet.count + alphabet.count :
                    (charIndex + currentKeyShift) % alphabet.count
                    result.append(item.isUppercase ? Character(alphabet[index].uppercased()) : alphabet[index])
                    at += 1
                }
            }
            else {
                result.append(item)
                at += skipNonAlphabetSymbols ? 0 : 1
            }
        }
        return result
    }
    
    func indexSearch(_ char: Character) throws -> Int {
        for alphabet in alphabets {
            if let index = alphabet.firstIndex(of: char) {
                return index
            }
        }
        throw VigenereCipherError.keySymbolUnsupported(char: char)
    }
    
    func setKey(_ key: String) throws {
        let input = key.lowercased()
        var result: [Int] = []
        for i in input{
            result.append(try indexSearch(i))
        }
        self.key = result
    }
    
    func EncryptText(_ data: String) throws -> String {
        return EncryptWithKey(data, key)
    }
    
    func DecryptText(_ data: String) throws -> String {
        return EncryptWithKey(data, key.map({$0 * -1}))
    }
}

