//
//  Testable+extensions.swift
//  
//
//  Created by Jeremy Bannister on 12/9/21.
//

///
public extension Testable where Self: VerboseEquatable {
    
    ///
    @discardableResult
    func assertVerboseEqualTo (_ value: ()->Self) throws -> Self {
        try self.assertVerboseEqual(to: value())
    }
    
    ///
    @discardableResult
    func assertVerboseEqual (to other: Self) throws -> Self {
        try verboseCompare(self, to: other)
        return self
    }
}

///
fileprivate extension Testable {
    
    ///
    func verboseCompare <Value: VerboseEquatable> (_ lhs: Value, to rhs: Value) throws {
        do {
            try lhs.verboseEquals(rhs)
            
        } catch let error as VerboseEqualityError {
            
            throw ErrorMessage("Not equal: [\n\(error.discrepancies.reduce(into: "") { $0 += "\\.\($1.keyPath.joined(separator: ".")): (\($1.lhsDescription), \($1.rhsDescription))\n" })]")
            
        } catch {
            throw ErrorMessage("Not equal: (\(lhs), \(rhs))")
        }
    }
}

///
public extension Testable {
    
    ///
    @discardableResult
    func assert <Value: VerboseEquatable> (_ keyPath: KeyPath<Self, Value>,
                                           verboseEquals value: Value) throws -> Self {
        
        try verboseCompare(self[keyPath: keyPath], to: value)
        return self
    }
}
