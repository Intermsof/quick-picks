//
//  Promise.swift
//  quickpicks
//
//  Created by Zhan Peng  Pan on 8/16/18.
//  Copyright © 2018 quickpicks. All rights reserved.
//

import Foundation

protocol Promise{
    func resolve(result : Any)
    func reject(error: String)
}
