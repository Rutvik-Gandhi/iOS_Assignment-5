//
//  ImageStorage.swift
//  Assignment 5
//
//  Created by Assignment 5 on 23/11/22.
//

import Foundation
import UIKit

enum JSONResult {
    case success([Photo])
    case failure(Error)
}

enum PhotoResult {
    case success(UIImage)
    case failure(Error)
}

enum ImageError: Error {
    case imageDownloadError
}

enum JSONParsingError: Error {
    case invalidJSON
}

class ImageStorage {
    
    var jsonResult: JSONResult!
    
    let urlSession: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    //MARK: - Fetching data from json server -
    func fetchAllImages(completion: @escaping(JSONResult) -> Void) {
        let urlComponent = URLComponents(string: "http://localhost:3000/places")
        let url = urlComponent?.url
        let urlRequest = URLRequest(url: url!)
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            
            if let jsonData = data {
                self.jsonResult = self.parseJSON(jsonData: jsonData)
                completion(self.jsonResult)
            } else if let err = error {
                print("Error fetching photos: \(err)")
                completion(.failure(err))
            } else {
                print("Something went wrong!")
            }
        }
        task.resume()
    }
    
    //MARK: - JSON Parsing from Data -
    func parseJSON(jsonData: Data) -> JSONResult {
        do {
            let jsonObj = try JSON(data: jsonData)
            guard let arrImages = jsonObj.array else {
                return .failure(JSONParsingError.invalidJSON)
            }
            var arrPhotos = [Photo]()
            for obj in arrImages {
                if let objImage = parseImage(jsonObject: obj) {
                    arrPhotos.append(objImage)
                }
            }
            
            if arrPhotos.isEmpty && !arrImages.isEmpty {
                return .failure(JSONParsingError.invalidJSON)
            }
            return .success(arrPhotos)
        } catch let error {
            return .failure(error)
        }
    }
    
    //MARK: - Data binding in model from JSON Object -
    private func parseImage(jsonObject: JSON?) -> Photo? {
        guard
            let id = jsonObject?["ID"].string,
            let title = jsonObject?["title"].string,
            let imageURL = jsonObject?["imageURL"].string,
            let description = jsonObject?["description"].string
        else {
            return nil
        }
        return Photo(id: id, imageURL: imageURL, title: title, description: description)
    }
}
