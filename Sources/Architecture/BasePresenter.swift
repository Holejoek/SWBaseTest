//
//  BasePresenter.swift
//  iOSDepartment
//
//  Created by Александр Строев on 07.09.2020.
//  Copyright © 2020 Stroev. All rights reserved.
//

import Foundation

open class BasePresenter: NSObject {
    weak public var screenUtilities: (LoaderProtocol & ToastProtocol & DialogProtocol)?
}
