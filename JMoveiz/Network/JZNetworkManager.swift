//
//  JZNetworkManager.swift
//  JMoveiz
//
//  Created by Mahmoud Eissa on 12/30/23.
//

import ESNetworkManager
import Alamofire


final class JZNetworkManager: ESNetworkManager {

   private static var session: Session = .default
    
    override class var Manager: Session {
        return session
    }
    
    override class func map(_ response: AFDataResponse<Data>) -> ESNetworkResponse<JSON> {
        if let error = response.error {
            return .failure(error)
        }
      
        let json = JSON(response.value)
        
        let status: Bool = json.success.value() ?? true
    
        guard status else {
            let message = json.status_message.value() ?? ""
            let code = json.status_code.value() ?? 0
            return  .failure(NSError.init(error: message, code: code))
        }
        
        switch response.response?.statusCode ?? 500 {
        case 200...300:
            return .success(json)
        case let code:
            return  .failure(NSError.init(error: "unexpected status code \(code)", code: code))
        }
    }
}

extension JZNetworkManager {
    static func configure(_ configuration: URLSessionConfiguration) {
        JZNetworkManager.session = Session(configuration: configuration)
    }
}

extension ESNetworkRequest {
    convenience init(path: String) {
        self.init(url: [NetworkConstants.url, path].joined(separator: "/"))
        self.parameters = ["api_key": NetworkConstants.apiKey]
    }
}
