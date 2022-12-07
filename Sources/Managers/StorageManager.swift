//
//  StorageManager.swift
//  iOSDepartment
//
//  Created by Александр Строев on 25.09.2020.
//  Copyright © 2020 Stroev. All rights reserved.
//

import Foundation
import KeychainAccess


public protocol StorageManagerKeys {
    var rawValue: String { get }
}



extension StorageManager {
    
    public enum Key: String, StorageManagerKeys {
        case token
        case refreshToken
    }
    
    public var token: String {
        set {
            set(newValue, for: Key.token)
        }
        get {
            return get(for: Key.token) ?? ""
        }
    }
    
    public var refreshToken: String {
        set {
            set(newValue, for: Key.refreshToken)
        }
        get {
            return get(for: Key.refreshToken) ?? ""
        }
    }
}

final public class StorageManager {
    
    private static var uniqueInstance: StorageManager?
    
    private init() {}
    
    static var shared: StorageManager {
        if uniqueInstance == nil {
            uniqueInstance = StorageManager()
        }
        return uniqueInstance!
    }
    
    private var keychain: Keychain {
        guard let service = Bundle.main.infoDictionary?[String(kCFBundleIdentifierKey)] as? String else {
            fatalError()
        }
        
        return Keychain(service: service)
            .accessibility(.whenUnlockedThisDeviceOnly)
    }
    
    private func set<T: Encodable>(_ value: T?, for key: StorageManagerKeys) {
        guard let value = value else {
            delete(for: key)
            return
        }
        do {
            let data = try JSONEncoder().encode(value)
            try keychain.set(data, key: key.rawValue)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func get<T: Decodable>(for key: StorageManagerKeys) -> T? {
        do {
            guard let data = try keychain.getData(key.rawValue) else { return nil }
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            print(error)
            return nil
        }
    }
    
    private func delete(for key: StorageManagerKeys) {
        do {
            try keychain.remove(key.rawValue)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}


