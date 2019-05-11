//
//  Structs.swift
//  Store Headphones Hi FI
//
//  Created by Antonyo Chavez Saucedo on 4/4/19.
//  Copyright © 2019 Antonyo Chavez Saucedo. All rights reserved.
//

import Foundation

public struct Item{
    public var id : Int!
    public var marca : String!
    public var name : String!
    public var descripcion : String!
    public var precio : Double!
    public var existencias : Int!
    public var imagen : String!
    public var imagenes : [String]!
}
/*
struct Compra{
    var item : Item
    var cantidad : Int = 0
    var precioUnitario : Double = 0.0
    var precioTotal : Double = 0.0
    var user : Int = 0
}*/
