//
//  LoaderProtocol.swift
//  iOSDepartment
//
//  Created by Александр Строев on 26.09.2020.
//  Copyright © 2020 Stroev. All rights reserved.
//

import UIKit

protocol LoaderProtocol: AnyObject {
    var loader: LoaderViewProtocol? { get }
    func loader(_ show: Bool)
}

extension LoaderProtocol where Self: BaseViewController {
    
    func loader(_ show: Bool) {
        guard let loader = loader else { return }
        if show { loader.showLoader(self.view) } else { loader.hideLoader(self.view) }
    }
    
}
