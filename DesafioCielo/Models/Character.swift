import Foundation

public struct Character: Codable {
  
  public let id: Int?
  public let name: String?
  public let description: String?
  public let thumbnail: Image?
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case description
    case thumbnail
  }
  
}
