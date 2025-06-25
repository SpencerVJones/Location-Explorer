# Location-Explorer
 <div align="left">
	
  ![Repo Views](https://visitor-badge.laobi.icu/badge?page_id=SpencerVJones/Location-Explorer)
</div>

 iOS application that allows users to search for locations based on city names and filter the results by city and state. 

## Features
- Search for locations by city name.
- Filter search results by state using scope buttons.
- Display search results in a table view.
- Clear search results with a clear button.

## Usage
### ViewController
- **Location Data**: Parses JSON data from a file named "zips.json" to retrieve location information (city, state, population, coordinates).
- **Table View**: Displays search results using a custom table view cell (ResultsTableViewCell).
- **Navigation**: Performs an unwind segue to receive filtered location data from the SearchViewController.
### SearchViewController
- **Search Bar**: Allows users to enter search queries and filter results by state using scope buttons.
- **Table View**: Displays search results using a custom table view cell (SearchTableViewCell).
- **Search Bar Interaction**: Handles search queries and scope button changes to filter search results.
- **Navigation**: Dismisses the view controller and passes filtered location data back to the ViewController.
### Custom Cells
- **ResultsTableViewCell**: Displays location information (city, state, population, coordinates) in the main view controller.
- **SearchTableViewCell**: Displays location information (city, state, population, coordinates) in the search view controller.
### Location Model
- Represents a location with properties for city name, state, population, coordinates, and a computed property to format the display of location information.

## JSON Data Structure
**The JSON data provided for this application was obtained from Full Sail University.**

```json
[
  {
    "city": "String",
    "loc": [
      0,
      0
    ],
    "pop": 0,
    "state": "String",
    "_id": "String"
  }
]
```

## Technologies Used

### You can contribute by:
-  Reporting bugs
-  Suggesting new features
-  Submitting pull requests to improve the codebase
