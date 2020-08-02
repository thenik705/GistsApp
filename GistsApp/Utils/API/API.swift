//
//  API.swift
//  GistsApp
//
//  Created by Nik on 27.07.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import Foundation
import Alamofire

class API {

    static let BASE_URL = "https://api.github.com"

    static let REST_GISTS = "/gists/public"
    static let RESR_GIST_DETAIL = "/gists/%@"
    static let RESR_GIST_COMMITS = "/gists/%@/commits"

    func getGists(_ callback: NSObject) {
        performRequest(callback, API.REST_GISTS, method: .get, parameters: nil, parser: GistsParser())
    }

    func getGistDetail(_ callback: NSObject, gistId: String) {
        performRequest(callback, String(format: API.RESR_GIST_DETAIL, gistId), method: .get, parameters: nil, parser: GistsParser())
    }

    func getGistCommits(_ callback: NSObject, gistId: String) {
        performRequest(callback, String(format: API.RESR_GIST_COMMITS, gistId), method: .get, parameters: nil, parser: CommitParser())
    }

    func performRequest(_ callback: NSObject, _ url: String, method: HTTPMethod, parameters: [String: String]? = nil, parser: IParser) {
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]

        AF.request(API.BASE_URL + url, method: method, headers: headers).responseData { response in
            do {

                if let data = response.data {
                    if response.error != nil {
                        return
                    }

                    if let ipString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                        if let jsonData = ipString.data(using: String.Encoding.utf8.rawValue,allowLossyConversion: true) {
                            let data = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)

                            if (data is NSArray) {
                                let dataArray = data as! NSArray
                                if let error = ErrorParser().parse(dataArray) {
                                    callback.performSelector(onMainThread: #selector(APICallback.onError(_:)), with: error, waitUntilDone: false)
                                } else {
                                    let result = parser.parse(dataArray)
                                    callback.performSelector(onMainThread: #selector(APICallback.onLoaded(_:)), with: result, waitUntilDone: false)
                                }
                            } else if (data is NSDictionary) {
                                let dataDictionary = data as! NSDictionary
                                if let error = ErrorParser().parse(dataDictionary) {
                                    callback.performSelector(onMainThread: #selector(APICallback.onError(_:)), with: error, waitUntilDone: false)
                                } else {
                                    let result = parser.parse(dataDictionary)
                                    callback.performSelector(onMainThread: #selector(APICallback.onLoaded(_:)), with: result, waitUntilDone: false)
                                }
                            }
                        }
                    }
                }
            } catch {
                print(error)
            }
        }
    }

    func loadContentUrl(_ urString: String, callback: ((String) -> Void)?, callbackError: (() -> Void)?) {
        if let url = URL(string: urString), let data = try? Data(contentsOf: url), let content = String(data: data, encoding: .utf8) {

            if (callback != nil) {
                callback!(content)
            }
        } else {
            if (callbackError != nil) {
                callbackError!()
            }
        }
    }
}
