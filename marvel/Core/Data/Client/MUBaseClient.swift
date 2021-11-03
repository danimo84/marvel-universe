//
//  MUBaseClient.swift
//  marvel
//
//  Created by Daniel Moraleda on 29/10/21.
//

import Foundation
import Alamofire

class MUBaseClient {
    
    // MARK: -Public methods
    
    func request(_ endpoint: MUEndpoint, attempt: Int = 0, maxNumberOfTries: Int = 3, delayTimeBetweenTries: UInt32 = 3, _ completion: @escaping (_ response: MUAPIResponse?, _ error: MUAPIException?) -> Void) {
        
        let url = String(format: "%@/%@/%@", endpoint.host, endpoint.version, endpoint.path)
        AF.request(url,
                   method: endpoint.method,
                   parameters: endpoint.parameters,
                   encoding: endpoint.encoding,
                   headers: nil)
            .validate().responseData { response in
                switch response.result {
                case .success:
                    completion(MUAPIResponse(data: response.data), nil)
                case .failure:
                    if let data = response.data {
                        do {
                            if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                if let code = dictionary["code"] as? Int {
                                    completion(nil, self.checkErrorCode(code))
                                } else {
                                    completion(nil, .unknownException)
                                }
                            }
                        } catch let exception {
                            completion(nil, exception as? MUAPIException)
                        }

                    }
                }
                print("--API REQUEST--")
                print("ATTEMPT - \(attempt)")
                print("REQUEST - [\(endpoint.method)] \(url) - \(String(describing: response.response?.statusCode))")
                print("PARAMS - \(String(describing: endpoint.parameters))")
                print("RESPONSE - \(response.description)")
                print("---------------")
            }
    }
    
    // MARK: -Private methods
    
    private func checkErrorCode(_ code: Int) -> MUAPIException {
        
        if let error = MUAPIErrorCode(rawValue: code) {
            switch error {
            case .forbidden:
                return .forbiddenException
            case .notFound:
                return .characterNotFoundException
            }
        }
        return .unknownException
    }
}
