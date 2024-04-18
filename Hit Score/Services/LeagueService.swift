//
//  LeagueService.swift
//  Hit Score
//
//  Created by Hakan Türkmen on 17.04.2024.
//

import UIKit

enum  LeagueService
{
    
    
    
    public static func getLeagueTeams(with leagueName : String) -> [Team]{
        
        if let url = Bundle.main.url(forResource: leagueName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Team].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
      
        return []
        
    }
    
}
