//
//  ColorTheme.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/25/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import UIKit

enum ColorTheme {
    case morning, afternoon, evening, night
}

struct ColorPalette {
    var backgourndColor: UIColor
    var textColor: UIColor
    var menuColor: UIColor
    var upperGradientColor: UIColor
    var lowerGradientColor: UIColor
    
    func changeColorTheme(colorTheme: ColorTheme) {
        switch colorTheme {
        case .morning:
            HomeController.currentTheme = .morning
            colorPalette.backgourndColor = #colorLiteral(red: 0.2252208889, green: 0.241878897, blue: 0.3283707201, alpha: 1)
            colorPalette.textColor = #colorLiteral(red: 0.8636735082, green: 0.8400102258, blue: 0.9668851495, alpha: 1)
            colorPalette.menuColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            colorPalette.upperGradientColor = #colorLiteral(red: 0.2588235294, green: 0.2823529412, blue: 0.4549019608, alpha: 1)
            colorPalette.lowerGradientColor = #colorLiteral(red: 0.2307544053, green: 0.2378650904, blue: 0.3159170151, alpha: 1)
        case .afternoon:
            HomeController.currentTheme = .afternoon
            colorPalette.backgourndColor = #colorLiteral(red: 0.2252208889, green: 0.241878897, blue: 0.3283707201, alpha: 1)
            colorPalette.textColor = #colorLiteral(red: 0.8636735082, green: 0.8400102258, blue: 0.9668851495, alpha: 1)
            colorPalette.menuColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            colorPalette.upperGradientColor = #colorLiteral(red: 0.2588235294, green: 0.2823529412, blue: 0.4549019608, alpha: 1)
            colorPalette.lowerGradientColor = #colorLiteral(red: 0.2307544053, green: 0.2378650904, blue: 0.3159170151, alpha: 1)
        case .evening:
            HomeController.currentTheme = .evening
            colorPalette.backgourndColor = #colorLiteral(red: 0.2252208889, green: 0.241878897, blue: 0.3283707201, alpha: 1)
            colorPalette.textColor = #colorLiteral(red: 0.8636735082, green: 0.8400102258, blue: 0.9668851495, alpha: 1)
            colorPalette.menuColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            colorPalette.upperGradientColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            colorPalette.lowerGradientColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        case .night:
            HomeController.currentTheme = .night
            colorPalette.backgourndColor = #colorLiteral(red: 0.2252208889, green: 0.241878897, blue: 0.3283707201, alpha: 1)
            colorPalette.textColor = #colorLiteral(red: 0.8636735082, green: 0.8400102258, blue: 0.9668851495, alpha: 1)
            colorPalette.menuColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            colorPalette.upperGradientColor = #colorLiteral(red: 0.2588235294, green: 0.2823529412, blue: 0.4549019608, alpha: 1)
            colorPalette.lowerGradientColor = #colorLiteral(red: 0.2307544053, green: 0.2378650904, blue: 0.3159170151, alpha: 1)
        }
    }
}

var colorPalette = ColorPalette(
    backgourndColor: #colorLiteral(red: 0.2252208889, green: 0.241878897, blue: 0.3283707201, alpha: 1),
    textColor: #colorLiteral(red: 0.8636735082, green: 0.8400102258, blue: 0.9668851495, alpha: 1),
    menuColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
    upperGradientColor: #colorLiteral(red: 0.2588235294, green: 0.2823529412, blue: 0.4549019608, alpha: 1),
    lowerGradientColor: #colorLiteral(red: 0.2307544053, green: 0.2378650904, blue: 0.3159170151, alpha: 1))
