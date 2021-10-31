import UIKit

// One-Time Pad (OTP)  encryption
// Strings can be considered as sequences of UTF-8 bytes or of UInt8
// so that each UTF-8 byte is represented by one UInt8.

typealias OTPKey = [UInt8]
typealias OTPKeyPair = (key1: OTPKey, key2: OTPKey)

// let's create an array of (pseudo)random numbers (OTPKeys)
func randomOTPKey(length: Int) -> OTPKey {
    var randomKey: OTPKey = OTPKey() // initialization
    
    for _ in 0 ..< length {
        let randomKeyPoint = UInt8(arc4random_uniform(UInt32(UInt8.max)))
        randomKey.append(randomKeyPoint)
    }
    return randomKey
}

// print(randomOTPKey(length: 5))

// Encrypting a string to get an OTPKeyPair
// ^ is XOR: 0^0 and 1^1 = 0, 0^1 and 1^0 = 1
func encryptOTP(original: String) -> OTPKeyPair {
    let dummy = randomOTPKey(length: original.utf8.count)
    let encrypted: OTPKey = dummy.enumerated().map { i, e in
        return e ^ original.utf8[original.utf8.index(original.utf8.startIndex, offsetBy: i)]
    }
    return (dummy, encrypted)
}

// print("encrypting 'Hello': \(encryptOTP(original: "Hello")).")

func decryptOTP(keyPair: OTPKeyPair) -> String? {
    let decrypted: OTPKey = keyPair.key1.enumerated().map { i, e in
        e ^ keyPair.key2[i]
    }
    return String(bytes: decrypted, encoding: String.Encoding.utf8)
}

let myPhrase = "Hello World - Hello Swift!"
let encryptedPhrase = encryptOTP(original: myPhrase)
let decryptedPhrase = decryptOTP(keyPair: encryptedPhrase)
print("""

 Original:   \(myPhrase)
 Encrypted:  \(encryptedPhrase)
 Decrypted:  \(decryptedPhrase!)
 
 """)
