//
//  PlistManager.swift
//  iOSDepartment
//
//  Created by Александр Строев on 20.09.2020.
//  Copyright © 2020 Stroev. All rights reserved.
//

import Foundation

public class PlistManager<T: Decodable> {
    
    public var plistData: Data {
        let url = Bundle.main.url(forResource: "iOSDepartment/info", withExtension: "plist")!
        return try! Data(contentsOf: url)
    }
    
    public var value: T {
        return try! PropertyListDecoder().decode(T.self, from: plistData)
    }
}

public struct BaseURL: Decodable {
    private enum CodingKeys: String, CodingKey {
        case value = "BASE_URL"
    }

    public let value: String
    
    public var url: URL {
        return value.url!
    }
}
