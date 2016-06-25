//
//  DetailViewController.swift
//  VistasJerarquicas
//
//  Created by Timo Siegle on 19.06.16.
//  Copyright © 2016 Timo Siegle. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var book : Libro!
    
    @IBOutlet weak var isbn: UILabel!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var autores: UILabel!
    @IBOutlet weak var imagen: UIImageView!
    
    func configureView() {
        // Update the user interface for the detail item.
        
        isbn.text = book.isbn
        titulo.text = book.titulo
        autores.text = book.autores
        imagen.image = book.imagen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

