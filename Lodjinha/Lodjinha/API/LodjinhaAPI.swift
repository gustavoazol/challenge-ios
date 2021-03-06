//
//  LodjinhaAPI.swift
//  Lodjinha
//
//  Created by Gustavo Azevedo de Oliveira on 10/03/19.
//  Copyright © 2019 Gustavo Azevedo de Oliveira. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

struct LodjinhaAPI {
    private static let provider = MoyaProvider<APIServices>()
    
    static func getHomeBanners(completion: @escaping (_ banners: [BannerModel]?)->Void) {
        provider.request(.getBanners) { (result) in
            switch result {
            case .success(let response):
                do {
                    let fileteredResponse = try response.filterSuccessfulStatusCodes()
                    let bannersJson = try JSON(data: fileteredResponse.data)
                    
                    let bannersList = bannersJson["data"]
                    let bannersListData = try bannersList.rawData()
                    
                    let banners = try JSONDecoder().decode([BannerModel].self, from: bannersListData)
                    completion(banners)
                }
                catch {
                    print("Status code problem: " + error.localizedDescription)
                    completion(nil)
                }
                
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
    
    static func getHomeCategories(completion: @escaping (_ categories: [CategoryModel]?)->Void) {
        provider.request(.getCategories) { (result) in
            switch result {
            case .success(let response):
                do {
                    let fileteredResponse = try response.filterSuccessfulStatusCodes()
                    let categoriesJson = try JSON(data: fileteredResponse.data)
                    
                    let categoriesList = categoriesJson["data"]
                    let categoriesListData = try categoriesList.rawData()
                    
                    let categories = try JSONDecoder().decode([CategoryModel].self, from: categoriesListData)
                    completion(categories)
                }
                catch {
                    print("Status code problem: " + error.localizedDescription)
                    completion(nil)
                }
                
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
    static func getMostSoldProducts(completion: @escaping (_ products: [ProductModel]?)->Void) {
        provider.request(.getMostSoldProducts) { (result) in
            switch result {
            case .success(let response):
                do {
                    let fileteredResponse = try response.filterSuccessfulStatusCodes()
                    let productsJson = try JSON(data: fileteredResponse.data)
                    
                    let productsList = productsJson["data"]
                    let productsListData = try productsList.rawData()
                    
                    let products = try JSONDecoder().decode([ProductModel].self, from: productsListData)
                    completion(products)
                }
                catch {
                    print("Status code problem: " + error.localizedDescription)
                    completion(nil)
                }
                
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }
    
    static func getCategoryProducts(categoryId: Int, limit: Int?, offset: Int?, completion: @escaping (_ products: [ProductModel]?, _ total: Int)->Void) {
        provider.request(.getCategoryProducts(categoryId: categoryId, limit: limit, offset: offset)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let fileteredResponse = try response.filterSuccessfulStatusCodes()
                    let productsJson = try JSON(data: fileteredResponse.data)
                    
                    let productsList = productsJson["data"]
                    let productsListData = try productsList.rawData()
                    
                    let products = try JSONDecoder().decode([ProductModel].self, from: productsListData)
                    
                    let total = productsJson["total"].intValue
                    completion(products, total)
                }
                catch {
                    print("Status code problem: " + error.localizedDescription)
                    completion(nil, 0)
                }
                
            case .failure(let error):
                print(error)
                completion(nil, 0)
            }
        }
    }
    
    static func reserveProduct(productId: Int, completion: @escaping (_ success: Bool)->Void) {
        provider.request(.reserveProduct(productId: productId)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    print(filteredResponse.debugDescription)
                    completion(true)
                }
                catch {
                    print("Status code problem: " + error.localizedDescription)
                    completion(false)
                }
                
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
