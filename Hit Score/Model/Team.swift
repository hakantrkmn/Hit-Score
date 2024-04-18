//
//  Team.swift
//  Hit Score
//
//  Created by Hakan Türkmen on 17.04.2024.
//

import Foundation

struct Team : Codable , Equatable
{
    var team_id : Int
    var team_name : String
    var team_abbreviation  : String
    var team_stadium : String
}
