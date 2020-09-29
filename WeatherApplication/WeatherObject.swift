//
//  WeatherObject.swift
//  WeatherApplication
//
//  Created by Yeni Kullanıcı on 20.09.2020.
//  Copyright © 2020 Busra Nur OK. All rights reserved.
//

import Foundation

//cevap
//Array
struct Response: Codable
{
    struct Weather: Codable {
        var havaDurumu : String
        var id : Int
        var sehir : String
    }
    
    var havaDurumlari:[Weather]
}
