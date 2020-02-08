//
//  MainController.swift
//  Tweets
//
//  Created by Tetiana BAHLAI on 2/7/20.
//  Copyright © 2020 Tetiana BAHLAI. All rights reserved.
//

import UIKit

class MainController: UIViewController, APITwitterDelegate, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableTweets: UITableView!
    var allTweets: [Tweet] = []
    var token: String = ""
    var allTweets1: [Tweet] = []
    
    func getTweet(name: [Tweet]) {
        self.allTweets = name
        tableTweets.reloadData()
    }
    

    func errorTweet(error: NSError) {
        print(error)
    }
    override func viewDidAppear(_ animated: Bool) {
self.tableTweets.reloadData()
                   
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tableTweets.reloadData()
    }

    
    override func viewWillAppear(_ animated: Bool) {
               sess { (response) in
//                   self.allTweets = response
        
               }
    }
    @IBAction func abs(_ sender: UIButton) {
        sess { (response) in
            self.allTweets = response
            
        }
        self.tableTweets.reloadData()
    }
    
    
    
    
//    func informationUser() {
//
//        requestManager.informationUser(userName: userName.text!, token: bearerToken, completionHandler: {(response) in
//            if response != nil {
//                allInfoUser = response
//                if response!["error"] == "Not authorized" {
//                    self.alertError(title: "Error", message: "Bad server connection")
//                    return
//                }
//                if response!.isEmpty {
//                    self.alertError(title: "Error", message: "Invalid login. Try again.")
//                    return
//                }
//                print(allInfoUser!["displayname"])
//                self.userName.text! = ""
//                self.view.endEditing(true)
//                self.performSegue(withIdentifier: "userInfo", sender: nil)
//            } else {
//                self.alertError(title: "Error", message: "Invalid login. Try again.")
//            }
//        })
//    }
//
    
     func sess(completionHandler: @escaping([Tweet])->Void) {

        let CUSTOMER_KEY = "UryVYaIYVTr2p0CyjJTYSnrgt"
            let CUSTOMER_SECRET = "rpFWnybmdvhOq4pkh6ZmS5C46KyfRUXm35J4b0xsnyP2EJURC0"
            let BEARED = ((CUSTOMER_KEY + ":" + CUSTOMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString()
            let url = NSURL(string: "https://api.twitter.com/oauth2/token")
            let request = NSMutableURLRequest(url: url! as URL)
            request.httpMethod = "POST"
            request.setValue("Basic " + BEARED, forHTTPHeaderField: "Authorization")
            request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
            
            let sess = URLSession.shared
            
            
            sess.dataTask(with: request as URLRequest) {
                (data, response, error) in
                do
                {
                    if let dic: NSDictionary = try JSONSerialization.jsonObject(with: data!) as? NSDictionary {
                        self.token = dic["access_token"]! as! String
                    }
                    let controllerTwitter = APIController(delegate: self, token: self.token)
                    controllerTwitter.makeRequest(strSearch: "q="+"school 42".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!, completionHandler: { (response) in
                        completionHandler(response)
                        self.allTweets = response
                    })
                }
                catch (let error)
                {
                    return print(error)
                }
            }.resume()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableTweets.dataSource = self
        searchBar.delegate = self
        searchBar.text = "qwerty"

        
        
//        let CUSTOMER_KEY = "UryVYaIYVTr2p0CyjJTYSnrgt"
//        let CUSTOMER_SECRET = "rpFWnybmdvhOq4pkh6ZmS5C46KyfRUXm35J4b0xsnyP2EJURC0"
//        let BEARED = ((CUSTOMER_KEY + ":" + CUSTOMER_SECRET).data(using: String.Encoding.utf8))!.base64EncodedString()
//        let url = NSURL(string: "https://api.twitter.com/oauth2/token")
//        let request = NSMutableURLRequest(url: url! as URL)
//        request.httpMethod = "POST"
//        request.setValue("Basic " + BEARED, forHTTPHeaderField: "Authorization")
//        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
//
//        let sess = URLSession.shared
//
//
//        sess.dataTask(with: request as URLRequest) {
//            (data, response, error) in
//            do
//            {
//                if let dic: NSDictionary = try JSONSerialization.jsonObject(with: data!) as? NSDictionary {
//                    self.token = dic["access_token"]! as! String
//                }
//                let controllerTwitter = APIController(delegate: self, token: self.token)
//                controllerTwitter.makeRequest(strSearch: "q="+"school 42".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!, completionHandler: { (response) in
//                    self.allTweets = response
//                    self.tableTweets.reloadData()
//                })
//            }
//            catch (let error)
//            {
//                return print(error)
//            }
//        }.resume()
        
    }
    
    
}

extension MainController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableCell", for: indexPath) as? TweetsCellTableViewCell
        cell?.nameUser.text = allTweets[indexPath.row].nameUser
        cell?.usersTweet.text = allTweets[indexPath.row].textTweet
        cell?.dateTweet.text = allTweets[indexPath.row].dateTweets
        return cell!
    }
}
