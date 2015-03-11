//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Karl Barek on 3/8/15.
//  Copyright (c) 2015 pixels2bytes. All rights reserved.
//

import Foundation


class RecordedAudio: NSObject {
    
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}