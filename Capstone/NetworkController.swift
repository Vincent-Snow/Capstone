//
//  NetworkController.swift
//  Capstone
//
//  Created by mac-admin on 3/28/16.
//  Copyright © 2016 Vints. All rights reserved.
//

import Foundation

class NetworkController {
    
    static func spotifyURL(trackURI: String) -> NSURL? {
        let URLString = "https://api.spotify.com/v1/tracks/\(trackURI)"
        if let url = NSURL(string: URLString) {
            return url
        } else {
            return nil
        }
    }
    
    static func dataAtURL(url: NSURL, completion: (data: NSData?) -> Void) {
        let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, _, error) in
            if let error = error {
                print("Data could not be retrieved due to error: \(error.localizedDescription)")
                completion(data: nil)
            } else {
                if let data = data {
                    completion(data: data)
                } else {
                    completion(data: nil)
                }
            }
        }
        dataTask.resume()
    }
    
    static func dataFromRequest(request: NSURLRequest, completion: (data: NSData?) -> Void) {
        let dataRequest = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, _, error) in
            if let error = error {
                print("Data could not be retrieved due to error: \(error.localizedDescription)")
                completion(data: nil)
            } else {
                if let data = data {
                    completion(data: data)
                } else {
                    completion(data: nil)
                }
            }
        }
        dataRequest.resume()
    }
}