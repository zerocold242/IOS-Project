//
//  LocalizedKeys.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 23.05.2023.
//

import Foundation

//оператор тильда для удобства вызова ключей
prefix operator ~
prefix func ~ (strings: String) -> String {
    return NSLocalizedString(strings, comment: "")
}

//ключи локализации представлены в виде enum для избежания опечаток при вызове в контроллерах
enum LocalizedKeys: String {
    
    //LoginScreen
    case signUpBut = "signUpBut"
    case logTextfield = "logTextfield"
    case passTextField = "passTextField"
    case logButton = "logButton"
    
    //LoginScreenAlerts
    case loginAlert = "loginAlert"
    case loginAlertTitle = "loginAlertTitle"
    case errorAlert = "errorAlert"
    case errorAlertTitle = "errorAlertTitle"
    
    //TabBarItems
    case feed = "feed"
    case profile = "profile"
    case favorites = "favorites"
    case mapse = "maps"
    
    //ProfileScreen
    case profileStatusTextField = "profileStatusTextField"
    case profileStatusButton = "profileStatusButton"
    case profilePhotosLabel = "profilePhotosLabel"
    case profilePostLikes = "profilePostLikes"
    case profilePostViews = "profilePostViews"
    
    //LikedPostScreen
    case LPNavTitle = "LPNavTitle"
    case LPSearchTitle = "LPSearchTitle"
    //LikedPostScreenAlerts
    case LPRemoveAlertTitle = "LPRemoveAlertTitle"
    case LPDeleteSwipe = "LPDeleteSwipe"
    case LPSaveAlert = "LPSaveAlert"
    
    //MapsScreen
    case mapsStandart = "mapsStandart"
    case mapsSatellite = "mapsSatellite"
    case mapsHybride = "mapsHybride"
    case mapsDeletePins = "mapsDeletePins"
    case mapsNewPoiont = "mapsNewPoiont"
    //MapsAlerts
    case mapsNavigateTitle = "mapsNavigateTitle"
    case mapsNavigateMessage = "mapsNavigateMessage"
    case mapsNavAction = "mapsNavAction"
    case mapsGeo1Mess = "mapsGeo1Mess"
    case mapsGeo2Mess = "mapsGeo2Mess"
    case mapsFailedGeoMess = "mapsFailedGeoMes"
    
    //FeedViewScreen
    case firstButton = "firstButton"
    case secondButton = "secondButton"
    case secretTextField = "secretTextFielt"
    case checkButton = "checkButtton"
    
    //PostScreen
    case rightBarButton = "rightBarButton"
    case PostNavigationItem = "PostNavigationItem"
    
    //InfoScreen
    case infoAlertButton = "infoAlertButton"
    //InfoScreenAlert
    case infoAlertTitle = "infoAlertTitle"
    case infoAlertMessage = "infoAlertMessage"
    case infoActionCancel = "infoActionCancel"
    case infoActionOk = "infoActionOk"
}

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
