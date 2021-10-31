import UIKit

enum Nucleotide: Character, Comparable {
    case A = "A"
    case C = "C"
    case G = "G"
    case T = "T"
    
    // Implementing Comparable:
    // Nucleotide.A < Nucleotide.G would give true
    static func <(lhs: Nucleotide, rhs: Nucleotide) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

typealias Codon = (Nucleotide, Nucleotide, Nucleotide)
typealias Gene = [Codon]

// Takes a string of Nucleotides and returns a Gene
func stringToGene(_ s: String) -> Gene {
    var gene = Gene()
    
    for i in stride(from: 0, to: s.count, by: 3) {
            guard (i + 2) < s.count else { return gene }
            
        if let n1 = Nucleotide.init(rawValue: s[s.index(s.startIndex, offsetBy: i)]),
        let n2 = Nucleotide.init(rawValue: s[s.index(s.startIndex, offsetBy: i + 1)]),
        let n3 = Nucleotide.init(rawValue: s[s.index(s.startIndex,offsetBy: i + 2)]) {
            gene.append((n1, n2, n3))
        }
    }
    return gene
}


let geneSequence = "ACGTGGCTCTCTAACGTACGTACGTACGGGGTTTATATATACCCTAGGACTCCCTTT"
let gene = stringToGene(geneSequence)

// print("~~~~~ ~~~~~ ~~~~~")

// Takes a position and a String of Nucleotides and returns the codon.
func returnCodon(at position: Int, of str: String ) -> Codon {
    
    guard (position + 2) < str.count else { fatalError("Not enough nucleotides.")}
    
    if let n1 = Nucleotide.init(rawValue: str[str.index(str.startIndex, offsetBy: position)]),
       let n2 = Nucleotide.init(rawValue: str[str.index(str.startIndex, offsetBy: position+1)]),
       let n3 = Nucleotide.init(rawValue: str[str.index(str.startIndex, offsetBy: position+2)]) {
        return (n1, n2, n3)
    }
    fatalError("Error in the sequence.")
}

// print(returnCodon(at: 5, of: geneSequence))

// print("~~~~~ ~~~~~ ~~~~~")

// Linear Search of a Codon
func linearContains(_ array: Gene, item: Codon) -> Bool {
    for element in array where element == item {
        return true
    }
    return false
}

linearContains(gene, item: (.A, .C, .G))
linearContains(gene, item: (.A, .A, .A))



func binaryContains(_ sortedArray: Gene, item: Codon) -> Bool {
    var low = 0
    var high = sortedArray.count - 1
    
    while low < high {
        let mid = (low + high) / 2
        
        if sortedArray[mid] < item {
            low = mid + 1
        } else if sortedArray[mid] > item {
            high = mid - 1
        } else {
            return true
        }
    }
    return false
}

let sortedGene = gene.sorted(by: <)
binaryContains(sortedGene, item: (.A, .C, .G))
binaryContains(sortedGene, item: (.A, .A, .A))
