//
//  ViewController.swift
//  WeatherApplication
//
//  Created by Yeni Kullanıcı on 20.09.2020.
//  Copyright © 2020 Busra Nur OK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    var jsonData : Data!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    @IBAction func getWeatherDataClicked(_ sender: Any) {
        
       /* 1) Request & URLSession
        2) Request & Data
        3) Parsing & JSON Serialization */
        
        
        //1. Adım
        //iletişim iki şey gerek biri sensin diğeri de url, kesinlikle olmalı
        let url = URL(string: "https://my-json-server.typicode.com/HasanBasriOK/TestJsonRepo/db")
        
        //objesini tanımlıyoruz
        let session = URLSession.shared
        
        //closure
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                //butonaa tıklanınca bir şey olmasın istediğimiz için handler a ihtiyacımız yok
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            } else {

                //hata mesajı yok ise veriyi alacağız
                //2. Adım
                if data != nil {
                    do  {
                        
                        let dataString = String(data: data!, encoding: .utf8)
                        self.jsonData = dataString!.data(using: .utf8)!
                        let response = try! JSONDecoder().decode(Response.self, from: self.jsonData)
                        

                        DispatchQueue.main.async {
                            
                            var resultStr : String = ""
                            
                                for weather in response.havaDurumlari {
                                    
                                    //Çoklu labelda basmak ister isem bu şekilde yapacaktım
                                   /* if weather.sehir == "Afyon" {
                                        afyonLabel.text = "Şehir: \(weather.sehir) Hava Durumu : \(weather.havaDurumu) \n"
                                    }*/
                                    
                                    resultStr += "Şehir: \(weather.sehir) Hava Durumu : \(weather.havaDurumu) \n"
                                        
                                    }
                            
                            self.resultLabel.text = resultStr
                            
                               }
                        
                    } catch {
                        
                        print(error)
                        
                    }
                    
                }
                
            }
        }
        
        //bunu demeden işlemimiz başlamıyor
        //taski ayrı tanımlamamızın sebebi buraya bunu yazmamız
        //bu olmadan task başlamıyor
        task.resume()
        
    }
    
}
