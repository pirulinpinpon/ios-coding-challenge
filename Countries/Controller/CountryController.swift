//
//  CountryController.swift
//  Countries
//
//  Created by Jerilyn Gonçalves on 21/08/2020.
//  Copyright © 2020 James Weatherley. All rights reserved.
//

import Foundation
import CoreData

/// This class is responsible for communicating to the Server and Store layers, avoiding to tightly couple the view with the logic of the app.
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
            let fetchRequest = NSFetchRequest<Country>(entityName: String(describing: Country.self))
            fetchRequest.sortDescriptors = [NSSortDescriptor(key:"name", ascending: true)]
            do {
                self.countries = try DataStore.shared.viewContext.fetch(fetchRequest)
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
        guard countries.count > index else { return nil }
        return countries[index]
    }
}
