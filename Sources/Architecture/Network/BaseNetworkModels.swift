//
//  BaseNetworkModels.swift
//  iOSDepartment
//
//  Created by Александр Строев on 16.09.2020.
//  Copyright © 2020 Stroev. All rights reserved.
//

import Moya

public struct EmptyRequest: Encodable {}

protocol MultipartRequest {
    var multipartData: [MultipartFormData] { get }
}

public struct ErrorResponse : Decodable { //Эту структуру надо согласовывать с сервером
    var message : String
    var details : String?
}
