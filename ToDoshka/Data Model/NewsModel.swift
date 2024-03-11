//
//  NewsModel.swift
//  ToDoshka
//
//  Created by Bhavananda Das on 10.03.2024.
//

import UIKit


struct APIRes: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String
    //    let url: String
    let urlToImage: URL?
    //    let pubishedAt: String
    
}

struct Source: Codable {
    let name: String
    
}
