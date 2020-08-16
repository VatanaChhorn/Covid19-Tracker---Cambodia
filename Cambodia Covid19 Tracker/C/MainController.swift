//
//  ViewController.swift
//  Cambodia Covid19 Tracker
//
//  Created by Chhorn Vatana on 7/9/20.
//  Copyright © 2020 Chhorn Vatana. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    @IBOutlet weak var totalCasesLabel: UILabel!
    
    var coronaVirusManager = CoronaVirusManager()
    let source = Sources()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Declare delegate and call the functions
        coronaVirusManager.delegate = self
        coronaVirusManager.getTheDataFromAPI()
        
        //Display the defualtData to the Screen
        let defaultData = UserDefaults.standard.integer(forKey: Sources.Userdefualts.newCasesData)
        if  defaultData != 0
        {
            self.totalCasesLabel.text = String(defaultData)
        }
    }
    
    //MARK: - Button Functions
    @IBAction func learnMoreButtonClicked(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: source.learnMoreLink)!)
    }
    @IBAction func liveUpdateButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: source.secondSreenSegue, sender: self)
        
    }
    
    
}


//MARK: - Delegate extensions
extension MainController: CoronaVirusManagerDelegate
{
    func didUpdateTheCases(coronaVirusCases: CoronaVirusModel) {
        DispatchQueue.main.async {
            
            self.totalCasesLabel.text = coronaVirusCases.getTotalCases
            
            //setup default datas
            if ( coronaVirusCases.totalNewCases != self.defaults.integer(forKey: Sources.Userdefualts.todayCasesData) ) || ( coronaVirusCases.totalCases != self.defaults.integer(forKey: Sources.Userdefualts.newCasesData))
            {
                self.defaults.set(coronaVirusCases.totalCases, forKey: Sources.Userdefualts.newCasesData)
                self.defaults.set(coronaVirusCases.totalRecovered, forKey: Sources.Userdefualts.recoveredCasesData)
                self.defaults.set(coronaVirusCases.totalNewCases, forKey: Sources.Userdefualts.todayCasesData)
                self.defaults.set(coronaVirusCases.totalDeath, forKey: Sources.Userdefualts.deathCasesData)
            }
        }
    }
}

