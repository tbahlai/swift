//
//  structTweet.swift
//  Tweets
//
//  Created by Tetiana BAHLAI on 2/7/20.
//  Copyright © 2020 Tetiana BAHLAI. All rights reserved.
//

import Foundation

struct Tweet: CustomStringConvertible {
    
    let nameUser: String
    let textTweet: String
    let dateTweets: String
    
    var description: String {
        return "name: \(nameUser), text: \(textTweet), date: \(dateTweets)"
    }
}
