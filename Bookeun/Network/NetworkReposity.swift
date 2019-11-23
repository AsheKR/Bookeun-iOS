//
//  NetworkReposity.swift
//  Bookeun
//
//  Created by 이병찬 on 2019/11/23.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation
import Moya

class NetworkRepository<API: TargetType> {
    let provider = MoyaProvider<API>()
}
