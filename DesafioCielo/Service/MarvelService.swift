import Foundation
import Moya
import RxSwift
import CryptoSwift

fileprivate struct MarvelAPIConfig {
  
  static let privatekey = "0e3b6a4ba5dd54e8361b849efce73639fe337edb"
  static let apikey = "ab7c2f12650fe730f24dca8a85fc49f4"
  static let ts = Date().timeIntervalSince1970.description
  static let hash = "\(ts)\(privatekey)\(apikey)".md5()
}

enum MarvelService {
  case characters
}

extension MarvelService: TargetType {
  var baseURL: URL { return URL(string: "https://gateway.marvel.com:443/v1/public")! }
  var path: String {
    switch self {
    case .characters:
      return "/characters"
    }
  }
  var method: Moya.Method {
    switch self {
    case .characters:
      return .get
    }
  }
  
  func authParameters() -> [String: String] {
    return ["apikey": MarvelAPIConfig.apikey,
            "ts": MarvelAPIConfig.ts,
            "hash": MarvelAPIConfig.hash]
  }
  
  var task: Task {
    
    switch self {
    case .characters:
      return .requestParameters(parameters: authParameters(), encoding: URLEncoding.queryString)
    }
  }
  
  var sampleData: Data {
    switch self {
    case .characters:
      return "".utf8Encoded
    }
  }
  var headers: [String: String]? {
    return ["Content-type": "application/json"]
  }
}
// MARK: - Helpers
private extension String {
  var urlEscaped: String {
    return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }
  
  var utf8Encoded: Data {
    return data(using: .utf8)!
  }
}
