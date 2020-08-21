//
//  CountryListViewController.swift
//  Countries
//
//  Created by Syft on 03/03/2020.
//  Copyright © 2020 Syft. All rights reserved.
//

import UIKit

class CountryListViewController: UIViewController, UITableViewDataSource {

    // MARK: IBOutlets
    
    @IBOutlet weak var countryTableView: UITableView!
    
    // MARK: Properties
    
    var controller: CountryController?
    static let populationNumberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.numberStyle = .decimal
    }()
    
    // MARK:- Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.controller = CountryController(view: self)
        countryTableView.rowHeight = UITableView.automaticDimension
        countryTableView.estimatedRowHeight = 100
        countryTableView.dataSource = self
        countryTableView.accessibilityIdentifier = "CountryTable"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        HUD.show(in: view.window!)
        controller?.getCountries { _ in
            HUD.dismiss(from: self.view.window!)
            self.countryTableView.reloadData()
        }
    }
    
    // MARK:- UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller?.numberOfCountries() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell") as? CountryTableViewCell else {
            return UITableViewCell()
        }
        
        if let country = controller?.country(at: indexPath.row) {
            cell.country.text = country.name
            cell.capital.text = country.capital
            if let capital = country.capital, capital.isEmpty {
                cell.capitalLabel.text = nil
            }
            cell.population.text = self.formattedPopulationString(country.population)
            cell.accessibilityIdentifier = "\(country.name!)-Cell"
            cell.country.accessibilityIdentifier = "Country"
            cell.capital.accessibilityIdentifier = "\(country.name!)-Capital"
            cell.capitalLabel.accessibilityIdentifier = "\(country.name!)-Capital-Label"
            cell.population.accessibilityIdentifier = "\(country.name!)-Population"
            cell.populationLabel.accessibilityIdentifier = "\(country.name!)-Population-Label"
        }
        return cell
    }
    
    // MARK: - Private helpers
    
    private func formattedPopulationString(_ population: Int32) -> String? {
        return Self.populationNumberFormatter.string(from: NSNumber(value: population))
    }
}

