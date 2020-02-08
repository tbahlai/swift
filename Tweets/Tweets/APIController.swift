//
//  APIController.swift
//  Tweets
//
//  Created by Tetiana BAHLAI on 2/7/20.
//  Copyright © 2020 Tetiana BAHLAI. All rights reserved.
//

import Foundation
import UIKit

class APIController {
    
    
    weak var delegate : APITwitterDelegate?
    let token : String
    
    init(delegate: APITwitterDelegate?, token: String) {
        self.delegate = delegate
        self.token = token
    }
    
    
    var tweets: [Tweet] = []
    
    func makeRequest(strSearch: String, completionHandler: @escaping([Tweet])->Void) {
        
         
                let url = URL(string: "https://api.twitter.com/1.1/search/tweets.json?" + strSearch + "&lang=en&count=100&result_type=recent")
                var request = URLRequest(url: url!)
                request.httpMethod = "GET"
                request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
                let session = URLSession.shared
                let task = session.dataTask(with: request as URLRequest) {
                    (data, response, error) in
                    let dataRequest = data
                    print(data)
                    print(error)
                    print(response)
        //            do {
        //                if let dictionary: NSDictionary = try JSONSerialization.jsonObject(with: dataRequest!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
        //                    if let statuses: [NSDictionary] = dictionary.value(forKey: "statuses") as? [NSDictionary] {
        //                        for s in statuses {
        //                            let name = (s["user"] as? NSDictionary)?["name"] as? String
        //                            let text = s["text"] as? String
        //                            let date = s["created_at"] as? String
        //                            guard name != nil, text != nil, date != nil else { return }
        //                            tweets.append(Tweet(nameUser: name!, textTweet: text!, dateTweets: date!))
        //                        }
        //                    }
        //                }
        //            }
        //            catch (let error) {
        //                return print(error)
        //            }
                      let d = data
                    do {
                        
                        if let resp: NSDictionary = try JSONSerialization.jsonObject(with: d!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            if let statuses: [NSDictionary] = resp["statuses"] as? [NSDictionary] {
                                for status in statuses {
                                    let name = (status["user"] as? NSDictionary)?["name"] as? String
                                    let text = status["text"] as? String
                                    let date = status["created_at"] as? String
                                    if (name != nil) && (text != nil) && (date != nil) {
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
                                        if let date = dateFormatter.date(from: date!) {
                                            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                                            let newDate = dateFormatter.string(from: date)
                                            self.tweets.append(Tweet(nameUser: name!, textTweet: text!, dateTweets: newDate))
                                        }
                                    }
                                }
                            }
                            completionHandler(self.tweets)
                        }
                    } catch (let err) {
                        return
                    }
                }
                task.resume()
            
            }
    }
    
    
    
    
    
//    func makeRequest(strSearch: String) -> [Tweet] {
//
//        var tweets: [Tweet] = []
//        let url = URL(string: "https://api.twitter.com/1.1/search/tweets.json?" + strSearch + "&lang=en&count=100&result_type=recent")
//        var request = URLRequest(url: url!)
//        request.httpMethod = "GET"
//        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
//        let session = URLSession.shared
//        let task = session.dataTask(with: request as URLRequest) {
//            (data, response, error) in
//            let dataRequest = data
//            print(data)
//            print(error)
//            print(response)
////            do {
////                if let dictionary: NSDictionary = try JSONSerialization.jsonObject(with: dataRequest!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
////                    if let statuses: [NSDictionary] = dictionary.value(forKey: "statuses") as? [NSDictionary] {
////                        for s in statuses {
////                            let name = (s["user"] as? NSDictionary)?["name"] as? String
////                            let text = s["text"] as? String
////                            let date = s["created_at"] as? String
////                            guard name != nil, text != nil, date != nil else { return }
////                            tweets.append(Tweet(nameUser: name!, textTweet: text!, dateTweets: date!))
////                        }
////                    }
////                }
////            }
////            catch (let error) {
////                return print(error)
////            }
//              let d = data
//            do {
//
//                if let resp: NSDictionary = try JSONSerialization.jsonObject(with: d!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
//                    if let statuses: [NSDictionary] = resp["statuses"] as? [NSDictionary] {
//                        for status in statuses {
//                            let name = (status["user"] as? NSDictionary)?["name"] as? String
//                            let text = status["text"] as? String
//                            let date = status["created_at"] as? String
//                            if (name != nil) && (text != nil) && (date != nil) {
//                                let dateFormatter = DateFormatter()
//                                dateFormatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
//                                if let date = dateFormatter.date(from: date!) {
//                                    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
//                                    let newDate = dateFormatter.string(from: date)
//                                    tweets.append(Tweet(nameUser: name!, textTweet: text!, dateTweets: newDate))
//                                }
//                            }
//                        }
//                    }
//                }
//            } catch (let err) {
//                return
//            }
//        }
//        task.resume()
//    return tweets
//    }
//}
