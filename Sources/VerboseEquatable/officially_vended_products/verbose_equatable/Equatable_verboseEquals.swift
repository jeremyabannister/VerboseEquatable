//
//  Equatable_verboseEquals.swift
//  
//
//  Created by Jeremy Bannister on 12/9/21.
//

///
public extension Equatable {

    ///
    func verboseEquals (_ other: Self) throws {
        if self != other {
            throw VerboseEqualityError.unequal(
                lhsDescription: "\(self)",
                rhsDescription: "\(other)"
            )
        }
    }
}
