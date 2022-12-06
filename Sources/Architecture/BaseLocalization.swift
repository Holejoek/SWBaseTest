//
//  BaseLocalization.swift
//  iOSDepartment
//
//  Created by Александр Строев on 07.09.2020.
//  Copyright © 2020 Stroev. All rights reserved.
//

import Foundation

open class BaseLocalization: NSObject {
    open func localize(_ id: String) -> String {
        return id.localize(className)
    }
}
