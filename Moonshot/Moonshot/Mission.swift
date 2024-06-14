//
//  Mission.swift
//  Moonshot
//
//  Created by Immanuel Matthews-Feemster on 6/13/24.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}
