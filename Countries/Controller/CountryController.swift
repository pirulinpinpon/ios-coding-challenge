//
//  CountryController.swift
//  Countries
//
//  Created by Jerilyn Gonçalves on 21/08/2020.
//  Copyright © 2020 James Weatherley. All rights reserved.
//

import Foundation
import CoreData

class CountryController {
    
    // MARK:- Properties
    
    weak var view: CountryListViewController?
    private var countries: [Country] = []
    
    // MARK:- Initializer
    
    init(view: CountryListViewController) {
        self.view = view
    }
    
    // MARK:- Public methods
    
    func getCountries(_ completionHandler: @escaping (_ error: Error?) -> Void) {
        Server.shared.countryList { error in
            guard error == nil else {
                assertionFailure("There was an error: \(error!)")
                return
            }
            
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: String(describing: Country.self))
            do {
                if let countries = try DataStore.shared.viewContext.fetch(fetchRequest) as? [Country] {
                    self.countries = countries // !!!
                }
                completionHandler(error)
            } catch let error as NSError {
                completionHandler(error)
            }
        }
    }
    
    func numberOfCountries() -> Int {
        return countries.count
    }
    
    func country(at index: Int) -> Country? {
        guard self.countries.count > index else { return nil }
        return self.countries[index]
    }
}
