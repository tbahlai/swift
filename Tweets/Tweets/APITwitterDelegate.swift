//
//  APITwitterDelegate.swift
//  Tweets
//
//  Created by Tetiana BAHLAI on 2/7/20.
//  Copyright © 2020 Tetiana BAHLAI. All rights reserved.
//

import Foundation

protocol APITwitterDelegate: class {
    func getTweet(name: [Tweet])
    func errorTweet(error: NSError)
}
