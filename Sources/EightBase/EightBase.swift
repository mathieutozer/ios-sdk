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
    guard credentialsManager.hasValid() else {
        print("Invalid credentials")
        return
    }
    var idToken: String? = nil
    credentialsManager.credentials { error, credentials in
        guard error == nil, let credentials = credentials else {
            print("Failed to instantly retrieve the credentials with error: \(String(describing: error))")
            return
        }
        // Valid credentials, you can access the token properties such as `idToken`, `accessToken`.
        idToken = credentials.idToken
    }
    let url = URL(string: baseEndPoint!)!
//    let headers = ["Authorization": "bearer \(idToken!)"]
    let headers = ["Authorization": "e4146738-2858-42a4-9932-3464de3d5739"]
    let transport = AlamofireTransport(url: url, headers: headers)
    let client = ApolloClient(networkTransport: transport)
    Apollo = client
}

//    @objc public func resumeAuth(_ url: URL, options: [A0URLOptionsKey: Any]) -> Bool {
//        return TransactionStore.shared.resume(url, options: options)
//    }
