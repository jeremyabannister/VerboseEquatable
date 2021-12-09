//
//  AtomicallyEquatable.swift
//  
//
//  Created by Jeremy Bannister on 12/9/21.
//

///
public protocol AtomicallyEquatable: VerboseEquatable {
    
}

///
public extension AtomicallyEquatable {
    
    ///
    var equalityCheck: EqualityCheck<Self> {
        EqualityCheck(self)
            .addingCheck { rhs in
                if self != rhs {
                    throw VerboseEqualityError.unequal(
                        lhsDescription: "\(self)",
                        rhsDescription: "\(rhs)"
                    )
                }
            }
    }
}
