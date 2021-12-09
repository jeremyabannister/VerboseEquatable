//
//  VerboseEqualityError.swift
//  
//
//  Created by Jeremy Bannister on 12/9/21.
//

///
public struct VerboseEqualityError: ProperValueType,
                                    Error {
    
    ///
    public var discrepancies: [Discrepancy]
    
    ///
    public init (discrepancies: [Discrepancy]) {
        self.discrepancies = discrepancies
    }
}

///
public extension VerboseEqualityError {
    
    ///
    func nested (under propertyName: String) -> VerboseEqualityError {
        self.mutated { nestedResult in
            discrepancies.indices.forEach { index in
                let unnestedKeyPath = discrepancies[index].keyPath
                nestedResult.discrepancies[index].keyPath = [propertyName] + unnestedKeyPath
            }
        }
    }
}

///
public extension VerboseEqualityError {
    
    ///
    static func unequal (lhsDescription: String,
                         rhsDescription: String) -> Self {
        .init(
            discrepancies: [
                .init(
                    keyPath: [],
                    lhsDescription: lhsDescription,
                    rhsDescription: rhsDescription
                )
            ]
        )
    }
}

///
public extension VerboseEqualityError {
    
    ///
    struct Discrepancy: ProperValueType {
        
        ///
        public var keyPath: [String]
        
        ///
        public var lhsDescription: String
        
        ///
        public var rhsDescription: String
        
        ///
        public init (keyPath: [String],
                     lhsDescription: String,
                     rhsDescription: String) {
            
            self.keyPath = keyPath
            self.lhsDescription = lhsDescription
            self.rhsDescription = rhsDescription
        }
    }
}
