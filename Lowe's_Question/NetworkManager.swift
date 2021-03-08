//
//  Created by Sahil Mirchandani on 3/08/21.
//

import Foundation

struct NetworkManager {
    typealias ResponseHandler = (Data?, HTTPURLResponse?, Error?) -> Void
    
    func getJson(URLString: String, postRequest: [String:Any]?, completion: @escaping ResponseHandler){
        
        // Create a data for post Request in Json format from [String:Any] format
        var postRequestData: Data? = nil
        if let postRequest = postRequest{
            let json: [String: Any] = postRequest
            do{
                // convering into json format
                postRequestData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            }catch{print("Error in serializing postRequest"); return}
        }
        
        
        //Creating a URL request
        var request : URLRequest? = nil
        if let url = URL(string: URLString){
            request = URLRequest(url: url)
            
            //If its a post request then making the request post
            if let postRequestData = postRequestData{
                request?.httpMethod = "POST"
                request?.httpBody = postRequestData
                request?.addValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            request?.addValue("application/json", forHTTPHeaderField: "Accept")
            
        }else{print("Error in URL string");return}
        
        if let request = request {
            URLSession.shared.dataTask(with: request) { data, response, error in
                //Checking response
                guard let httpResponse = response as? HTTPURLResponse else {
                    let userInfo = [NSLocalizedDescriptionKey : NSLocalizedString("Missing HTTP Response", comment: "")]
                    let error = NSError(domain: "Networking Error", code: 1, userInfo: userInfo)
                    completion(nil, nil, error as Error)
                    return
                }
                //Checking Data
                if data == nil {
                    completion(nil, httpResponse, error)
                }else {
                    if(httpResponse.statusCode == 200){
                        if let data = data {
                            //Sending data
                            completion(data,httpResponse,nil)
                        }else{print("error serializing")}
                    }else{
                        completion(nil, httpResponse, error)
                    }
                }
            }.resume()
        }
    }
}

