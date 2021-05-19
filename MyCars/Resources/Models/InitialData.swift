//
//  InitialData.swift
//  MyCars
//
//  Created by Aksilont on 19.05.2021.
//

import Foundation

struct InitialData: Codable {
    let rating: Double
    let myChoice: Bool
    let tintColor: TintColor
    let mark: String
    let model: String
    let lastStarted: Date
    let imageName: String
    let timesDriven: Int16
}

struct TintColor: Codable {
    let green: Int16
    let blue: Int16
    let red: Int16
}
