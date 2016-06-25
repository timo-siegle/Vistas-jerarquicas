//
//  Libro.swift
//  VistasJerarquicas
//
//  Created by Timo Siegle on 25.06.16.
//  Copyright © 2016 Timo Siegle. All rights reserved.
//

import Foundation
import UIKit

struct Libro {
    
    var isbn : String!
    var titulo: String!
    var autores: String!
    var imagen = UIImage()
    
    init (isbn: String) {
        self.isbn = isbn
    }
    
    init (isbn: String, titulo: String, autores: String, imagen: UIImage) {
        self.isbn = isbn
        self.titulo = titulo
        self.autores = autores
        self.imagen = imagen
    }
}