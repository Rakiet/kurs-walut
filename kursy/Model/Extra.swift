//
//  Extra.swift
//  kursy
//
//  Created by Piotr Żakieta on 29/03/2022.
//

import Foundation
import UIKit
struct Extra {
    
    var activityIndicator: UIActivityIndicatorView?
    
    mutating func prepareactivityIndicator(sentView: UIView){
        
        if #available(iOS 13.0, *) {//jezeli wersja iOS jest wyzsza niz 13 to utworzy ten UIActivityIndicatorView
            activityIndicator = UIActivityIndicatorView(style: .large)
        } else {//jezeli wersja iOS jest nizsza niz 13 to utworzy ten UIActivityIndicatorView w stylu .whiteLarge i zmieni kolor na zielony
            activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
            activityIndicator?.color = UIColor.green
        }
        activityIndicator!.translatesAutoresizingMaskIntoConstraints = false
        sentView.addSubview(activityIndicator!)
        activityIndicator!.centerXAnchor.constraint(equalTo: sentView.centerXAnchor).isActive = true
        activityIndicator!.centerYAnchor.constraint(equalTo: sentView.centerYAnchor).isActive = true
    }
    
    func errorConnection() -> UIAlertController{
        //utworzenie okna dialogowego
        var dialogMessage = UIAlertController(title: "Błąd", message: "Nie można pobrać danych, sprawdz połączenie z internetem", preferredStyle: .alert)
        // Utworzenie przycisku ok
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("ok button allert")
         })
        //Dodanie przycisku ok do okna dialogowego wiadomosci
        dialogMessage.addAction(ok)
        // Present Alert to
        return dialogMessage
//        self.present(dialogMessage, animated: true, completion: nil)
    }
}
