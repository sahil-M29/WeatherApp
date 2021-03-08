//
//  MockNetworkClient.swift
//  Lowe's_QuestionTests
//
//  Created by Sahil Mirchandani on 2/27/21.
//

import Foundation
@testable import Lowe_s_Question

struct MockNetworkClient:NetworkClientProtocol {
    
    let decoder = JSONDecoder()
    
    func checkResponse(data: Data?, httpResponse: HTTPURLResponse?, error : Error?) -> Bool{
        if(error != nil){
            return false
        }
        if(data == nil){
            return false
        }
        if( httpResponse?.statusCode != 200){
            return false
        }
        return true
    }
    
    
    func getData(city: String, completion: @escaping (DataModel?) -> Void){
        if let path = Bundle.main.url(forResource: "test", withExtension: "json"){
            do {
                  let data = try Data(contentsOf: path, options: .mappedIfSafe)
                  let jsonResult = try decoder.decode(DataModel.self, from: data)
                completion(jsonResult)
              } catch {
                print("cannot serialize")
                   completion(nil)
              }
        }else{
            print("path incorrect")
            completion(nil)
        }
        
    }
}
