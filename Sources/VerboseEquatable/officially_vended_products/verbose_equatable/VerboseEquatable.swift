//
//  VerboseEquatable.swift
//  
//
//  Created by Jeremy Bannister on 12/9/21.
//

///
public protocol VerboseEquatable: Equatable {
    
    ///
    static var typeName: String { get }
    
    ///
    var equalityCheck: EqualityCheck<Self> { get }
}

///
public extension VerboseEquatable {
    
    ///
    static var typeName: String { "\(Self.self)" }
    
    ///
    func verboseEquals (_ other: Self) throws {
        try self.equalityCheck.checkAgainst(other)
    }
}
