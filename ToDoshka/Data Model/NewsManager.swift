//
//  NewsManager.swift
//  ToDoshka
//
//  Created by Bhavananda Das on 11.03.2024.
//

import UIKit

class NewsManager {
    
    
    let newsURL = URL(string: "https://newsapi.org/v2/everything?q=Apple&from=2024-03-10&sortBy=popularity&apiKey=4e17082ef3a9499aa8b40698e10245b2")
    
    func fetchAPIData(URL url:String, completion: @escaping (APIRes) -> Void) {
        
        let url = URL(string: url)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response , error in
            if data != nil && error == nil {
                do {
                    let parsingData = try JSONDecoder().decode(APIRes.self, from: data!)
                    completion(parsingData)
                } catch {
                    print(error.localizedDescription)
             
                }
            }
        }
        dataTask.resume()
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                } else {
                   
                }
            }}
    }
}
