import UIKit

print("\n~~~ Let's compress a 8bit String to a 2bit BitString using CFMutableBitVector ~~~\n")

struct CompressedGene {
    let length: Int
    private let bitVector: CFMutableBitVector
    
    // we initialize the bitVector with the needed length, then we initialize it to 0
    // then we call the encoding function
    init(original: String) {
        length = original.count
        // the default allocator needs 2 bits per nucleotide (A | C | G | T)
        // so if using kCFAllocatorDefault give a capacity of length * 2
        bitVector = CFBitVectorCreateMutable(kCFAllocatorDefault, length * 2)
        // setting the size of the bitVector and setting its bits to 0
        CFBitVectorSetCount(bitVector, length * 2)
        compress(gene: original)
    }
    
    // encoding a String to a 2bit bitString
    private func compress(gene: String) {
        for (index, nucleotide) in gene.uppercased().enumerated() {
            let nStart = index * 2 // starting index of each nucleotide
            
            switch nucleotide {
            case "A": // 00
            CFBitVectorSetBitAtIndex(bitVector, nStart, 0)
            CFBitVectorSetBitAtIndex(bitVector, nStart + 1, 0)
            case "C": // 01
                CFBitVectorSetBitAtIndex(bitVector, nStart, 0)
                CFBitVectorSetBitAtIndex(bitVector, nStart + 1, 1)
            case "G": // 10
                CFBitVectorSetBitAtIndex(bitVector, nStart, 1)
                CFBitVectorSetBitAtIndex(bitVector, nStart + 1, 0)
            case "T": // 11
                CFBitVectorSetBitAtIndex(bitVector, nStart, 1)
                CFBitVectorSetBitAtIndex(bitVector, nStart + 1, 1)
            default:
                print("Unexpected character \(nucleotide) at \(index).")
            }
        }
    }
    
    // decoding a 2bit bitString to a String (8bit)
    func decompress() -> String {
        var gene: String = ""
        for index in 0 ..< length {
            let nStart = index * 2
            let firstBit = CFBitVectorGetBitAtIndex(bitVector, nStart)
            let secondBit = CFBitVectorGetBitAtIndex(bitVector, nStart + 1)
            
            switch (firstBit, secondBit) {
            case (0, 0): // A
                gene += "A"
            case (0, 1): // C
                gene += "C"
            case (1, 0): // G
                gene += "G"
            case (1, 1): // T
                gene += "T"
            default:
                break
            }
        }
        return gene
    }
}

let myGene = CompressedGene(original: "ATAACCGGTAATTACG")
print(myGene)
let myDecodedGene = myGene.decompress()
print(myDecodedGene)

