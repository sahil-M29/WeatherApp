//
//  Created by Sahil Mirchandani on 3/08/21.
//

import Foundation
protocol NetworkClientProtocol{
    func getData(city: String, completion: @escaping (DataModel?) -> Void)
    func checkResponse(data: Data?, httpResponse: HTTPURLResponse?, error : Error?) -> Bool
}



struct NetworkClient:NetworkClientProtocol {
    
    let networkManger = NetworkManager()
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
        
        let url = createURL(city: city)
        networkManger.getJson(URLString: url, postRequest: nil) { (responseData, response, error) in
            print("NetworkClient: Got response")
            if(checkResponse(data: responseData, httpResponse: response, error: error)){
                do{
                    let result = try decoder.decode(DataModel.self, from: responseData!)
                    completion(result)
                }catch{
                    print("Error serializing data")
                    completion(nil)
                }
                
            }else{
                print("Error in response")
                completion(nil)
            }
            
        }
        
    }
    
}
