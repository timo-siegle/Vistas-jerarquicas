//
//  MasterViewController.swift
//  VistasJerarquicas
//
//  Created by Timo Siegle on 19.06.16.
//  Copyright © 2016 Timo Siegle. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {

    var books = [Libro]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = books[indexPath.row].titulo
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "detail" {
            (segue.destinationViewController as! DetailViewController).book = books[tableView.indexPathForSelectedRow!.row]
        } else if segue.identifier == "search" {
            (segue.destinationViewController as! IsbnVC).bookSource = self
        }
    }
}

