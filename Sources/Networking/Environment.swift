//
//  File.swift
//  
//
//  Created by Omarj on 01/03/2023.
//

import Foundation

public enum Environment {
    case development
    case staging
    case production
    case custom(name: String)
}
