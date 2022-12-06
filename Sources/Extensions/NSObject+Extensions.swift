//
//  NSObject+Extensions.swift
//  iOSDepartment
//
//  Created by Александр Строев on 07.09.2020.
//  Copyright © 2020 Stroev. All rights reserved.
//

import Foundation

extension NSObject {
    public var className: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
    
    public class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
