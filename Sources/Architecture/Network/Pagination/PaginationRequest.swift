//
//  PaginationRequest.swift
//  iOSDepartment
//
//  Created by Александр Строев on 29.08.2021.
//  Copyright © 2021 Stroev. All rights reserved.
//

import Foundation

open class PaginationRequest: Encodable {
    var limit: Int = 0
    var offset: Int = 0
    
    public init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
    }
    
    open func clear() {
        offset = 0
    }
}
