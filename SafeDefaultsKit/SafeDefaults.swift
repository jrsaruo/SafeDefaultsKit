//
//  SafeDefaults.swift
//  SafeDefaultsKit
//
//  Created by Yusaku Nishi on 2017/12/19.
//

import Foundation

// MARK: - DefaultsKey -
/// A type that can be used as a key for SafeDefaults.
public protocol DefaultsKey: RawRepresentable where Self.RawValue == String {
    /// The unique value used as key for UserDefaults. This value should be entirely unique in the module.
    /// Default is raw value.
    var uniqueValue: String { get }
}

public extension DefaultsKey {
    
    var uniqueValue: String {
        return self.rawValue
    }
    
}

// MARK: - SafeDefaults -
/// A type that enables safe access to UserDefaults.
public protocol SafeDefaults {
    /// Key set for SafeDefaults.
    associatedtype Keys: DefaultsKey
}
