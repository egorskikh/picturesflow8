//
//  RandomPicturesResponse.swift
//  picturesflow8
//
//  Created by Егор Горских on 18.03.2021.
//

import Foundation

struct RandomPicturesResponse: Decodable {
    let width: Int
    let height: Int
    let urls: [URLKing.RawValue:String]
    
    enum URLKing: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}
