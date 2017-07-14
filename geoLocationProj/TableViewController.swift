//
//  TableViewController.swift
//  geoLocationProj
//
//  Created by Luis Garcia on 7/14/17.
//  Copyright © 2017 GT. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, tableViewDelegate {
    
    weak var delegate: tableViewDelegate?
    var passedInLocations: [EventLocation] = []
    
    @IBAction func backToTheMap(_ sender: UIBarButtonItem) {
        delegate?.cancelbuttonPressed(by: self)
    }
    
    func getCurrentPoints() {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("These are the passed in locations, ", passedInLocations)
        print(passedInLocations[0].title!)

    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailsPage", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        cell.textLabel?.text = passedInLocations[indexPath.row].title
        cell.detailTextLabel?.text = passedInLocations[indexPath.row].eventDescription
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passedInLocations.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let detailsPageViewController = navigationController.topViewController as! DetailsPageViewController
        detailsPageViewController.delegate = self
        
        let indexPath = sender as! NSIndexPath
        let event = passedInLocations[indexPath.row]
        detailsPageViewController.thisLocation = event
    }

    func cancelbuttonPressed(by controller: TableViewController) {
        print("Hello")
    }



    

}
