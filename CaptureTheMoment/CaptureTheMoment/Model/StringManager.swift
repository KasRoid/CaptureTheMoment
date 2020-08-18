//
//  StringManager.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 8/17/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import Foundation

struct StringManager {
    
    static let instance = StringManager()
    private init() {}
    
    enum GeneralStrings: String {
        case comment = "Comment"
        case location = "Location"
        case cancel = "Cancel"
        case restart = "Restart"
        case confirm = "Confirm"
        case save = "Save"
        case delete = "Delete"
    }
    
    enum HomeView: String {
        case barTitle = "Moment"
        case welcomeTitle = "Don't miss the Moment"
        case welcomeTitle2 = "Remember your day"
        case setting = "Settings"
        case chooseTheme = "Choose Theme"
        case chooseThemeSubtitle = "Please choose the theme you want. \n The new theme will be applied after app is restarted."
        case restartAppSubtitile = "Do you want to restart the app to apply the new theme?"
    }
    
    enum AlbumCollectionView: String {
        case barTitle = "Album"
    }
    
    enum DetailView: String {
        case memory = "Memory"
        case commentPlaceholder = "No Comment"
        case locationPlaceholder = "No Plcae Info"
    }
    
    enum EditingView: String {
        case barTitle = "Edit"
        case deleteImage = "Delete Image"
        case deleteImageSubtitle = "Do you really want to delete the image?"
    }
    
    enum RegisterView: String {
        case locationPlaceholder = "Press below button to find location"
        case checkMyLoaction = " Check my location"
    }
}
