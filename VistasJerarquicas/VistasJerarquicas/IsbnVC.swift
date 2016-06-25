//
//  IsbnVC.swift
//  VistasJerarquicas
//
//  Created by Timo Siegle on 20.06.16.
//  Copyright © 2016 Timo Siegle. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class IsbnVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var input: UITextField!
    
    var book : Libro!
    var bookSource : MasterViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        (segue.destinationViewController as! DetailViewController).book = self.book
    }
    
    func fetchBookDetails(isbn: String) -> Libro? {
        
        var titulo = ""
        var autores = ""
        var portada = UIImage()
        
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(isbn)"
        let url = NSURL(string: urls)
        let datos = NSData(contentsOfURL: url!)
        
        if datos == nil {
            // En caso de falla en Internet, se muestra una alerta indicando ese problema
            let alertController = UIAlertController(title: "Internet connection", message:
                "Please check your connection and try again!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                let dico1 = json as! NSDictionary
                if dico1.allKeys.count > 0 {
                    let dico2 = dico1["ISBN:\(isbn)"] as! NSDictionary
                    titulo = dico2["title"] as! NSString as String
                    
                    if dico2["cover"]?.count > 0 {
                        let dico3 = dico2["cover"] as! NSDictionary
                        let portadaString = dico3["large"] as! NSString as String
                        
                        let portadaUrl = NSURL(string: portadaString)
                        let portadaData = NSData(contentsOfURL: portadaUrl!)
                        portada = UIImage(data: portadaData!)!
                    }
                    
                    var names = ""
                    if dico2["authors"]?.count > 0 {
                        let dico4 = dico2["authors"] as! NSArray
                        let firstElem = dico4[0] as! NSDictionary
                        names = firstElem["name"] as! NSString as String
                        for item in dico4.dropFirst() {
                            let obj = item as! NSDictionary
                            let name = obj["name"] as! NSString as String
                            names += ", " + name
                        }
                    } else {
                        names = "-"
                    }
                    autores = names
                    return Libro(isbn: isbn, titulo: titulo, autores: autores, imagen: portada)
                }
            } catch {
                print("Error info: \(error)")
            }
        }
        return nil
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        if let isbn = textField.text where !isbn.isEmpty {
            
            if let book = bookSource.books.filter({$0.isbn == isbn}).first {
                self.book = book
                performSegueWithIdentifier("detailSegue", sender: textField)
                
            } else {
                if let result = fetchBookDetails(isbn) {
                    self.book = result
                    self.bookSource.books.append(result)
                    
                    performSegueWithIdentifier("detailSegue", sender: textField)
                } else {
                    let alertController = UIAlertController(title: "Wrong ISBN", message:
                        "Please enter a valid ISBN and try again!", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    return false
                }
            }
        } else {
            let alertController = UIAlertController(title: "Missing ISBN", message:
                "Please enter a ISBN and try again!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            return false
        }
        return true
    }
}
