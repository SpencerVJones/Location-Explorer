//  Location.swift
//  JonesSpencer_SearchBar
//  Created by Spencer Jones on 4/27/24.

import Foundation

class Location {
    // Stored Properties
    let city: String
    let loc: [Double]
    let pop: Int
    let state: String
    let id: String
    
    // Computed Properties
    // Property that formats the location's city and state
    var cityState: String {
        let formattedCityState = "\(city), \(state)"
        return formattedCityState
    }
    
    // Property that formats the location's zip code
    var zipCode: String {
        let formattedZip = "Zip: \(id)"
        return formattedZip
    }
    
    // Property that formats the location's population
    var population: String {
        let formattedPop = "Population: \(pop)"
        return formattedPop
    }
    
    // Property that formats the location's coordinates
    var coordinates: String {
        var corrdinateString = ""
        for _ in loc {
            let longitude = loc[0]
            let latitude = loc[0]
            corrdinateString = "Coordinates: \(longitude), \(latitude)"
        }
        return corrdinateString
    }
    
    // Initalizer
    init(city: String, loc: [Double], pop: Int, state: String, id: String) {
        self.city = city
        self.loc = loc
        self.pop = pop
        self.state = state
        self.id = id
    }
}
