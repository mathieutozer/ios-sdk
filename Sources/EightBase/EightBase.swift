import Foundation
import Auth0
import Apollo
import ApolloAlamofire
//import TransactionStore

let credentialsManager = CredentialsManager(authentication: Auth0.authentication())

private var baseEndPoint: String? = nil

public func auth(with endPoint: String) {
    baseEndPoint = endPoint
    
    guard let clientInfo = plistValues(bundle: Bundle.main) else { return }

    Auth0
        .webAuth()
        .scope("openid profile offline_access")
        .audience("https://" + clientInfo.domain + "/userinfo")
        .start { result in
            switch result {
            case .success(let credentials):
                print("Obtained credentials: \(credentials)")
                _ = credentialsManager.store(credentials: credentials)
                initApollo()
            case .failure(let error):
                print("Failed with \(error)")
            }
    }
}

func plistValues(bundle: Bundle) -> (clientId: String, domain: String)? {
    guard
        let path = bundle.path(forResource: "Auth0", ofType: "plist"),
        let values = NSDictionary(contentsOfFile: path) as? [String: Any]
        else {
            print("Missing Auth0.plist file with 'ClientId' and 'Domain' entries in main bundle!")
            return nil
    }
    
    guard
        let clientId = values["ClientId"] as? String,
        let domain = values["Domain"] as? String
        else {
            print("Auth0.plist file at \(path) is missing 'ClientId' and/or 'Domain' entries!")
            print("File currently has the following entries: \(values)")
            return nil
    }
    return (clientId: clientId, domain: domain)
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

func initApollo() {
    guard baseEndPoint != nil else {
        print("Endpoint undefined")
        return
    }
    let url = URL(string: baseEndPoint!)!
    let client = ApolloClient(networkTransport: AlamofireTransport(url: url))
    Apollo = client
}

//    @objc public func resumeAuth(_ url: URL, options: [A0URLOptionsKey: Any]) -> Bool {
//        return TransactionStore.shared.resume(url, options: options)
//    }
