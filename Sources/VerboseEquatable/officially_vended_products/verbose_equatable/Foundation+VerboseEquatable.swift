//
//  Foundation+VerboseEquatable.swift
//  
//
//  Created by Jeremy Bannister on 12/9/21.
//

///
extension Bool: AtomicallyEquatable { }
extension Data: AtomicallyEquatable { }
extension Double: AtomicallyEquatable { }
extension Int: AtomicallyEquatable { }
extension String: AtomicallyEquatable { }
extension UInt: AtomicallyEquatable { }
extension UUID: AtomicallyEquatable { }

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

///
extension ClosedRange: VerboseEquatable where Bound: VerboseEquatable {
    
    ///
    public var equalityCheck: EqualityCheck<Self> {
        EqualityCheck(self)
            .compare(\.lowerBound, "lowerBound")
            .compare(\.upperBound, "upperBound")
    }
}

///
extension Optional: VerboseEquatable where Wrapped: VerboseEquatable {
    
    ///
    public var equalityCheck: EqualityCheck<Self> {
        EqualityCheck(self)
            .compare(\.isNil, "isNil")
            .addingCheck {
                if let lhs = self,
                   let rhs = $0 {
                    try lhs.verboseEquals(rhs)
                }
            }
    }
}

///
extension Array: VerboseEquatable where Element: VerboseEquatable {
    
    ///
    public static var typeName: String { "Array<\(Element.self)>" }   
}

///
public extension Array where Element: VerboseEquatable {
    
    ///
    var equalityCheck: EqualityCheck<Self> {
        EqualityCheck(self)
            .compare(\.count, "count")
            .mutated { check in
                self.forEachWithIndex { index, element in
                    check = check.compare(\.[safely: index], "[\(index)]")
                }
            }
    }
}

///
extension Dictionary: VerboseEquatable where Key: VerboseEquatable,
                                             Value: VerboseEquatable {
    
    ///
    public var equalityCheck: EqualityCheck<Self> {
        EqualityCheck(self)
            .compare(\.keys, "keys")
            .mutated { check in
                self.forEach { key, value in
                    check = check.compare(\.[key], "[\(key)]")
                }
            }
    }
}

///
extension Dictionary.Keys: VerboseEquatable where Key: VerboseEquatable {
    
    ///
    public var equalityCheck: EqualityCheck<Self> {
        .mapping(self, { $0.asSet() })
    }
}

///
extension Set: VerboseEquatable where Element: VerboseEquatable {
    
    ///
    public static var typeName: String { "Set<\(Element.self)>" }
    
    ///
    public var equalityCheck: EqualityCheck<Self> {
        EqualityCheck(self).addingCheck { rhs in
            try self.subtracting(rhs).asArray
                .equalityCheck
                .checkAgainst(
                    rhs.subtracting(self).asArray
                )
        }
    }
}
