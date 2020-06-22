//
//  AlbumManager.swift
//  CaptureTheMoment
//
//  Created by Doyoung Song on 6/22/20.
//  Copyright © 2020 Doyoung Song. All rights reserved.
//

import UIKit

struct AlbumManager {
    var image: UIImage?
    var imageName: String?
    var imageTag: String?
}


// 아래부터는 컬렉션 뷰 셀을 확인하기 위한 임시 코드, coreData 가 완성되면 삭제 요망
let colorPalette: [UIColor] = [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)]

struct Colors {
    var color: UIColor = colorPalette.randomElement()!
}

struct colorItems {
    var items = Array(1...25).compactMap() {
        _ in Colors()
    }
}
