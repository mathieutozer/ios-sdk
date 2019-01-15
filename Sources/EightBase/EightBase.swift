import Foundation
import Auth0
import Apollo
import ApolloAlamofire
//import TransactionStore

var credentialsManager = CredentialsManager(authentication: Auth0.authentication())
var isBioAuthEnabled = false

private var eightBaseEndPoint: String? = nil
private var eightBaseApiToken: String? = nil

public enum EightBaseResult {
    case success()
    case failure(error: Error)
}

public enum EightBaseError: CustomNSError {
    case noEndpointFound
    case cantStoreCredentials
    case invalidCredentials
    case cancelled
}

public func enableBiometrics(withTitle title: String, cancelTitle: String? = nil, fallbackTitle: String? = nil) {
    isBioAuthEnabled = true
    credentialsManager.enableBiometrics(withTitle: title, cancelTitle: cancelTitle, fallbackTitle: fallbackTitle)
}

public func auth(with endPoint: String, apiToken: String?, callback: @escaping (EightBaseResult) -> Void) {
    eightBaseEndPoint = endPoint
    eightBaseApiToken = apiToken
    
    Auth0
        .webAuth()
        .scope("openid profile email offline_access")
        .start { result in
            switch result {
            case .success(let credentials):
                if (!credentialsManager.store(credentials: credentials)) {
                    print("Failed to store credentials")
                    return callback(EightBaseResult.failure(error: EightBaseError.cantStoreCredentials))
                } else {
                    return initApollo(with: credentials, callback: callback)
                }
            case .failure(let error):
                _ = credentialsManager.clear()
                return callback(EightBaseResult.failure(error: error))
            }
    }
}

var apollo: ApolloClient? = nil
public var Apollo: ApolloClient? {
    get {
        return apollo
    }
    set(newValue) {
        apollo = newValue
    }
}

public func initApollo(with credentials: Credentials, callback: @escaping (EightBaseResult) -> Void) {
    guard eightBaseEndPoint != nil else {
        return callback(EightBaseResult.failure(error: EightBaseError.noEndpointFound))
    }
    guard credentialsManager.hasValid() else {
        return callback(EightBaseResult.failure(error: EightBaseError.invalidCredentials))
    }
    let url = URL(string: eightBaseEndPoint!)!
    var headers: [String: String]? = nil
    if eightBaseApiToken != nil {
        headers = ["Authorization": eightBaseApiToken!]
    }
    else {
        var idToken: String? = nil
        credentialsManager.credentials { error, credentials in
            guard error == nil, let credentials = credentials else {
//            print("Failed to instantly retrieve the credentials with error: \(String(describing: error))")
                return callback(EightBaseResult.failure(error: error!))
            }
//
            idToken = credentials.idToken
            headers = ["Authorization": "Bearer \(idToken!)"]
        }
    }
    let transport = AlamofireTransport(url: url, headers: headers)
    let client = ApolloClient(networkTransport: transport)
    Apollo = client
}

public func resumeAuth(_ url: URL, options: [A0URLOptionsKey: Any]) -> Bool {
    return Auth0.resumeAuth(url, options: options)
}
