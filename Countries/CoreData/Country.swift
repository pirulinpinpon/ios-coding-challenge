//
//  Country.swift
//  Countries
//
//  Created by Syft on 04/03/2020.
//  Copyright © 2020 Syft. All rights reserved.
//

import Foundation
import CoreData
import ObjectMapper


@objc(Country)
class Country: NSManagedObject, Mappable {
        
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    // NOTE: I have seen random crashes in init() and mapping().
    //       This is NOT part of the code challenge.
    //
    // Massive bonus points if you figure it out, but don't spend time on this,
    // just re-run the app or tests and cross your fingers!
    required init?(map: Map) {
        
        guard map.JSON["name"] != nil,
            map.JSON["capital"] != nil,
            map.JSON["population"] != nil else {
                assertionFailure("Failed to create Country")
                return nil
        }
        
        super.init(entity: Self.entity(), insertInto: nil)
    }
    
    // NOTE: I have seen random crashes in init() and mapping().
    //       This is NOT part of the code challenge.
    //
    // Massive bonus points if you figure it out, but don't spend time on this,
    // just re-run the app or tests and cross your fingers!
    func mapping(map: Map) {
        
        DispatchQueue.main.async {
            self.name <- map["name"]
            self.capital <- map["capital"]
            self.population <- map["population"]
        }
    }
    
}
