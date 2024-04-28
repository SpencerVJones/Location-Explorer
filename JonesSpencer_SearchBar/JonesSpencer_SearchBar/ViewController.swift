//  ViewController.swift
//  JonesSpencer_SearchBar
//  Created by Spencer Jones on 4/27/24.

import UIKit

// Global private constant for resuse id
private let resultsCell = "resultsCell"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Outlets
    @IBOutlet var tableView: UITableView!
    
    // Arrays to store location data
    var locationArray = [Location]()
    var filteredLocationArray = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get path to zips.json file
        if let path = Bundle.main.path(forResource: "zips", ofType: ".json") {
            // Create URL with path
            let url = URL(fileURLWithPath: path)
            do {
                // Create data object from file's URL
                let data = try Data.init(contentsOf: url)
                // Create JSON object from binary data file & cast as array of Any type
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                // Call Parse Method
                Parse(jsonObject: jsonObj)
            } catch { print(error.localizedDescription) }
        }
        
        // Reload table view
        tableView.reloadData()
    }

    // Parse Method
    func Parse(jsonObject: [Any]?) {
        guard let json = jsonObject
        else { print("Parse failed to unwrap the optional"); return }
        
        // Loop through first level object
        for firstLevelItem in json {
            // Try to convert first level object into a [String: Any]
            guard let object = firstLevelItem as? [String: Any],
                  let city = object["city"] as? String,
                  let loc = object["loc"] as? [Double],
                  let pop = object["pop"] as? Int,
                  let state = object["state"] as? String,
                  let id = object["_id"] as? String
            else { continue }
            
            // Create Location object
            let locations = Location(city: city, loc: loc, pop: pop, state: state, id: id)
            // Add locations to locationArray
            locationArray.append(locations)
        }
    }
    
    // MARK: Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLocationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: resultsCell, for: indexPath) as? ResultsTableViewCell
        else { return tableView.dequeueReusableCell(withIdentifier: resultsCell, for: indexPath)}
        
        // Configure cell
        cell.cityStateLabel.text = filteredLocationArray[indexPath.row].cityState
        cell.popLabel.text = filteredLocationArray[indexPath.row].population
        cell.zipLabel.text = filteredLocationArray[indexPath.row].zipCode
        cell.coordinatesLabel.text = filteredLocationArray[indexPath.row].coordinates
        
        return cell
    }
    
    // Set height of cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    // MARK: Storyboard Actions
    @IBAction func clearButtonTapped(_ sender: UIBarButtonItem) {
        filteredLocationArray = []
        tableView.reloadData()
    }
    
    // MARK: Navagation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let secondVC = segue.destination as? SearchViewController {
            // Pass locationArray to SearchViewController
            secondVC.locationArray = self.locationArray
        }
    }
    
    @IBAction func unwindToFirstViewController(segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? SearchViewController {
            // Get filteredLocationArray from SearchViewController
            self.filteredLocationArray = sourceVC.filteredLocationArray
            
            // Reload table view
            tableView.reloadData()
        }
    }
}
