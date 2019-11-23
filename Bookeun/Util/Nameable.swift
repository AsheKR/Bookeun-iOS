//
//  Nameable.swift
//  Bookeun
//
//  Created by Daeyun Ethan on 23/11/2019.
//  Copyright © 2019 Lizardmon. All rights reserved.
//

import Foundation

protocol Nameable {
    static var identifier: String { get }
}

extension Nameable {
    static var identifier: String {
        return String(describing: self)
    }
}
