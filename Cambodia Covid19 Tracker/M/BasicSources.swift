//
//  BasicSources.swift
//  Cambodia Covid19 Tracker
//
//  Created by Chhorn Vatana on 7/15/20.
//  Copyright © 2020 Chhorn Vatana. All rights reserved.
//

import Foundation

struct Sources {
    let learnMoreLink = "https://www.facebook.com/MinistryofHealthofCambodia"
    let secondSreenSegue = "performSecondScreen"
    let coronaVirusAPILink = "https://api.covid19api.com/summary"
    
    struct Userdefualts {
        //MARK: - Local Data
        static let newCasesData = "NewCasesData"
        static let recoveredCasesData = "RecoverCasesData"
        static let todayCasesData = "TodayCasesData"
        static let deathCasesData = "DeathCasesData"
        //MARK: - Global Data
        static let globalNewCases = "GlobalNewCases"
        static let globalConfirmed = "GlobalConfirmed"
        static let globalDeaths = "GlobalDeaths"
        static let globalRecovered = "GlobalRecovered"
        //MARK: - Setting Data
        static let checkInternetConnection = "internet"
        static let notification = "SetNotificationOff"
    }
    
    struct Settings {
        static let switchingData = "SwitchingBetweenLocalToGlobal"
    }
    
}
