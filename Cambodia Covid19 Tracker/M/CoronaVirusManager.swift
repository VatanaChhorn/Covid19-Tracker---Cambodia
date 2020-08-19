//
//  CoronaVirusManager.swift
//  Cambodia Covid19 Tracker
//
//  Created by Chhorn Vatana on 7/15/20.
//  Copyright © 2020 Chhorn Vatana. All rights reserved.
//

import Foundation
import UIKit

protocol CoronaVirusManagerDelegate {
    func didUpdateTheCases (coronaVirusCases: CoronaVirusModel)
}

struct CoronaVirusManager {
    
    var delegate: CoronaVirusManagerDelegate?
    var source = Sources()
    
    
    func getTheDataFromAPI() -> Void {
        let apiURL = source.coronaVirusAPILink
        performReqeust(apiURL: apiURL)
    }
    
    func performReqeust(apiURL: String) -> Void {
        
        if let url = URL(string: apiURL)
        {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, respond, error) in
                if error != nil
                {
                    print("error block 1: \(error!)")
                    UserDefaults.standard.set(true, forKey: Sources.Userdefualts.checkInternetConnection)
                    return
                }
                if let safeData = data
                {
                    if let casesOverview =  self.parseJSON(coronavirusData: safeData)
                    {
                        self.delegate?.didUpdateTheCases(coronaVirusCases: casesOverview)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(coronavirusData: Data ) -> CoronaVirusModel? {
        let decoder = JSONDecoder()
        do
        {
            let decodedData = try decoder.decode(CoronaVirusData.self, from: coronavirusData)
            
            let coronaVirusModel = CoronaVirusModel(totalCases: decodedData.Countries[28].TotalConfirmed, totalRecovered: decodedData.Countries[28].TotalRecovered, totalDeath: decodedData.Countries[28].TotalDeaths, totalNewCases: decodedData.Countries[28].NewConfirmed, globalTotalCases: decodedData.Global.TotalConfirmed, globalRecoveredCases: decodedData.Global.TotalRecovered, globalDeath: decodedData.Global.TotalDeaths, globalNewcases: decodedData.Global.NewConfirmed)
            
            return coronaVirusModel
            
        }
        catch
        {
            print("error block 2: \(error)")
            return nil
            
        }
    }
}




