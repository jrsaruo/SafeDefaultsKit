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

public extension SafeDefaults {
    
    // MARK: - get -
    public func array(forKey key: Self.Keys) -> [Any]? {
        return UserDefaults.standard.array(forKey: key.uniqueValue)
    }
    
    public func bool(forKey key: Self.Keys) -> Bool {
        return UserDefaults.standard.bool(forKey: key.uniqueValue)
    }
    
    public func data(forKey key: Self.Keys) -> Data? {
        return UserDefaults.standard.data(forKey: key.uniqueValue)
    }
    
    public func double(forKey key: Self.Keys) -> Double? {
        let defaults = UserDefaults.standard
        guard defaults.object(forKey: key.uniqueValue) != nil else { return nil }
        return defaults.double(forKey: key.uniqueValue)
    }
    
    public func float(forKey key: Self.Keys) -> Float? {
        let defaults = UserDefaults.standard
        guard defaults.object(forKey: key.uniqueValue) != nil else { return nil }
        return defaults.float(forKey: key.uniqueValue)
    }
    
    public func integer(forKey key: Self.Keys) -> Int? {
        let defaults = UserDefaults.standard
        guard defaults.object(forKey: key.uniqueValue) != nil else { return nil }
        return defaults.integer(forKey: key.uniqueValue)
    }
    
    public func object(forKey key: Self.Keys) -> Any? {
        return UserDefaults.standard.object(forKey: key.uniqueValue)
    }
    
    public func string(forKey key: Self.Keys) -> String? {
        return UserDefaults.standard.string(forKey: key.uniqueValue)
    }
    
    public func stringArray(forKey key: Self.Keys) -> [String]? {
        return UserDefaults.standard.stringArray(forKey: key.uniqueValue)
    }
    
    public func url(forKey key: Self.Keys) -> URL? {
        return UserDefaults.standard.url(forKey: key.uniqueValue)
    }
    
    // MARK: - set -
    public func set(_ url: URL?, forKey key: Self.Keys) {
        UserDefaults.standard.set(url, forKey: key.uniqueValue)
    }
    
    public func set(_ value: Any?, forKey key: Self.Keys) {
        UserDefaults.standard.set(value, forKey: key.uniqueValue)
    }
    
    public func set(_ value: Bool, forKey key: Self.Keys) {
        UserDefaults.standard.set(value, forKey: key.uniqueValue)
    }
    
    public func set(_ value: Double, forKey key: Self.Keys) {
        UserDefaults.standard.set(value, forKey: key.uniqueValue)
    }
    
    public func set(_ value: Float, forKey key: Self.Keys) {
        UserDefaults.standard.set(value, forKey: key.uniqueValue)
    }
    
    public func set(_ value: Int, forKey key: Self.Keys) {
        UserDefaults.standard.set(value, forKey: key.uniqueValue)
    }
    
    // MARK: - remove -
    public func removeObject(forKey key: Self.Keys) {
        UserDefaults.standard.removeObject(forKey: key.uniqueValue)
    }
    
}
