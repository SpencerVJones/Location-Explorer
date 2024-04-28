//  SearchViewController.swift
//  JonesSpencer_SearchBar
//  Created by Spencer Jones on 4/27/24.

import UIKit

// Global private constant for resuse id
private let searchCell = "searchCell"

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    // Arrays to store location data
    var locationArray = [Location]()
    var filteredLocationArray = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set filteredLocationArray to locationArray
        filteredLocationArray = locationArray
        
        // Setup search bar delegate
        searchBar.delegate = self
        // Set scope button titles
        searchBar.scopeButtonTitles = ["All", "PA", "NJ"]
        
        // Reload table view
        tableView.reloadData()
    }
    
    // MARK: Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLocationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: searchCell, for: indexPath) as? SearchTableViewCell
        else { return tableView.dequeueReusableCell(withIdentifier: searchCell, for: indexPath)}
        
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
    
    // MARK: - Navigation
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Access the source view controller when search button is tapped
        if let sourceVC = self.presentingViewController as? ViewController {
            sourceVC.filteredLocationArray = self.filteredLocationArray
            
            // Reload table view
            sourceVC.tableView.reloadData()
        }
        
        // Dismiss the view contorller
        presentingViewController?.dismiss(animated: true) {
        }
    }
    
    
    // MARK: Search Callbacks
    func updateSearchResults(for searchBar: UISearchBar) {
        // Get text user wants to search for
        let searchText = searchBar.text
        // Get scope button title that user has selected
        let selectedScope = searchBar.selectedScopeButtonIndex
        // Get all scope titles
        let allScopeTitles = searchBar.scopeButtonTitles!
        // Get selected scope
        let scopeTitle = allScopeTitles[selectedScope]
        
        // Dump data set into array used for filtering
        filteredLocationArray = locationArray
        
        // If user types anything into search field, filter based on entry
        if searchText != "" {
            filteredLocationArray = filteredLocationArray.filter ({ (location) -> Bool in
                return location.city.lowercased().range(of: searchText!.lowercased()) != nil // user can search a city
            })
        }
        
        // Filter again based on scope
        if scopeTitle != "All" {
            filteredLocationArray = filteredLocationArray.filter({
                $0.state.range(of: scopeTitle) != nil
            })
            
        }
        
        // Reload table view
        tableView.reloadData()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        // Update search results when scope button index changes
        updateSearchResults(for: searchBar)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Update search results when search text changes
        updateSearchResults(for: searchBar)
    }
}
